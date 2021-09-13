package com.lucien.mall.front.service.ums.impl;

import com.alibaba.fastjson.JSON;
import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.mapper.UmsMemberLevelMapper;
import com.lucien.mall.mapper.UmsMemberMapper;
import com.lucien.mall.pojo.UmsMember;
import com.lucien.mall.pojo.UmsMemberExample;
import com.lucien.mall.pojo.UmsMemberLevel;
import com.lucien.mall.pojo.UmsMemberLevelExample;
import com.lucien.mall.utils.JWTUtils;
import com.lucien.mall.utils.RedisUtils;
import io.lettuce.core.RedisException;
import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/31
 * 前端会会员管理Impl
 */
@Service
@Primary
public class UmsMemberServiceImpl implements UmsMemberService {

    @Autowired
    private UmsMemberMapper memberMapper;

    @Autowired
    private UmsMemberLevelMapper memberLevelMapper;

    @Autowired
    private RedisUtils redisUtils;

    /**
     * 根据用户名获取会员
     * @param username
     * @return
     */
    @Override
    public UmsMember getByUsername(String username) {
        UmsMemberExample example = new UmsMemberExample();
        example.createCriteria().andUsernameEqualTo(username);
        List<UmsMember> umsMembers = memberMapper.selectByExample(example);
        if (!CollectionUtils.isEmpty(umsMembers)){
            return umsMembers.get(0);
        }
        return null;
    }

    /**
     * 会员登录
     * @param username
     * @param password
     * @return
     */
    @Override
    public String login(String username, String password) {
        UmsMember umsMember = getByUsername(username);
        if (StringUtils.isEmpty(umsMember)){
            return "不存在该用户";
        }
        Subject subject = SecurityUtils.getSubject();

        UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(username, DigestUtils.md5DigestAsHex(password.getBytes()));
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
            String token = JWTUtils.sign(username, JWTUtils.SECRET);
            try {
                redisUtils.set("TOKEN:" + token, String.valueOf(JSON.toJSON(umsMember)), JWTUtils.EXPIRE_TIME);
//                redisUtils.expire("TOKEN:" + token, JWTUtils.EXPIRE_TIME);
            } catch (RedisException e) {
                e.printStackTrace();
            }
            return token;
        }

        return "登录失败！";
    }

    /**
     * 会员注册
     * @param username
     * @param password
     * @param telephone
     */
    @Override
    public String register(String username, String password, String telephone) {
        UmsMemberExample example = new UmsMemberExample();
        example.createCriteria().andUsernameEqualTo(username);
        List<UmsMember> umsMembers = memberMapper.selectByExample(example);
        if (!CollectionUtils.isEmpty(umsMembers)){
            return "该用户已存在";
        }
        UmsMember umsMember = new UmsMember();
        umsMember.setUsername(username);
        umsMember.setPassword(DigestUtils.md5DigestAsHex(password.getBytes()));
        umsMember.setPhone(telephone);
        umsMember.setCreateTime(new Date());
        umsMember.setStatus(1);

        UmsMemberLevelExample levelExample = new UmsMemberLevelExample();
        levelExample.createCriteria().andDefaultStatusEqualTo(1);
        List<UmsMemberLevel> umsMemberLevels = memberLevelMapper.selectByExample(levelExample);
        if (!CollectionUtils.isEmpty(umsMemberLevels)){
            umsMember.setMemberLevelId(umsMemberLevels.get(0).getId());
        }
        memberMapper.insert(umsMember);
        return "注册成功";
    }

    /**
     * 根据会员编号获取会员
     * @param id
     * @return
     */
    @Override
    public UmsMember getById(Long id) {
        return memberMapper.selectByPrimaryKey(id);
    }

    /**
     * 会员退出登录
     * @param token
     * @return
     */
    @Override
    public int logout(String token) {
        try {
            if (StringUtils.isEmpty(redisUtils.get("TOKEN:" + token))){
                return 1;
            }
            redisUtils.del("TOKEN:" + token);
            Subject subject = SecurityUtils.getSubject();
            subject.logout();
        }catch (Exception e){
            e.printStackTrace();
        }
        return 1;
    }

    /**
     * 更新会员信息
     * @param id
     * @param umsMember
     * @return
     */
    @Override
    public int update(Long id, UmsMember umsMember) {
        umsMember.setId(id);
        int result = memberMapper.updateByPrimaryKeySelective(umsMember);
        return result;
    }

    /**
     * 获取当前登录会员
     * @return
     */
    @Override
    public UmsMember getCurrentMember() {
        UmsMember umsMember = (UmsMember) SecurityUtils.getSubject().getPrincipal();
        return umsMember;
    }

    /**
     * 根据用户ID更新用户积分
     * @param id
     * @param integration
     */
    @Override
    public void updateIntegration(Long id, Integer integration) {
        UmsMember member = new UmsMember();
        member.setId(id);
        member.setIntegration(integration);
        memberMapper.updateByPrimaryKeySelective(member);
    }
}
