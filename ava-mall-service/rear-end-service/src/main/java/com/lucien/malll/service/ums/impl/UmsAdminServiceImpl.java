package com.lucien.malll.service.ums.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.lucien.mall.dto.ums.UmsAdminFront;
import com.lucien.mall.dto.ums.UmsAdminLoginDto;
import com.lucien.mall.dto.ums.UmsAdminRegisterDto;
import com.lucien.mall.dto.ums.UpdateAdminPasswordDto;
import com.lucien.mall.mapper.UmsAdminMapper;
import com.lucien.mall.mapper.UmsAdminRoleRelationMapper;
import com.lucien.mall.pojo.*;
import com.lucien.mall.utils.JWTUtils;
import com.lucien.mall.utils.RedisUtils;
import com.lucien.malll.service.ums.UmsAdminRoleRelationService;
import com.lucien.malll.service.ums.UmsAdminService;
import io.lettuce.core.RedisException;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.DigestUtils;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author Lucien
 * @Date 2021/8/21
 * 后台用户service实现类
 */
@Service
public class UmsAdminServiceImpl implements UmsAdminService {

    @Autowired
    private UmsAdminMapper adminMapper;

    @Autowired
    private UmsAdminRoleRelationMapper roleRelationMapper;

    @Autowired
    private UmsAdminRoleRelationService roleRelationService;

    @Autowired
    private RedisUtils redisUtils;

    /**
     * 根据用户名获取后台管理员
     * @param username
     * @return
     */
    @Override
    public UmsAdmin getAdminByUsername(String username) {
        UmsAdminExample example = new UmsAdminExample();
        example.createCriteria().andUsernameEqualTo(username);
        List<UmsAdmin> umsAdmins = adminMapper.selectByExample(example);
        if (umsAdmins.size() > 0 && !StringUtils.isEmpty(umsAdmins)) {
            return umsAdmins.get(0);
        }

        return null;
    }

    /**
     * 用户登录
     * @return 生成的jwt token
     * -1用户名错误
     */
    @Override
    public String login(UmsAdminLoginDto dto) {
        UmsAdmin umsAdmin = getAdminByUsername(dto.getUsername());
        if (StringUtils.isEmpty(umsAdmin)){
            return "-1";
        }
        Subject subject = SecurityUtils.getSubject();

        UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(dto.getUsername(), DigestUtils.md5DigestAsHex(dto.getPassword().getBytes()));

        boolean loginSuccess = false;

        try {
            subject.login(usernamePasswordToken);
            loginSuccess = true;

        } catch (UnknownAccountException | IncorrectCredentialsException uae) { // 账号不存在 // 账号与密码不匹配
            return "-2";
        } catch (LockedAccountException lae) { // 账号已被锁定
            return "-3";
        } catch (AuthenticationException ae) { // 其他身份验证异常
            ae.printStackTrace();
            return "-4";
        } catch (Exception e) {
            return "-5";
        }

        if (loginSuccess) {
            String token = JWTUtils.sign(dto.getUsername(), JWTUtils.SECRET);
            try {
                redisUtils.setCacheObject("TOKENADMIN:" + token, JSON.toJSON(umsAdmin));
                redisUtils.expire("TOKENADMIN:" + token, JWTUtils.EXPIRE_TIME);
            } catch (RedisException e) {
                e.printStackTrace();
            }
            return token;
        }

        return "登录失败！";
    }

    /**
     * 用户注册
     *
     * @param umsAdminRegisterDto
     * @return
     */
    @Override
    public UmsAdmin register(UmsAdminRegisterDto umsAdminRegisterDto) {
        UmsAdmin umsAdmin = new UmsAdmin();
        BeanUtils.copyProperties(umsAdminRegisterDto, umsAdmin);
        umsAdmin.setCreateTime(new Date());
        umsAdmin.setStatus(1);

        //检查重复名
        UmsAdminExample umsAdminExample = new UmsAdminExample();
        umsAdminExample.createCriteria().andUsernameEqualTo(umsAdminRegisterDto.getUsername());
        List<UmsAdmin> adminList = adminMapper.selectByExample(umsAdminExample);

        if (adminList.size() > 0) {
            return null;
        }
        //使用springboot自带md5加密方式加密用户密码
        String md5Password = DigestUtils.md5DigestAsHex(umsAdminRegisterDto.getPassword().getBytes());
        umsAdmin.setPassword(md5Password);
        adminMapper.insert(umsAdmin);

        List<UmsAdmin> umsAdmins = adminMapper.selectByExample(umsAdminExample);
        UmsAdmin registerAdmin = umsAdmins.get(0);
        System.out.println(registerAdmin.getId());
        roleRelationService.insert(registerAdmin.getId(), Long.valueOf(5));

        return umsAdmin;
    }


    /**
     * 根据用户id获取用户
     * @param id
     * @return
     */
    @Override
    public UmsAdmin getItem(Long id) {
        return adminMapper.selectByPrimaryKey(id);
    }

    /**
     * 修改指定用户信息
     * @param id
     * @param admin
     * @return
     */
    @Override
    public int update(Long id, UmsAdmin admin) {
        admin.setId(id);
        UmsAdmin umsAdmin = adminMapper.selectByPrimaryKey(id);
        String newPaw = DigestUtils.md5DigestAsHex(admin.getPassword().getBytes());
        if (newPaw.equals(umsAdmin.getPassword())) {
            admin.setPassword(null);
        } else {
            if (StrUtil.isEmpty(admin.getPassword())) {
                admin.setPassword(null);
            } else {
                admin.setPassword(newPaw);
            }
        }
        int result = adminMapper.updateByPrimaryKey(umsAdmin);

        return result;
    }

