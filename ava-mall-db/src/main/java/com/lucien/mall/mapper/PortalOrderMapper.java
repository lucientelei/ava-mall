package com.lucien.mall.mapper;

import com.lucien.mall.pojo.OmsOrderItem;
import com.lucien.mall.front.OmsOrderDetail;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/6
 * 前台订单管理自定义mapper
 */
public interface PortalOrderMapper {

    /**
     * 获取订单及下单商品详情
     */
    OmsOrderDetail getDetail(@Param("orderId") Long orderId);

    /**
     * 修改 pms_sku_stock表的锁定库存及真实库存
     */
    int updateSkuStock(@Param("itemList") List<OmsOrderItem> orderItemList);

    /**
     * 获取超时订单
     * @param minute 超时时间（分）
     */
    List<OmsOrderDetail> getTimeOutOrders(@Param("minute") Integer minute);

    /**
     * 批量修改订单状态
     */
    int updateOrderStatus(@Param("ids") List<Long> ids,@Param("status") Integer status);

    /**
     * 解除取消订单的库存锁定
     */
    int releaseSkuStockLock(@Param("itemList") List<OmsOrderItem> orderItemList);

}
