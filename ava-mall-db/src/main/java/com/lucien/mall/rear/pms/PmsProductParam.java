package com.lucien.mall.rear.pms;

import com.lucien.mall.pojo.*;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/1
 * 创建和修改商品时使用的参数
 */
public class PmsProductParam extends PmsProduct{

    @ApiModelProperty("商品的sku库存信息")
    private List<PmsSkuStock> skuStockList;

    public List<PmsSkuStock> getSkuStockList() {
        return skuStockList;
    }

    public void setSkuStockList(List<PmsSkuStock> skuStockList) {
        this.skuStockList = skuStockList;
    }

}
