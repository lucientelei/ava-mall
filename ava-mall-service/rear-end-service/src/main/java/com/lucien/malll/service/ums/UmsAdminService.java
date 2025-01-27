package com.lucien.malll.service.ums;


import com.lucien.mall.rear.ums.UmsAdminFront;
import com.lucien.mall.rear.ums.UmsAdminRegisterDto;
import com.lucien.mall.rear.ums.UmsAdminLoginDto;
import com.lucien.mall.rear.ums.UpdateAdminPasswordDto;
import com.lucien.mall.pojo.UmsAdmin;
import com.lucien.mall.pojo.UmsResource;
import com.lucien.mall.pojo.UmsRole;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/8/21
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
     * @return         生成的jwt token
     */
    String login(UmsAdminLoginDto dto);

    /**
     * 用户注册
     * @param umsAdminRegisterDto
     * @return
     */
    UmsAdmin register(UmsAdminRegisterDto umsAdminRegisterDto);

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
    UmsAdminFront getInfo();

    /**
     * 修改用户角色关系
     * @param adminId
     * @param roleIds
     * @return
     */
    int updateRole(Long adminId, List<Long> roleIds);

    /**
     * 根据用户名或姓名分页获取用户列表
     * @param keyword
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<UmsAdmin> list(String keyword, Integer pageSize, Integer pageNum);
}
