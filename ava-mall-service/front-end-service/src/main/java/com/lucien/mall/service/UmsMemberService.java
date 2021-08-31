package com.lucien.mall.service;

import com.lucien.mall.pojo.UmsMember;

/**
 * @Author Lucien
 * @Date 2021/8/31
 * 前端会员管理Service
 */
public interface UmsMemberService {

    /**
     * 会员登录
     * @param username
     * @param password
     * @return
     */
    String login(String username, String password);

    /**
     * 会员注册
     * @param username
     * @param password
     * @param telephone
     */
    String register(String username, String password, String telephone);

    /**
     * 根据用户名获取会员
     * @param username
     * @return
     */
    UmsMember getByUsername(String username);

    /**
     * 根据会员编号获取会员
     * @param id
     * @return
     */
    UmsMember getById(Long id);

}
