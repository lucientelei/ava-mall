package com.lucien.mall.front;

import com.lucien.mall.pojo.OmsOrder;
import com.lucien.mall.pojo.OmsOrderItem;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/6
 * 包含商品信息的订单详情
 */
public class OmsOrderDetail extends OmsOrder {

    private List<OmsOrderItem> orderItemList;

    public List<OmsOrderItem> getOrderItemList() {
        return orderItemList;
    }

    public void setOrderItemList(List<OmsOrderItem> orderItemList) {
        this.orderItemList = orderItemList;
    }

}