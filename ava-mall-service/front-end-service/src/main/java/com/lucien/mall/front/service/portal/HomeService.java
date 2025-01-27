package com.lucien.mall.front.service.portal;

import com.lucien.mall.front.HomeContentResult;
import com.lucien.mall.pojo.PmsProduct;
import com.lucien.mall.pojo.PmsProductCategory;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/6
 * 首页内容Service
 */
public interface HomeService {

    /**
     * 获取首页内容
     */
    HomeContentResult content();

    /**
     * 首页商品推荐
     */
    List<PmsProduct> recommendProductList(Integer pageSize, Integer pageNum);

    /**
     * 获取商品分类
     * @param parentId 0:获取一级分类；其他：获取指定二级分类
     */
    List<PmsProductCategory> getProductCateList(Long parentId);

    /**
     * 分页获取人气推荐商品
     */
    List<PmsProduct> hotProductList(Integer pageNum, Integer pageSize);

    /**
     * 分页获取新品推荐商品
     */
    List<PmsProduct> newProductList(Integer pageNum, Integer pageSize);
}
