package com.lucien.mall.front.service.oms;

import com.lucien.mall.front.ConfirmOrderResult;
import com.lucien.mall.front.OmsOrderDetail;
import com.lucien.mall.front.OrderParam;
import com.lucien.mall.global.GlobalPage;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 前台订单Service
 */
public interface OmsPortalOrderService {

    /**
     * 根据用户选择的购物车商品生成确认订单信息
     * @param cartIds
     * @return
     */
    ConfirmOrderResult generateConfirmOrder(List<Long> cartIds);

    /**
     * 根据确提交信息生成订单
     * @param param
     * @return
     */
    Map<String, Object> generateOrder(OrderParam param);

    /**
     * 支付成功回调
     * @param orderId
     * @param payType
     * @return
     */
    @Transactional
    Integer paySuccess(Long orderId, Integer payType);

    /**
     * 确认收货
     * @param orderId
     */
    int confirmReceiveOrder(Long orderId);

    /**
     * 分页获取用户订单
     * @param status
     * @param pageNum
     * @param pageSize
     * @return
     */
    GlobalPage<OmsOrderDetail> list(Integer status, Integer pageNum, Integer pageSize);

    /**
     * 获取单个订单详情
     * @param orderId
     * @return
     */
    OmsOrderDetail getItem(Long orderId);

    /**
     * 删除订单
     * @param orderId
     */
    int deleteOrder(Long orderId);

    /**
     * 自动取消超时订单
     * @return
     */
    @Transactional
    Integer cancelTimeOutOrder();

    /**
     * 取消单个超时订单
     * @param orderId
     */
    int cancelOrder(Long orderId);

    /**
     * 发送延迟消息给rabbitmq 取消订单
     * @param orderId
     */
    void sendDelayMsgCancelOrder(Long orderId);

    /**
     * 设置订单状态
     * @param orderId
     * @param status
     * @return
     */
    int updateOrderStatus(Long orderId, Integer status);
}
