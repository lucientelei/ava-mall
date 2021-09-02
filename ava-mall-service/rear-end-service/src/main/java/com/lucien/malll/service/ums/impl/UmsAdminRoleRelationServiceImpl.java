package com.lucien.malll.service.ums.impl;

import com.lucien.mall.mapper.UmsAdminRoleRelationMapper;
import com.lucien.mall.pojo.UmsAdminRoleRelation;
import com.lucien.malll.service.ums.UmsAdminRoleRelationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author Lucien
 * @Date 2021/8/23
 */
@Service
public class UmsAdminRoleRelationServiceImpl implements UmsAdminRoleRelationService {

    @Autowired
    private UmsAdminRoleRelationMapper roleRelationMapper;

    /**
     * 新增用户角色关系
     * @param adminId
     * @param roleId
     * @return
     */
    @Override
    public int insert(Long adminId, Long roleId) {
        UmsAdminRoleRelation roleRelation = new UmsAdminRoleRelation();
        roleRelation.setAdminId(adminId);
        roleRelation.setRoleId(roleId);

        return roleRelationMapper.insert(roleRelation);
    }
}
