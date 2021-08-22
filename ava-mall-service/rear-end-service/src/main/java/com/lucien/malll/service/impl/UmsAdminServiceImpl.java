package com.lucien.malll.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.lucien.mall.dao.UmsAdminRoleRelationDao;
import com.lucien.mall.dto.UmsAdminDto;
import com.lucien.mall.dto.UpdateAdminPasswordDto;
import com.lucien.mall.mapper.UmsAdminLoginLogMapper;
import com.lucien.mall.mapper.UmsAdminMapper;
import com.lucien.mall.mapper.UmsAdminRoleRelationMapper;
import com.lucien.mall.pojo.UmsAdmin;
import com.lucien.mall.pojo.UmsAdminExample;
import com.lucien.mall.pojo.UmsResource;
import com.lucien.mall.pojo.UmsRole;
import com.lucien.mall.utils.JWTUtils;
import com.lucien.mall.utils.RedisUtils;
import com.lucien.malll.service.UmsAdminService;
import io.lettuce.core.RedisException;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

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
    private UmsAdminLoginLogMapper adminLoginLogMapper;

    @Autowired
    private UmsAdminRoleRelationDao roleRelationDao;

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
        if (umsAdmins.size() > 0 && StringUtils.isEmpty(umsAdmins)) {
            return umsAdmins.get(0);
        }

        return null;
    }

    /**
     * 用户登录
     *
     * @param username 用户名
     * @param password 密码
     * @return 生成的jwt token
     */
    @Override
    public String login(String username, String password) {
        UmsAdmin umsAdmin = getAdminByUsername(username);
//        Subject subject = ;

        UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(username, DigestUtils.md5DigestAsHex(password.getBytes()));

        boolean loginSuccess = false;

        try {
            SecurityUtils.getSubject().login(usernamePasswordToken);
            loginSuccess = true;

        } catch (UnknownAccountException | IncorrectCredentialsException uae) { // 账号不存在 // 账号与密码不匹配
            throw new UnknownAccountException("用户名与密码不匹配，请检查后重新输入！");
        } catch (LockedAccountException lae) { // 账号已被锁定
            throw new LockedAccountException("该账户已被锁定，如需解锁请联系管理员！");
        } catch (AuthenticationException ae) { // 其他身份验证异常
            throw new AuthenticationException("登录异常，请联系管理员！");
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (loginSuccess) {
            String token = JWTUtils.sign(username, JWTUtils.SECRET);
            try {
                redisUtils.setCacheObject("TOKEN:" + token, JSON.toJSON(umsAdmin));
                redisUtils.expire("TOKEN:" + token, JWTUtils.EXPIRE_TIME);
            } catch (RedisException e) {
                e.printStackTrace();
            }
            return token;
        }

        return null;
    }

    /**
     * 用户注册
     *
     * @param umsAdminDto
     * @return
     */
    @Override
    public UmsAdmin register(UmsAdminDto umsAdminDto) {
        UmsAdmin umsAdmin = new UmsAdmin();
        BeanUtils.copyProperties(umsAdminDto, umsAdmin);
        umsAdmin.setCreateTime(new Date());
        umsAdmin.setStatus(1);

        //检查重复名
        UmsAdminExample umsAdminExample = new UmsAdminExample();
        umsAdminExample.createCriteria().andUsernameEqualTo(umsAdminDto.getUsername());
        List<UmsAdmin> adminList = adminMapper.selectByExample(umsAdminExample);

        if (adminList.size() > 0) {
            return null;
        }
        //使用springboot自带md5加密方式加密用户密码
        String md5Password = DigestUtils.md5DigestAsHex(umsAdminDto.getPassword().getBytes());
        umsAdmin.setPassword(md5Password);
        adminMapper.insert(umsAdmin);

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
        return roleRelationDao.getRoleList(adminId);
    }

    /**
     * 获取指定用户的可访问资源
     * @param adminId
     * @return
     */
    @Override
    public List<UmsResource> getResourceList(Long adminId) {
        List<UmsResource> resourceList = roleRelationDao.getResourceList(adminId);
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
        if (StrUtil.equals(DigestUtils.md5DigestAsHex(dto.getOldPassword().getBytes()),umsAdmin.getPassword())){
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
}
