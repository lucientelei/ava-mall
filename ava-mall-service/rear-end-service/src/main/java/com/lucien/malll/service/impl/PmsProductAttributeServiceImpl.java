package com.lucien.malll.service.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.dto.PmsProductAttributeParam;
import com.lucien.mall.dto.ProductAttrInfo;
import com.lucien.mall.mapper.PmsProductAttributeCategoryMapper;
import com.lucien.mall.mapper.PmsProductAttributeMapper;
import com.lucien.mall.pojo.PmsProductAttribute;
import com.lucien.mall.pojo.PmsProductAttributeCategory;
import com.lucien.mall.pojo.PmsProductAttributeExample;
import com.lucien.malll.service.PmsProductAttributeService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 商品属性管理Impl
 */
@Service
public class PmsProductAttributeServiceImpl implements PmsProductAttributeService {

    @Autowired
    private PmsProductAttributeMapper attributeMapper;

    @Autowired
    private PmsProductAttributeCategoryMapper categoryMapper;

    /**
     * 新增商品属性
     * @param param
     * @return
     */
    @Override
    public int insert(PmsProductAttributeParam param) {
        PmsProductAttribute productAttribute = new PmsProductAttribute();
        BeanUtils.copyProperties(param, productAttribute);
        int count = attributeMapper.insert(productAttribute);
        //新增商品属性以后需要更新商品属性分类数量
        PmsProductAttributeCategory attributeCategory = categoryMapper.selectByPrimaryKey(productAttribute.getProductAttributeCategoryId());
        if (productAttribute.getType() == 0){
            attributeCategory.setAttributeCount(attributeCategory.getAttributeCount() + 1);
        }else {
            attributeCategory.setParamCount(attributeCategory.getParamCount() + 1);
        }
        categoryMapper.updateByPrimaryKey(attributeCategory);
        return count;
    }

    /**
     * 修改商品属性
     * @param id
     * @param productAttributeParam
     * @return
     */
    @Override
    public int update(Long id, PmsProductAttributeParam productAttributeParam) {
        PmsProductAttribute productAttribute = new PmsProductAttribute();
        productAttribute.setId(id);
        BeanUtils.copyProperties(productAttributeParam, productAttribute);
        return attributeMapper.updateByPrimaryKeySelective(productAttribute);
    }

    /**
     * 获取商品属性信息
     * @param id
     * @return
     */
    @Override
    public PmsProductAttribute getItem(Long id) {
        return attributeMapper.selectByPrimaryKey(id);
    }

    /**
     * 根据分类分页获取商品属性
     * @param cid  分类id
     * @param type  0->规格；1->参数
     * @param pageSize
     * @param pageNum
     * @return
     */
    @Override
    public List<PmsProductAttribute> getList(Long cid, Integer type, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        PmsProductAttributeExample example = new PmsProductAttributeExample();
        example.setOrderByClause("sort desc");
        example.createCriteria().andProductAttributeCategoryIdEqualTo(cid).andTypeEqualTo(type);
        return attributeMapper.selectByExample(example);
    }

    /**
     * 批量删除商品属性
     * @param ids
     * @return
     */
    @Override
    public int delete(List<Long> ids) {
        //获取商品分类
        PmsProductAttribute productAttribute = attributeMapper.selectByPrimaryKey(ids.get(0));
        Integer type = productAttribute.getType();
        PmsProductAttributeCategory category = categoryMapper.selectByPrimaryKey(productAttribute.getProductAttributeCategoryId());
        PmsProductAttributeExample example = new PmsProductAttributeExample();
        example.createCriteria().andIdIn(ids);
        int count = attributeMapper.deleteByExample(example);
        //删除完后修改数量
        if (type == 0){
            if (category.getAttributeCount() >= count) {
                category.setAttributeCount(category.getAttributeCount() + 1);
            }else {
                category.setAttributeCount(0);
            }
        } else if (type == 1) {
            if (category.getParamCount() >= count){
                category.setParamCount(category.getParamCount() + 1);
            }else {
                category.setParamCount(0);
            }
        }
        categoryMapper.updateByPrimaryKeySelective(category);
        return count;
    }

    /**
     * 获取商品分类对应属性列表
     * @param productCategoryId
     * @return
     */
    @Override
    public List<ProductAttrInfo> getProductAttrInfo(Long productCategoryId) {
        return attributeMapper.getProductAttrInfo(productCategoryId);
    }
}
