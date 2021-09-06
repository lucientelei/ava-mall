package com.lucien.malll.service.pms.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.rear.pms.PmsProductCategoryParam;
import com.lucien.mall.rear.pms.PmsProductCategoryWithChildrenItem;
import com.lucien.mall.mapper.PmsProductCategoryAttributeRelationMapper;
import com.lucien.mall.mapper.PmsProductCategoryMapper;
import com.lucien.mall.mapper.PmsProductMapper;
import com.lucien.mall.pojo.*;
import com.lucien.malll.service.pms.PmsProductCategoryService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 后台商品分类管理impl
 */
@Service
public class PmsProductCategoryServiceImpl implements PmsProductCategoryService {

    @Autowired
    private PmsProductCategoryMapper categoryMapper;

    @Autowired
    private PmsProductCategoryAttributeRelationMapper relationMapper;

    @Autowired
    private PmsProductMapper productMapper;

    /**
     * 设置分类等级
     * @param category
     */
    private void setCategoryLevel(PmsProductCategory category){
        if (category.getParentId() == 0){
            category.setLevel(0);
        }else {
            PmsProductCategory parentCategory  = categoryMapper.selectByPrimaryKey(category.getParentId());
            if (parentCategory != null){
                category.setLevel(parentCategory.getLevel() + 1);
            }else {
                category.setLevel(0);
            }
        }
    }

    /**
     * 批量插入商品分类与筛选属性关系表
     * @param productCategoryId 商品分类id
     * @param productAttributeIdList 相关商品筛选属性id集合
     */
    private void insertRelationList(Long productCategoryId, List<Long> productAttributeIdList){
        List<PmsProductCategoryAttributeRelation> relationList = new ArrayList<>();
        for (Long productAttrId : productAttributeIdList) {
            PmsProductCategoryAttributeRelation relation = new PmsProductCategoryAttributeRelation();
            relation.setProductAttributeId(productAttrId);
            relation.setProductCategoryId(productCategoryId);
            relationList.add(relation);
        }
        relationMapper.insertList(relationList);
    }

    /**
     * 新增分类
     * @param param
     * @return
     */
    @Override
    public int insert(PmsProductCategoryParam param) {
        PmsProductCategory productCategory = new PmsProductCategory();
        productCategory.setProductCount(0);
        BeanUtils.copyProperties(param, productCategory);
        setCategoryLevel(productCategory);
        int count = categoryMapper.insertSelective(productCategory);
        List<Long> attributeIdList = param.getProductAttributeIdList();
        if (!CollectionUtils.isEmpty(attributeIdList)){
            insertRelationList(productCategory.getId(), attributeIdList);
        }
        return count;
    }

    /**
     * 分页获取商品分类
     * @param parentId
     * @param pageSize
     * @param pageNum
     * @return
     */
    @Override
    public List<PmsProductCategory> listPage(Long parentId, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        PmsProductCategoryExample example = new PmsProductCategoryExample();
        example.setOrderByClause("sort desc");
        example.createCriteria().andParentIdEqualTo(parentId);
        return categoryMapper.selectByExample(example);
    }

    /**
     * 更新商品分类
     * @param id
     * @param param
     * @return
     */
    @Override
    public int update(Long id, PmsProductCategoryParam param) {
        PmsProductCategory productCategory = new PmsProductCategory();
        productCategory.setId(id);
        BeanUtils.copyProperties(param, productCategory);
        setCategoryLevel(productCategory);
        //更新商品分类时要更新商品中的名称
        PmsProduct pmsProduct = new PmsProduct();
        pmsProduct.setProductCategoryName(productCategory.getName());
        PmsProductExample productExample = new PmsProductExample();
        productExample.createCriteria().andProductCategoryIdEqualTo(id);
        productMapper.updateByExample(pmsProduct, productExample);

        //同时更新筛选属性的信息
        if (!CollectionUtils.isEmpty(param.getProductAttributeIdList())){
            PmsProductCategoryAttributeRelationExample relationExample = new PmsProductCategoryAttributeRelationExample();
            relationExample.createCriteria().andProductAttributeIdEqualTo(id);
            relationMapper.deleteByExample(relationExample);
            insertRelationList(id, param.getProductAttributeIdList());
        }else {
            PmsProductCategoryAttributeRelationExample relationExample = new PmsProductCategoryAttributeRelationExample();
            relationExample.createCriteria().andProductCategoryIdEqualTo(id);
            relationMapper.deleteByExample(relationExample);
        }

        return categoryMapper.updateByPrimaryKeySelective(productCategory);
    }

    /**
     * 删除商品分类
     * @param id
     * @return
     */
    @Override
    public int delete(Long id) {
        return categoryMapper.deleteByPrimaryKey(id);
    }

    /**
     * 获取商品分类
     * @param id
     * @return
     */
    @Override
    public PmsProductCategory getItem(Long id) {
        return categoryMapper.selectByPrimaryKey(id);
    }

    /**
     * 批量修改导航状态
     * @param ids
     * @param navStatus
     * @return
     */
    @Override
    public int updateNavStatus(List<Long> ids, Integer navStatus) {
        PmsProductCategory productCategory = new PmsProductCategory();
        productCategory.setNavStatus(navStatus);
        PmsProductCategoryExample example = new PmsProductCategoryExample();
        example.createCriteria().andIdIn(ids);
        return categoryMapper.updateByExampleSelective(productCategory, example);
    }

    /**
     * 批量修改显示状态
     * @param ids
     * @param showStatus
     * @return
     */
    @Override
    public int updateShowStatus(List<Long> ids, Integer showStatus) {
        PmsProductCategory productCategory = new PmsProductCategory();
        productCategory.setShowStatus(showStatus);
        PmsProductCategoryExample example = new PmsProductCategoryExample();
        example.createCriteria().andIdIn(ids);
        return categoryMapper.updateByExampleSelective(productCategory, example);
    }

    /**
     * 以层级形式获取商品分类
     * @return
     */
    @Override
    public List<PmsProductCategoryWithChildrenItem> listWithChildren() {
        return categoryMapper.listWithChildren();
    }
}
