package com.lucien.malll.service;

import com.lucien.mall.dto.PmsProductAttributeCategoryItem;
import com.lucien.mall.pojo.PmsProductAttributeCategory;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 商品属性分类管理Service
 */
public interface PmsProductAttributeCategoryService {

    /**
     * 新增属性分类
     * @param name
     * @return
     */
    int insert(String name);

    /**
     * 更新属性分类
     * @param id
     * @param name
     * @return
     */
    int update(Long id, String name);

    /**
     * 删除属性分类
     * @param id
     * @return
     */
    int del(Long id);

    /**
     * 获取属性分类信息
     * @param id
     * @return
     */
    PmsProductAttributeCategory getItem(Long id);

    /**
     * 分页获取属性分类信息
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<PmsProductAttributeCategory> list(Integer pageSize, Integer pageNum);

    /**
     * 获取包含属性的属性分类
     * @return
     */
    List<PmsProductAttributeCategoryItem> getListWithAttr();
}
