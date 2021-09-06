package com.lucien.mall.rear.oms;

import com.lucien.mall.pojo.OmsOrder;
import com.lucien.mall.pojo.OmsOrderItem;
import com.lucien.mall.pojo.OmsOrderOperateHistory;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/2
 * 订单详情信息
 */
public class OmsOrderDetail extends OmsOrder {

    @ApiModelProperty("订单商品列表")
    private List<OmsOrderItem> orderItemList;

    @ApiModelProperty("订单操作记录列表")
    private List<OmsOrderOperateHistory> historyList;

    public List<OmsOrderItem> getOrderItemList() {
        return orderItemList;
    }

    public void setOrderItemList(List<OmsOrderItem> orderItemList) {
        this.orderItemList = orderItemList;
    }

    public List<OmsOrderOperateHistory> getHistoryList() {
        return historyList;
    }

    public void setHistoryList(List<OmsOrderOperateHistory> historyList) {
        this.historyList = historyList;
    }
}
