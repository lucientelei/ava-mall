package com.lucien.malll.service.ums;

import com.lucien.mall.pojo.UmsResourceCategory;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/30
 * 后台资源管理分类Service
 */
public interface UmsResourceCategoryService {

    /**
     * 新增资源分类
     * @param umsResourceCategory
     * @return
     */
    int insert(UmsResourceCategory umsResourceCategory);

    /**
     * 删除资源分类
     * @param id
     * @return
     */
    int del (Long id);

    /**
     * 更新资源分类
     * @param id
     * @return
     */
    int update(Long id, UmsResourceCategory umsResourceCategory);

    /**
     * 获取所有分类
     * @return
     */
    List<UmsResourceCategory> listAll();
}
