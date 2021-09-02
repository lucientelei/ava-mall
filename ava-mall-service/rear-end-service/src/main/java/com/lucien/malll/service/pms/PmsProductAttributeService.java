package com.lucien.malll.service.pms;

import com.lucien.mall.dto.pms.PmsProductAttributeParam;
import com.lucien.mall.dto.pms.ProductAttrInfo;
import com.lucien.mall.pojo.PmsProductAttribute;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 商品属性管理Service
 */
public interface PmsProductAttributeService {

    /**
     * 新增商品属性
     * @param param
     * @return
     */
    int insert(PmsProductAttributeParam param);

    /**
     * 修改商品属性
     * @param id
     * @param productAttributeParam
     * @return
     */
    int update(Long id, PmsProductAttributeParam productAttributeParam);

    /**
     * 获取商品属性信息
     * @param id
     * @return
     */
    PmsProductAttribute getItem(Long id);

    /**
     * 根据分类分页获取商品属性
     * @param cid  分类id
     * @param type  0->规格；1->参数
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<PmsProductAttribute> getList(Long cid, Integer type, Integer pageSize, Integer pageNum);

    /**
     * 批量删除商品属性
     * @param ids
     * @return
     */
    int delete(List<Long> ids);

    /**
     * 获取商品分类对应属性列表
     * @param productCategoryId
     * @return
     */
    List<ProductAttrInfo> getProductAttrInfo(Long productCategoryId);
}