    /**
     * 删除指定用户
     * @param id
     * @return
     */
    @Override
    public int delete(Long id) {
        return adminMapper.deleteByPrimaryKey(id);
    }

    /**
     * 获取用户对应角色
     * @param adminId
     * @return
     */
    @Override
    public List<UmsRole> getRoleList(Long adminId) {
        return roleRelationMapper.getRoleList(adminId);
    }

    /**
     * 获取指定用户的可访问资源
     * @param adminId
     * @return
     */
    @Override
    public List<UmsResource> getResourceList(Long adminId) {
        List<UmsResource> resourceList = roleRelationMapper.getResourceList(adminId);
        return resourceList;
    }

    /**
     *修改密码
     *-1输入参数错误
     *-2查询不到用户
     *-3旧密码输入错误
     * 4新旧密码相同
     * @param dto
     * @return
     */
    @Override
    public int updatePassword(UpdateAdminPasswordDto dto) {
        if (StrUtil.isEmpty(dto.getUsername()) ||
                StrUtil.isEmpty(dto.getNewPassword()) ||
                StrUtil.isEmpty(dto.getOldPassword())) {
            return -1;
        }
        UmsAdminExample example = new UmsAdminExample();
        example.createCriteria().andUsernameEqualTo(dto.getUsername());
        List<UmsAdmin> umsAdmins = adminMapper.selectByExample(example);

        if (CollUtil.isEmpty(umsAdmins)){
            return -2;
        }

        UmsAdmin umsAdmin = umsAdmins.get(0);
        if (!StrUtil.equals(DigestUtils.md5DigestAsHex(dto.getOldPassword().getBytes()), umsAdmin.getPassword())){
            return -3;
        }
        if(StrUtil.equals(dto.getOldPassword(), dto.getNewPassword())){
            return -4;
        }

        umsAdmin.setPassword(DigestUtils.md5DigestAsHex(dto.getNewPassword().getBytes()));
        adminMapper.updateByPrimaryKey(umsAdmin);

        return 1;
    }

    /**
     * 修改账号状态
     * @param id
     * @param status
     * @return
     */
    @Override
    public int updateStatus(Long id, Integer status) {
        UmsAdmin umsAdmin = adminMapper.selectByPrimaryKey(id);
        umsAdmin.setStatus(status);

        int result = adminMapper.updateByPrimaryKey(umsAdmin);

        return result;
    }

    /**
     * 退出登录
     * @param token
     * @return
     */
    @Override
    public int logout(String token) {
        try {
            if (StringUtils.isEmpty(redisUtils.getCacheObject("TOKENADMIN:" + token))){
                return 1;
            }
            redisUtils.deleteObject("TOKENADMIN:" + token);
            Subject subject = SecurityUtils.getSubject();
            subject.logout();
        }catch (Exception e){
            e.printStackTrace();
        }
        return 1;
    }

    /**
     * 更新用户登录时间
     * @param adminId
     * @return
     */
    @Override
    public int updateLoginTime(Long adminId) {
        UmsAdmin umsAdmin = adminMapper.selectByPrimaryKey(adminId);
        umsAdmin.setLoginTime(new Date());

        return adminMapper.updateByPrimaryKey(umsAdmin);
    }

    /**
     * 获取当前登录的用户信息
     * @return
     */
    @Override
    public UmsAdminFront getInfo() {
        UmsAdminFront adminFront = new UmsAdminFront();
        UmsAdmin umsAdmin = (UmsAdmin) SecurityUtils.getSubject().getPrincipal();
        BeanUtils.copyProperties(umsAdmin, adminFront);
        List<UmsRole> roleList = getRoleList(umsAdmin.getId());
        List<String> roles = roleList.stream().map(UmsRole::getName).collect(Collectors.toList());
        adminFront.setRoles(roles);
        return adminFront;
    }

    /**
     * 修改用户角色关系
     * @param adminId
     * @param roleIds
     * @return
     */
    @Override
    public int updateRole(Long adminId, List<Long> roleIds) {
        int count = roleIds == null ? 0 : roleIds.size();
        //删除原来的角色关系
        UmsAdminRoleRelationExample roleRelationExample = new UmsAdminRoleRelationExample();
        roleRelationExample.createCriteria().andAdminIdEqualTo(adminId);
        roleRelationMapper.deleteByExample(roleRelationExample);

        if (!CollectionUtils.isEmpty(roleIds)){
            List<UmsAdminRoleRelation> list = new ArrayList<>();
            for (Long roleId : roleIds) {
                UmsAdminRoleRelation roleRelation = new UmsAdminRoleRelation();
                roleRelation.setAdminId(adminId);
                roleRelation.setRoleId(roleId);
                list.add(roleRelation);
            }
            roleRelationMapper.insertList(list);
        }
        return count;
    }

    /**
     * 根据用户名或姓名分页获取用户列表
     * @param keyword
     * @param pageSize
     * @param pageNum
     * @return
     */
    @Override
    public List<UmsAdmin> list(String keyword, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        UmsAdminExample example = new UmsAdminExample();
        UmsAdminExample.Criteria criteria = example.createCriteria();
        if (!StringUtils.isEmpty(keyword)){
            criteria.andUsernameLike('%' + keyword + '%');
            example.or(example.createCriteria().andNickNameLike('%' + keyword + '%'));
        }
        return adminMapper.selectByExample(example);
    }
}
