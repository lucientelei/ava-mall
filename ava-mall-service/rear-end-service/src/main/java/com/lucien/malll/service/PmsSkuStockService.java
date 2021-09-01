package com.lucien.malll.service;

import com.lucien.mall.pojo.PmsSkuStock;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 商品库存管理Service
 */
public interface PmsSkuStockService {

    /**
     * 根据产品Id和skuCode搜索
     * @param id
     * @param keyWord
     * @return
     */
    List<PmsSkuStock> list(Long id, String keyWord);

    /**
     * 批量更新商品库存信息
     * @param pid
     * @param skuStockList
     * @return
     */
    int update(Long pid, List<PmsSkuStock> skuStockList);
}
