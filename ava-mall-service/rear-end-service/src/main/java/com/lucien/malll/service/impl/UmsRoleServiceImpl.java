package com.lucien.malll.service.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.mapper.*;
import com.lucien.mall.pojo.*;
import com.lucien.malll.service.UmsRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
    private UmsResourceMapper resourceMapper;

    @Autowired
    private UmsRoleResourceRelationMapper resourceRelationMapper;

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
        List<UmsMenu> menuList = new ArrayList<>();

        UmsRoleMenuRelationExample example = new UmsRoleMenuRelationExample();
        example.createCriteria().andRoleIdEqualTo(roleId);
        List<UmsRoleMenuRelation> menuRelations = menuRelationMapper.selectByExample(example);

        for (UmsRoleMenuRelation menuRelation : menuRelations) {
            UmsMenu umsMenu = menuMapper.selectByPrimaryKey(menuRelation.getMenuId());
            menuList.add(umsMenu);
        }

        return menuList;
    }

    /**
     * 获取角色资源
     * @param roleId
     * @return
     */
    @Override
    public List<UmsResource> listResource(Long roleId) {
        List<UmsResource> resourceList = new ArrayList<>();

        UmsRoleResourceRelationExample example = new UmsRoleResourceRelationExample();
        example.createCriteria().andRoleIdEqualTo(roleId);
        List<UmsRoleResourceRelation> umsRoleResourceRelations = resourceRelationMapper.selectByExample(example);
        for (UmsRoleResourceRelation resourceRelation : umsRoleResourceRelations) {
            UmsResource umsResource = resourceMapper.selectByPrimaryKey(resourceRelation.getResourceId());
            resourceList.add(umsResource);
        }
        return resourceList;
    }
}
