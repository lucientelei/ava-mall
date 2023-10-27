package com.lucien.malll.service.ums;

import com.lucien.mall.rear.ums.UmsMenuNode;
import com.lucien.mall.pojo.UmsMenu;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/8/26
 * 后台管理菜单
 */
public interface UmsMenuService {

    /**
     * 创建菜单
     * @param umsMenu
     * @return
     */
    int create(UmsMenu umsMenu);

    /**
     * 更新菜单
     * @param id
     * @param umsMenu
     * @return
     */
    int update(Long id, UmsMenu umsMenu);

    /**
     * 通过ID获取菜单详情
     * @param id
     * @return
     */
    UmsMenu getItem(Long id);

    /**
     * 根据ID删除菜单
     * @param id
     * @return
     */
    int delete(Long id);

    /**
     * 分页获取菜单
     * @param parentId
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<UmsMenu> list(Long parentId, Integer pageSize, Integer pageNum);

    /**
     * 修改菜单是否显示
     * @param id
     * @param hidden
     * @return
     */
    int updateHidden(Long id, Integer hidden);

    /**
     * 树形结构返回所有菜单列表
     * @return
     */
    List<UmsMenuNode> treeList();

}
