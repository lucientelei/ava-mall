package com.lucien.malll.service;


import com.lucien.mall.dto.UmsAdminDto;
import com.lucien.mall.dto.UpdateAdminPasswordDto;
import com.lucien.mall.pojo.UmsAdmin;
import com.lucien.mall.pojo.UmsResource;
import com.lucien.mall.pojo.UmsRole;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/21
 * 后台用户service
 */
public interface UmsAdminService {

    /**
     * 根据用户名获取后台管理员
     * @param username
     * @return
     */
    UmsAdmin getAdminByUsername(String username);

    /**
     * 用户登录
     * @param username 用户名
     * @param password 密码
     * @return         生成的jwt token
     */
    String login(String username, String password);

    /**
     * 用户注册
     * @param umsAdminDto
     * @return
     */
    UmsAdmin register(UmsAdminDto umsAdminDto);

    /**
     * 根据用户id获取用户
     * @param id
     * @return
     */
    UmsAdmin getItem(Long id);

    /**
     * 修改指定用户信息
     * @param id
     * @param admin
     * @return
     */
    int update(Long id, UmsAdmin admin);

    /**
     * 删除指定用户
     * @param id
     * @return
     */
    int delete(Long id);

    /**
     * 获取用户对应角色
     * @param adminId
     * @return
     */
    List<UmsRole> getRoleList(Long adminId);

    /**
     * 获取指定用户的可访问资源
     * @param adminId
     * @return
     */
    List<UmsResource> getResourceList(Long adminId);

    /**
     * 修改密码
     * @param updateAdminPasswordDto
     * @return
     */
    int updatePassword(UpdateAdminPasswordDto updateAdminPasswordDto);

    /**
     * 修改账号状态
     * @param id
     * @param status
     * @return
     */
    int updateStatus(Long id, Integer status);

    /**
     * 退出登录
     * @param token
     * @return
     */
    int logout(String token);

    /**
     * 更新用户登录时间
     * @param adminId
     * @return
     */
    int updateLoginTime(Long adminId);

    /**
     * 获取当前登录的用户信息
     * @return
     */
    UmsAdmin getUser();
}
