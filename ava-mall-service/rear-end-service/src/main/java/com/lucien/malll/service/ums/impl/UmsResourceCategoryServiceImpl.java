package com.lucien.malll.service.ums.impl;

import com.lucien.mall.mapper.UmsResourceCategoryMapper;
import com.lucien.mall.pojo.UmsResourceCategory;
import com.lucien.mall.pojo.UmsResourceCategoryExample;
import com.lucien.malll.service.ums.UmsResourceCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/30
 * 后台资源分类管理Impl
 */
@Service
public class UmsResourceCategoryServiceImpl implements UmsResourceCategoryService {

    @Autowired
    private UmsResourceCategoryMapper categoryMapper;

    /**
     * 新增资源分类
     * @param umsResourceCategory
     * @return
     */
    @Override
    public int insert(UmsResourceCategory umsResourceCategory) {
        umsResourceCategory.setCreateTime(new Date());
        return categoryMapper.insert(umsResourceCategory);
    }

    /**
     * 删除资源分类
     * @param id
     * @return
     */
    @Override
    public int del(Long id) {
        return categoryMapper.deleteByPrimaryKey(id);
    }

    /**
     * 更新资源分类
     * @param id
     * @return
     */
    @Override
    public int update(Long id, UmsResourceCategory umsResourceCategory) {
        umsResourceCategory.setId(id);
        return categoryMapper.updateByPrimaryKeySelective(umsResourceCategory);
    }

    /**
     * 获取所有分类
     * @return
     */
    @Override
    public List<UmsResourceCategory> listAll() {
        return categoryMapper.selectByExample(new UmsResourceCategoryExample());
    }
}
