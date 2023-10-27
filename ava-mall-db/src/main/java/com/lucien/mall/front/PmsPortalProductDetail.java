package com.lucien.mall.front;

import com.lucien.mall.pojo.*;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/7
 * 前台商品详情
 */
public class PmsPortalProductDetail {

    @ApiModelProperty("商品信息")
    private PmsProduct product;

    @ApiModelProperty("商品品牌")
    private PmsBrand brand;

    @ApiModelProperty("商品的sku库存信息")
    private List<PmsSkuStock> skuStockList;

    public PmsProduct getProduct() {
        return product;
    }

    public void setProduct(PmsProduct product) {
        this.product = product;
    }

    public PmsBrand getBrand() {
        return brand;
    }

    public void setBrand(PmsBrand brand) {
        this.brand = brand;
    }

    public List<PmsSkuStock> getSkuStockList() {
        return skuStockList;
    }

    public void setSkuStockList(List<PmsSkuStock> skuStockList) {
        this.skuStockList = skuStockList;
    }
}
