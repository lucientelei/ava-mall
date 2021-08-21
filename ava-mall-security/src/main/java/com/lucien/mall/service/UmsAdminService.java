package com.lucien.mall.service;

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
     * 根据用户名获取后台管理员
     */
    UmsAdmin getAdminByUsername(String username);

    /**
     * 根据用户id获取用户
     */
    UmsAdmin getItem(Long id);

    /**
     * 修改指定用户信息
     */
    int update(Long id, UmsAdmin admin);

    /**
     * 删除指定用户
     */
    int delete(Long id);

    /**
     * 获取用户对应角色
     */
    List<UmsRole> getRoleList(Long adminId);

    /**
     * 获取指定用户的可访问资源
     */
    List<UmsResource> getResourceList(Long adminId);

    /**
     * 修改密码
     */
    int updatePassword(UpdateAdminPasswordDto updateAdminPasswordDto);


}
