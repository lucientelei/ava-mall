package com.lucien.mall.front.service.pms;

import com.lucien.mall.front.PmsPortalProductDetail;
import com.lucien.mall.front.PmsProductCategoryNode;
import com.lucien.mall.pojo.PmsProduct;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 前台商品Service
 */
public interface PmsPortalProductService {

    /**
     * 综合搜索商品
     * @param keyword
     * @param brandId
     * @param productCategoryId
     * @param pageNum
     * @param pageSize
     * @param sort
     * @return
     */
    List<PmsProduct> search(String keyword, Long brandId, Long productCategoryId, Integer pageNum, Integer pageSize, Integer sort);

    /**
     * 以树形结构获取所有商品分类
     * @return
     */
    List<PmsProductCategoryNode> categoryTreeList();

    /**
     * 获取商品详情
     * @param id
     * @return
     */
    PmsPortalProductDetail detail(Long id);
}
