package com.lucien.mall.rear.pms;

import com.lucien.mall.pojo.*;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 创建和修改商品时使用的参数
 */
public class PmsProductParam extends PmsProduct{

    @ApiModelProperty("商品会员价格设置")
    private List<PmsMemberPrice> memberPriceList;

    @ApiModelProperty("商品的sku库存信息")
    private List<PmsSkuStock> skuStockList;

    public List<PmsMemberPrice> getMemberPriceList() {
        return memberPriceList;
    }

    public void setMemberPriceList(List<PmsMemberPrice> memberPriceList) {
        this.memberPriceList = memberPriceList;
    }

    public List<PmsSkuStock> getSkuStockList() {
        return skuStockList;
    }

    public void setSkuStockList(List<PmsSkuStock> skuStockList) {
        this.skuStockList = skuStockList;
    }

}
