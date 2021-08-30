package com.lucien.malll.service;

import com.lucien.mall.pojo.UmsMenu;
import com.lucien.mall.pojo.UmsResource;
import com.lucien.mall.pojo.UmsRole;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/30
 * 后台角色管理Service
 */
public interface UmsRoleService {

    /**
     * 获取所有角色列表
     * @return
     */
    List<UmsRole> listAll();

    /**
     * 分页获取角色列表
     * @param keyWord
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<UmsRole> list(String keyWord, Integer pageSize, Integer pageNum);

    /**
     * 新增角色
     * @param umsRole
     * @return
     */
    int insert(UmsRole umsRole);

    /**
     * 更新角色
     * @param id
     * @param umsRole
     * @return
     */
    int update(Long id, UmsRole umsRole);

    /**
     * 删除角色
     * @param id
     * @return
     */
    int del(Long id);

    /**
     * 获取角色菜单
     * @param roleId
     * @return
     */
    List<UmsMenu> listMenu(Long roleId);

    /**
     * 获取角色资源
     * @param roleId
     * @return
     */
    List<UmsResource> listResource(Long roleId);
}
