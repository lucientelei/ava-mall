package com.lucien.malll.service;

/**
 * @Author Lucien
 * @Date 2021/8/23
 */
public interface UmsAdminRoleRelationService {

    /**
     * 新增用户角色关系
     * @param adminId
     * @param roleId
     * @return
     */
    int insert(Long adminId, Long roleId);

}
