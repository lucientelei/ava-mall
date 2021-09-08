package com.lucien.mall.front.service.impl.oms;

import com.lucien.mall.front.*;
import com.lucien.mall.front.service.oms.OmsCartItemService;
import com.lucien.mall.front.service.oms.OmsPortalOrderService;
import com.lucien.mall.front.service.rabbitmq.CancelOrderSender;
import com.lucien.mall.front.service.ums.UmsMemberCouponService;
import com.lucien.mall.front.service.ums.UmsMemberReceiveAddressService;
import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.mapper.*;
import com.lucien.mall.pojo.OmsOrder;
import com.lucien.mall.pojo.UmsIntegrationConsumeSetting;
import com.lucien.mall.pojo.UmsMember;
import com.lucien.mall.pojo.UmsMemberReceiveAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 前台订单Impl
 */
@Service
@Primary
public class OmsPortalOrderServiceImpl implements OmsPortalOrderService {

    @Autowired
    private UmsMemberService memberService;

    //购物车
    @Autowired
    private OmsCartItemService cartItemService;

    //收货地址
    @Autowired
    private UmsMemberReceiveAddressService receiveAddressService;

    //用户优惠券
    @Autowired
    private UmsMemberCouponService memberCouponService;

    //消费设置
    @Autowired
    private UmsIntegrationConsumeSettingMapper integrationConsumeSettingMapper;

    //sku库存
    @Autowired
    private PmsSkuStockMapper skuStockMapper;

    @Autowired
    private OmsOrderMapper orderMapper;

    //订单商品信息管理
    @Autowired
    private PortalOrderItemMapper portalOrderItemMapper;

    //优惠券历史
    @Autowired
    private SmsCouponHistoryMapper couponHistoryMapper;

    @Autowired
    private PortalOrderMapper portalOrderMapper;

    @Autowired
    private OmsOrderSettingMapper orderSettingMapper;

    @Autowired
    private OmsOrderItemMapper orderItemMapper;

    @Autowired
    private CancelOrderSender cancelOrderSender;

    /**
     * 根据用户选择的购物车商品生成确认订单信息
     * @param cartIds
     * @return
     */
    @Override
    public ConfirmOrderResult generateConfirmOrder(List<Long> cartIds) {
        ConfirmOrderResult result = new ConfirmOrderResult();
        UmsMember member = memberService.getCurrentMember();
        //包含优惠信息的购物车信息
        List<CartPromotionItem> cartPromotionItems = cartItemService.listPromotion(member.getId(), cartIds);
        result.setCartPromotionItemList(cartPromotionItems);
        //用户收货地址列表
        List<UmsMemberReceiveAddress> receiveAddressList = receiveAddressService.list();
        result.setMemberReceiveAddressList(receiveAddressList);
        //用户可用优惠券列表
        List<SmsCouponHistoryDetail> historyDetailList = memberCouponService.listCart(cartPromotionItems, 1);
        result.setCouponHistoryDetailList(historyDetailList);
        //用户积分
        result.getMemberIntegration(member.getIntegration());
        //积分使用规则
        UmsIntegrationConsumeSetting integrationConsumeSetting = integrationConsumeSettingMapper.selectByPrimaryKey(1L);
        result.setIntegrationConsumeSetting(integrationConsumeSetting);
        ConfirmOrderResult.CalcAmount calcAmount = calcCartAmount(cartPromotionItems);
        result.setCalcAmount(calcAmount);
        return result;
    }

    /**
     * 根据确提交信息生成订单
     * @param param
     * @return
     */
    @Override
    public Map<String, Object> generateOrder(OrderParam param) {
        return null;
    }

    /**
     * 支付成功回调
     * @param orderId
     * @param payType
     * @return
     */
    @Override
    public Integer paySuccess(Long orderId, Integer payType) {
        OmsOrder omsOrder = new OmsOrder();
        omsOrder.setId(orderId);
        omsOrder.setStatus(1);
        omsOrder.setPaymentTime(new Date());
        omsOrder.setPayType(payType);
        orderMapper.updateByPrimaryKeySelective(omsOrder);
        //恢复所有下单商品的锁定库存，扣减真实库存
        OmsOrderDetail detail = portalOrderMapper.getDetail(orderId);
        int count = portalOrderMapper.updateSkuStock(detail.getOrderItemList());
        return count;
    }

    /**
     * 确认收货
     * @param orderId
     */
    @Override
    public void confirmReceiveOrder(Long orderId) {
        UmsMember member = memberService.getCurrentMember();
        OmsOrder order = orderMapper.selectByPrimaryKey(orderId);
        if (!member.getId().equals(order.getMemberId())){

        }
    }

    /**
     * 分页获取用户订单
     * @param status
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public GlobalPage<OmsOrderDetail> list(Integer status, Integer pageNum, Integer pageSize) {
        return null;
    }

    /**
     * 获取单个订单详情
     * @param orderId
     * @return
     */
    @Override
    public OmsOrderDetail getItem(Long orderId) {
        return null;
    }

    /**
     * 删除订单
     * @param orderId
     */
    @Override
    public void deleteOrder(Long orderId) {

    }

    /**
     * 自动取消超时订单
     * @return
     */
    @Override
    public Integer cancelTimeOutOrder() {
        return null;
    }

    /**
     * 取消单个超时订单
     * @param orderId
     */
    @Override
    public void cancelOrder(Long orderId) {

    }

    /**
     * 发送延迟消息给rabbitmq 取消订单
     * @param orderId
     */
    @Override
    public void sendDelayMsgCancelOrder(Long orderId) {

    }

    /**
     *计算购物车中商品的总价格
     * @param cartPromotionItemList
     * @return
     */
    private ConfirmOrderResult.CalcAmount calcCartAmount(List<CartPromotionItem> cartPromotionItemList) {
        ConfirmOrderResult.CalcAmount calcAmount = new ConfirmOrderResult.CalcAmount();
        calcAmount.setFreightAmount(new BigDecimal(0));
        BigDecimal totalAmount = new BigDecimal("0");
        BigDecimal promotionAmount = new BigDecimal("0");
        for (CartPromotionItem cartPromotionItem : cartPromotionItemList) {
            totalAmount = totalAmount.add(cartPromotionItem.getPrice().multiply(new BigDecimal(cartPromotionItem.getQuantity())));
            promotionAmount = promotionAmount.add(cartPromotionItem.getReduceAmount().multiply(new BigDecimal(cartPromotionItem.getQuantity())));
        }
        calcAmount.setTotalAmount(totalAmount);
        calcAmount.setPromotionAmount(promotionAmount);
        calcAmount.setPayAmount(totalAmount.subtract(promotionAmount));
        return calcAmount;
    }
}
