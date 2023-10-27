package com.lucien.mall.front;

import com.lucien.mall.pojo.PmsProduct;
import com.lucien.mall.pojo.PmsSkuStock;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/6
 * 商品的促销信息，包括sku、打折优惠、满减优惠
 */
public class PromotionProduct extends PmsProduct {
    //商品库存信息
    private List<PmsSkuStock> skuStockList;

    public List<PmsSkuStock> getSkuStockList() {
        return skuStockList;
    }

    public void setSkuStockList(List<PmsSkuStock> skuStockList) {
        this.skuStockList = skuStockList;
    }

}
