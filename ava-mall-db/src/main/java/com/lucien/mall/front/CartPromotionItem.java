package com.lucien.mall.front;

import com.lucien.mall.pojo.OmsCartItem;

import java.math.BigDecimal;

/**
 * @Author Lucien
 * @Date 2023/9/6
 * 购物车中促销信息
 */
public class CartPromotionItem extends OmsCartItem {

    //促销活动信息
    private String promotionMessage;

    //促销活动减去的金额，针对每个商品
    private BigDecimal reduceAmount;

    //商品的真实库存（剩余库存-锁定库存）
    private Integer realStock;

    //购买商品赠送积分
    private Integer integration;

    //购买商品赠送成长值
    private Integer growth;

    public String getPromotionMessage() {
        return promotionMessage;
    }

    public void setPromotionMessage(String promotionMessage) {
        this.promotionMessage = promotionMessage;
    }

    public BigDecimal getReduceAmount() {
        return reduceAmount;
    }

    public void setReduceAmount(BigDecimal reduceAmount) {
        this.reduceAmount = reduceAmount;
    }

    public Integer getRealStock() {
        return realStock;
    }

    public void setRealStock(Integer realStock) {
        this.realStock = realStock;
    }

    public Integer getIntegration() {
        return integration;
    }

    public void setIntegration(Integer integration) {
        this.integration = integration;
    }

    public Integer getGrowth() {
        return growth;
    }

    public void setGrowth(Integer growth) {
        this.growth = growth;
    }
}
