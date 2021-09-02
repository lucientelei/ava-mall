package com.lucien.malll.service.ums.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.mapper.*;
import com.lucien.mall.pojo.*;
import com.lucien.malll.service.ums.UmsRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/30
 * 后台角色管理Impl
 */
@Service
public class UmsRoleServiceImpl implements UmsRoleService {

    @Autowired
    private UmsRoleMapper roleMapper;

    @Autowired
    private UmsMenuMapper menuMapper;

    @Autowired
    private UmsRoleMenuRelationMapper menuRelationMapper;

    @Autowired
    private UmsRoleResourceRelationMapper roleResourceRelationMapper;


    /**
     * 获取所有角色列表
     * @return
     */
    @Override
    public List<UmsRole> listAll() {
        return roleMapper.selectByExample(new UmsRoleExample());
    }

    /**
     * 分页获取角色列表
     * @param keyWord
     * @param pageSize
     * @param pageNum
     * @return
     */
    @Override
    public List<UmsRole> list(String keyWord, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        UmsRoleExample example = new UmsRoleExample();
        UmsRoleExample.Criteria criteria = example.createCriteria();
        criteria.andNameLike('%' + keyWord + '%');
        return roleMapper.selectByExample(example);
    }

    /**
     * 新增角色
     * @param umsRole
     * @return
     */
    @Override
    public int insert(UmsRole umsRole) {
        umsRole.setCreateTime(new Date());
        return roleMapper.insert(umsRole);
    }

    /**
     * 更新角色
     * @param id
     * @param umsRole
     * @return
     */
    @Override
    public int update(Long id, UmsRole umsRole) {
        umsRole.setId(id);
        return roleMapper.updateByPrimaryKeySelective(umsRole);
    }

    /**
     * 删除角色
     * @param id
     * @return
     */
    @Override
    public int del(Long id) {
        return roleMapper.deleteByPrimaryKey(id);
    }

    /**
     * 获取角色菜单
     * @param roleId
     * @return
     */
    @Override
    public List<UmsMenu> listMenu(Long roleId) {
        return roleMapper.getMenuListByRoleId(roleId);
    }

    /**
     * 根据管理员Id获取对应菜单
     * @param adminId
     * @return
     */
    @Override
    public List<UmsMenu> getMenuList(Long adminId) {
        return roleMapper.getMenuList(adminId);
    }

    /**
     * 获取角色资源
     * @param roleId
     * @return
     */
    @Override
    public List<UmsResource> listResource(Long roleId) {
       return roleMapper.getResourceListByRoleId(roleId);
    }

    /**
     * 给角色分配菜单
     * @param roleId
     * @param menuIds
     * @return
     */
    @Override
    public int allocMenu(Long roleId, List<Long> menuIds) {
        //先删除原有关系
        UmsRoleMenuRelationExample example=new UmsRoleMenuRelationExample();
        example.createCriteria().andRoleIdEqualTo(roleId);
        menuRelationMapper.deleteByExample(example);
        //批量插入新关系
        for (Long menuId : menuIds) {
            UmsRoleMenuRelation relation = new UmsRoleMenuRelation();
            relation.setRoleId(roleId);
            relation.setMenuId(menuId);
            menuRelationMapper.insert(relation);
        }
        return menuIds.size();
    }

    /**
     * 给角色分配资源
     * @param roleId
     * @param resourceIds
     * @return
     */
    @Override
    public int allocResource(Long roleId, List<Long> resourceIds) {
        //先删除原有关系
        UmsRoleResourceRelationExample example=new UmsRoleResourceRelationExample();
        example.createCriteria().andRoleIdEqualTo(roleId);
        roleResourceRelationMapper.deleteByExample(example);
        //批量插入新关系
        for (Long resourceId : resourceIds) {
            UmsRoleResourceRelation relation = new UmsRoleResourceRelation();
            relation.setRoleId(roleId);
            relation.setResourceId(resourceId);
            roleResourceRelationMapper.insert(relation);
        }
        return resourceIds.size();
    }
}
