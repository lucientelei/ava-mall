package com.lucien.malll.service.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.mapper.UmsMenuMapper;
import com.lucien.mall.pojo.UmsMenu;
import com.lucien.mall.pojo.UmsMenuExample;
import com.lucien.malll.service.UmsMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/26
 */
@Service
public class UmsMenuServiceImpl implements UmsMenuService {

    @Autowired
    private UmsMenuMapper menuMapper;

    /**
     * 修改菜单等级
     * @param umsMenu
     */
    private void updateMenuLevel(UmsMenu umsMenu){
        if (umsMenu.getParentId() == 0){
            //设置为父级菜单
            umsMenu.setLevel(0);
        }else {
            //获取父级菜单
            UmsMenu parentMenu = menuMapper.selectByPrimaryKey(umsMenu.getParentId());
            if (StringUtils.isEmpty(parentMenu)){
                umsMenu.setLevel(0);
            }else {
                umsMenu.setLevel(parentMenu.getLevel() + 1);
            }
        }
    }

    /**
     * 创建菜单
     * @param umsMenu
     * @return
     */
    @Override
    public int create(UmsMenu umsMenu) {
        umsMenu.setCreateTime(new Date());
        updateMenuLevel(umsMenu);
        return menuMapper.insert(umsMenu);
    }

    /**
     * 更新菜单
     * @param id
     * @param umsMenu
     * @return
     */
    @Override
    public int update(Long id, UmsMenu umsMenu) {
        umsMenu.setId(id);
        updateMenuLevel(umsMenu);
        return menuMapper.updateByPrimaryKeySelective(umsMenu);
    }

    /**
     * 通过ID获取菜单详情
     * @param id
     * @return
     */
    @Override
    public UmsMenu getItem(Long id) {
        return menuMapper.selectByPrimaryKey(id);
    }

    /**
     * 根据ID删除菜单
     * @param id
     * @return
     */
    @Override
    public int delete(Long id) {
        return menuMapper.deleteByPrimaryKey(id);
    }

    /**
     * 分页获取菜单
     * @param parentId
     * @param pageSize
     * @param pageNum
     * @return
     */
    @Override
    public List<UmsMenu> list(Long parentId, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        UmsMenuExample example = new UmsMenuExample();
        //降序排列
        example.setOrderByClause("sort desc");
        example.createCriteria().andParentIdEqualTo(parentId);;

        return menuMapper.selectByExample(example);
    }

    /**
     * 修改菜单是否显示
     * @param id
     * @param hidden
     * @return
     */
    @Override
    public int updateHidden(Long id, Integer hidden) {
        UmsMenu umsMenu = new UmsMenu();
        umsMenu.setId(id);
        umsMenu.setHidden(hidden);
        //updateByPrimaryKeySelective：只更新赋值的字段
        return menuMapper.updateByPrimaryKeySelective(umsMenu);
    }
}
