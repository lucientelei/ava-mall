package com.lucien.mall.front;

import com.lucien.mall.pojo.PmsProduct;
import com.lucien.mall.pojo.PmsProductAttribute;
import com.lucien.mall.pojo.PmsSkuStock;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/6
 * 购物车中带规格和SKU的商品信息
 */
public class CartProduct extends PmsProduct {

    private List<PmsProductAttribute> productAttributeList;

    private List<PmsSkuStock> skuStockList;

    public List<PmsProductAttribute> getProductAttributeList() {
        return productAttributeList;
    }

    public void setProductAttributeList(List<PmsProductAttribute> productAttributeList) {
        this.productAttributeList = productAttributeList;
    }

    public List<PmsSkuStock> getSkuStockList() {
        return skuStockList;
    }

    public void setSkuStockList(List<PmsSkuStock> skuStockList) {
        this.skuStockList = skuStockList;
    }
}
