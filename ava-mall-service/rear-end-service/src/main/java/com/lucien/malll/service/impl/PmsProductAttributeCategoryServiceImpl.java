package com.lucien.malll.service.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.dto.PmsProductAttributeCategoryItem;
import com.lucien.mall.mapper.PmsProductAttributeCategoryMapper;
import com.lucien.mall.pojo.PmsProductAttributeCategory;
import com.lucien.mall.pojo.PmsProductAttributeCategoryExample;
import com.lucien.malll.service.PmsProductAttributeCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 商品属性分类管理Impl
 */
@Service
public class PmsProductAttributeCategoryServiceImpl implements PmsProductAttributeCategoryService {

    @Autowired
    private PmsProductAttributeCategoryMapper categoryMapper;

    /**
     * 新增属性分类
     * @param name
     * @return
     */
    @Override
    public int insert(String name) {
        PmsProductAttributeCategory category = new PmsProductAttributeCategory();
        category.setName(name);
        return categoryMapper.insertSelective(category);
    }

    /**
     * 更新属性分类
     * @param id
     * @param name
     * @return
     */
    @Override
    public int update(Long id, String name) {
        PmsProductAttributeCategory category = new PmsProductAttributeCategory();
        category.setId(id);
        category.setName(name);
        return categoryMapper.updateByPrimaryKeySelective(category);
    }

    /**
     * 删除属性分类
     * @param id
     * @return
     */
    @Override
    public int del(Long id) {
        return categoryMapper.deleteByPrimaryKey(id);
    }

    /**
     * 获取属性分类信息
     * @param id
     * @return
     */
    @Override
    public PmsProductAttributeCategory getItem(Long id) {
        return categoryMapper.selectByPrimaryKey(id);
    }

    /**
     * 分页获取属性分类信息
     * @param pageSize
     * @param pageNum
     * @return
     */
    @Override
    public List<PmsProductAttributeCategory> list(Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        return categoryMapper.selectByExample(new PmsProductAttributeCategoryExample());
    }

    /**
     * 获取包含属性的属性分类
     * @return
     */
    @Override
    public List<PmsProductAttributeCategoryItem> getListWithAttr() {
        return categoryMapper.getListWithAttr();
    }
}
