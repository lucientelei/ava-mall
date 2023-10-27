package com.lucien.mall.front;

import java.util.Date;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/6
 * 首页秒杀场次信息
 */
public class HomeFlashPromotion {
    private Date startTime;

    private Date endTime;

    private Date nextStartTime;

    private Date nextEndTime;

    //属于该秒杀活动的商品
    private List<FlashPromotionProduct> productList;

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getNextStartTime() {
        return nextStartTime;
    }

    public void setNextStartTime(Date nextStartTime) {
        this.nextStartTime = nextStartTime;
    }

    public Date getNextEndTime() {
        return nextEndTime;
    }

    public void setNextEndTime(Date nextEndTime) {
        this.nextEndTime = nextEndTime;
    }

    public List<FlashPromotionProduct> getProductList() {
        return productList;
    }

    public void setProductList(List<FlashPromotionProduct> productList) {
        this.productList = productList;
    }
}
