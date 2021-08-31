package com.lucien.mall.service.impl;

import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.mapper.UmsMemberMapper;
import com.lucien.mall.mapper.UmsMenuMapper;
import com.lucien.mall.pojo.UmsMember;
import com.lucien.mall.pojo.UmsMemberExample;
import com.lucien.mall.service.UmsMemberService;
import com.lucien.mall.utils.JWTUtils;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.util.Date;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/31
 * 前端会会员管理Impl
 */
@Service
public class UmsMemberServiceImpl implements UmsMemberService {

    @Autowired
    private UmsMemberMapper memberMapper;

    @Autowired
    private JWTUtils jwtUtils;

    /**
     * 根据用户名获取会员
     * @param username
     * @return
     */
    @Override
    public UmsMember getByUsername(String username) {
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
        return null;
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


        return "";
    }

    /**
     * 根据会员编号获取会员
     * @param id
     * @return
     */
    @Override
    public UmsMember getById(Long id) {
        return null;
    }
}
