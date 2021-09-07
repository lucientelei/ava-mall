package com.lucien.mall.front.service;

import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.pojo.PmsBrand;
import com.lucien.mall.pojo.PmsProduct;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 前台品牌Service
 */
public interface PortalBrandService {

    /**
     * 分页获取推荐品牌
     * @param pageNum
     * @param pageSize
     * @return
     */
    List<PmsBrand> recommendList(Integer pageNum, Integer pageSize);

    /**
     * 分页获取品牌关联商品
     * @param brandId
     * @param pageNum
     * @param pageSize
     * @return
     */
    GlobalPage<PmsProduct> productList(Long brandId, Integer pageNum, Integer pageSize);

    /**
     * 获取品牌详情
     * @param brandId
     * @return
     */
    PmsBrand getItem(Long brandId);
}
