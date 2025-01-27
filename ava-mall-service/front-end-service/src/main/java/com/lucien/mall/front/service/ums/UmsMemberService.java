package com.lucien.mall.front.service.ums;

import com.lucien.mall.pojo.UmsMember;

/**
 * @Author Lucien
 * @Date 2023/8/31
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

    /**
     * 会员退出登录
     * @param token
     * @return
     */
    int logout(String token);

    /**
     * 更新会员信息
     * @param id
     * @param umsMember
     * @return
     */
    int update(Long id, UmsMember umsMember);

    /**
     * 获取当前登录会员
     * @return
     */
    UmsMember getCurrentMember();

    /**
     * 根据用户ID更新用户积分
     * @param id
     * @param integration
     */
    void updateIntegration(Long id,Integer integration);
}
