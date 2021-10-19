package com.lucien.mall.front.service.oms.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.front.CartPromotionItem;
import com.lucien.mall.front.ConfirmOrderResult;
import com.lucien.mall.front.OmsOrderDetail;
import com.lucien.mall.front.OrderParam;
import com.lucien.mall.front.service.oms.OmsCartItemService;
import com.lucien.mall.front.service.oms.OmsPortalOrderService;
import com.lucien.mall.front.service.rabbitmq.CancelOrderSender;
import com.lucien.mall.front.service.ums.UmsMemberReceiveAddressService;
import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.mapper.*;
import com.lucien.mall.pojo.*;
import com.lucien.mall.utils.RedisUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

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

    //sku库存
    @Autowired
    private PmsSkuStockMapper skuStockMapper;

    @Autowired
    private OmsOrderMapper orderMapper;

    //订单商品信息管理
    @Autowired
    private PortalOrderItemMapper portalOrderItemMapper;

    @Autowired
    private PortalOrderMapper portalOrderMapper;

    @Autowired
    private OmsOrderSettingMapper orderSettingMapper;

    @Autowired
    private OmsOrderItemMapper orderItemMapper;

    @Autowired
    private CancelOrderSender cancelOrderSender;

    @Autowired
    private RedisUtils redisUtils;

    private String REDIS_KEY_ORDER_ID = "oms:orderId";

    private String REDIS_DATABASE = "avaMall";

    /**
     * 根据用户选择的购物车商品生成确认订单信息
     *
     * @param cartIds
     * @return
     */
    @Override
    public ConfirmOrderResult generateConfirmOrder(List<Long> cartIds) {
        ConfirmOrderResult result = new ConfirmOrderResult();
        UmsMember member = memberService.getCurrentMember();
        //用户收货地址列表
        List<UmsMemberReceiveAddress> receiveAddressList = receiveAddressService.list();
        result.setMemberReceiveAddressList(receiveAddressList);
        return result;
    }

    /**
     * 根据确提交信息生成订单
     *
     * @param param
     * @return
     */
    @Override
    public Map<String, Object> generateOrder(OrderParam param) {
        List<OmsOrderItem> orderItemList = new ArrayList<>();
        //获取用户购物车及优惠信息
        UmsMember member = memberService.getCurrentMember();

        List<OmsCartItem> list = cartItemService.list(member.getId());
        for (OmsCartItem omsCartItem : list) {
            OmsOrderItem orderItem = new OmsOrderItem();
            orderItem.setProductId(omsCartItem.getProductId());
            orderItem.setProductName(omsCartItem.getProductName());
            orderItem.setProductPic(omsCartItem.getProductPic());
            orderItem.setProductAttr(omsCartItem.getProductAttr());
            orderItem.setProductBrand(omsCartItem.getProductBrand());
            orderItem.setProductSn(omsCartItem.getProductSn());
            orderItem.setProductPrice(omsCartItem.getPrice());
            orderItem.setProductQuantity(omsCartItem.getQuantity());
            orderItem.setProductSkuId(omsCartItem.getProductSkuId());
            orderItem.setProductSkuCode(omsCartItem.getProductSkuCode());
            orderItem.setProductCategoryId(omsCartItem.getProductCategoryId());
            orderItemList.add(orderItem);
        }
        //使用积分情况
        if (StringUtils.isEmpty(param.getUseIntegration()) || param.getUseIntegration().equals(0)) {
            for (OmsOrderItem omsOrderItem : orderItemList) {
                omsOrderItem.setIntegrationAmount(new BigDecimal(0));
            }
        }
        OmsOrder order = new OmsOrder();
        order.setDiscountAmount(new BigDecimal(0));
        order.setTotalAmount(calcTotalAmount(orderItemList));
        order.setFreightAmount(new BigDecimal(0));
        order.setPromotionAmount(calcPromotionAmount(orderItemList));
        order.setPromotionInfo(getOrderPromotionInfo(orderItemList));
        if (StringUtils.isEmpty(param.getCouponId())) {
            order.setCouponAmount(new BigDecimal(0));
        } else {
            order.setCouponId(param.getCouponId());
            order.setCouponAmount(calcPromotionAmount(orderItemList));
        }
        if (StringUtils.isEmpty(param.getUseIntegration())) {
            order.setIntegration(0);
            order.setIntegrationAmount(new BigDecimal(0));
        } else {
            order.setIntegration(param.getUseIntegration());
            order.setIntegrationAmount(calcIntegrationAmount(orderItemList));
        }

        order.setPayAmount(calcPayAmount(order));

        order.setMemberId(member.getId());
        order.setMemberUsername(member.getUsername());
        order.setCreateTime(new Date());
        //支付方式：0->未支付；1->支付宝
        order.setPayType(param.getPayType());
        //订单来源：0->PC订单；1->app订单
        order.setSourceType(1);
        //订单状态：0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->退货订单
        order.setStatus(0);
        //订单类型：0->正常订单；1->秒杀订单
        order.setOrderType(0);

        UmsMemberReceiveAddress receiveAddress = receiveAddressService.getItem(param.getMemberReceiveAddressId());
        order.setReceiverProvince(receiveAddress.getProvince());
        order.setReceiverCity(receiveAddress.getCity());
        order.setReceiverRegion(receiveAddress.getRegion());
        order.setReceiverDetailAddress(receiveAddress.getDetailAddress());
        order.setReceiverName(receiveAddress.getName());
        order.setReceiverPostCode(receiveAddress.getPostCode());
        order.setReceiverPhone(receiveAddress.getPhoneNumber());

        //0->未确认；1->已确认
        order.setConfirmStatus(0);
        order.setDeleteStatus(0);

        //生成订单号
        order.setOrderSn(generateOrderSn(order));
        //设置自动收货天数
        OmsOrderSetting orderSetting = orderSettingMapper.selectByPrimaryKey(1L);
        order.setAutoConfirmDay(orderSetting.getConfirmOvertime());

        orderMapper.insert(order);
        for (OmsOrderItem orderItem : orderItemList) {
            orderItem.setOrderId(order.getId());
            orderItem.setOrderSn(order.getOrderSn());
        }
        orderItemMapper.insertList(orderItemList);
        //扣除积分
        if (!StringUtils.isEmpty(param.getUseIntegration())){
            System.out.println("扣除积分" + param.getUseIntegration());
            order.setUseIntegration(param.getUseIntegration());
            memberService.updateIntegration(member.getId(), member.getIntegration() - param.getUseIntegration());
        }
        //删除购物车商品
        deleteCartItemList(member);
        //发送延迟消息取消订单
        sendDelayMsgCancelOrder(order.getId());
        Map<String, Object> result = new HashMap<>();
        result.put("order", order);
        result.put("orderItemList", orderItemList);

        return result;
    }

    /**
     * 支付成功回调
     *
     * @param orderId
     * @param payType
     * @return
     */
    @Override
    public Integer paySuccess(Long orderId, Integer payType) {
        int result = 0;
        OmsOrder omsOrder = new OmsOrder();
        omsOrder.setId(orderId);
        omsOrder.setStatus(1);
        omsOrder.setPaymentTime(new Date());
        omsOrder.setPayType(payType);
        result += orderMapper.updateByPrimaryKeySelective(omsOrder);
        //恢复所有下单商品的锁定库存，扣减真实库存
//        OmsOrderDetail detail = portalOrderMapper.getDetail(orderId);
//        int count = portalOrderMapper.updateSkuStock(detail.getOrderItemList());

        return result;
    }

    /**
     * 确认收货
     * -1不能确认他人订单
     * -2订单未发货 无法确认收货
     *
     * @param orderId
     */
    @Override
    public int confirmReceiveOrder(Long orderId) {
        UmsMember member = memberService.getCurrentMember();
        OmsOrder order = orderMapper.selectByPrimaryKey(orderId);
        if (!member.getId().equals(order.getMemberId())) {
            return -1;
        }
        if (order.getStatus() != 2) {
            return -2;
        }
        order.setStatus(3);
        order.setConfirmStatus(1);
        order.setReceiveTime(new Date());
        return orderMapper.updateByPrimaryKey(order);
    }

    /**
     * 分页获取用户订单
     *
     * @param status
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public GlobalPage<OmsOrderDetail> list(Integer status, Integer pageNum, Integer pageSize) {
        if (status == -1) {
            status = null;
        }
        UmsMember member = memberService.getCurrentMember();
        PageHelper.startPage(pageNum, pageSize);
        OmsOrderExample orderExample = new OmsOrderExample();
        OmsOrderExample.Criteria criteria = orderExample.createCriteria();
        criteria.andDeleteStatusEqualTo(0)
                .andMemberIdEqualTo(member.getId());
        if (!StringUtils.isEmpty(status)) {
            criteria.andStatusEqualTo(status);
        }
        orderExample.setOrderByClause("create_time desc");
        List<OmsOrder> orderList = orderMapper.selectByExample(orderExample);
        GlobalPage<OmsOrder> orderGlobalPage = GlobalPage.restPage(orderList);
        //设置返回结果分页信息
        GlobalPage<OmsOrderDetail> resultPage = new GlobalPage<>();
        resultPage.setPageNum(orderGlobalPage.getPageNum());
        resultPage.setPageSize(orderGlobalPage.getPageSize());
        resultPage.setTotalPage(orderGlobalPage.getTotalPage());
        resultPage.setTotal(orderGlobalPage.getTotal());
        if (CollectionUtils.isEmpty(orderList)) {
            return resultPage;
        }
        //设置数据信息
        List<Long> orderIds = orderList.stream().map(OmsOrder::getId).collect(Collectors.toList());
        OmsOrderItemExample orderItemExample = new OmsOrderItemExample();
        orderItemExample.createCriteria().andOrderIdIn(orderIds);
        List<OmsOrderItem> orderItems = orderItemMapper.selectByExample(orderItemExample);
        List<OmsOrderDetail> omsOrderDetails = new ArrayList<>();
        for (OmsOrder omsOrder : orderList) {
            OmsOrderDetail orderDetail = new OmsOrderDetail();
            BeanUtils.copyProperties(omsOrder, orderDetail);
            List<OmsOrderItem> relatedItemList = orderItems.stream()
                    .filter(item -> item.getOrderId().equals(orderDetail.getId()))
                    .collect(Collectors.toList());
            orderDetail.setOrderItemList(relatedItemList);
            omsOrderDetails.add(orderDetail);
        }
        resultPage.setData(omsOrderDetails);
        return resultPage;
    }

    /**
     * 获取单个订单详情
     *
     * @param orderId
     * @return
     */
    @Override
    public OmsOrderDetail getItem(Long orderId) {
        OmsOrder order = orderMapper.selectByPrimaryKey(orderId);
        OmsOrderItemExample orderItemExample = new OmsOrderItemExample();
        orderItemExample.createCriteria().andOrderIdEqualTo(orderId);
        List<OmsOrderItem> orderItemList = orderItemMapper.selectByExample(orderItemExample);
        OmsOrderDetail orderDetail = new OmsOrderDetail();
        BeanUtils.copyProperties(order, orderDetail);
        orderDetail.setOrderItemList(orderItemList);
        return orderDetail;
    }

    /**
     * 删除订单
     * -1不能删除他人订单
     * -2只能删除已完成或已关闭的订单
     *
     * @param orderId
     */
    @Override
    public int deleteOrder(Long orderId) {
        UmsMember member = memberService.getCurrentMember();
        OmsOrder order = orderMapper.selectByPrimaryKey(orderId);
        if (!order.getMemberId().equals(member.getId())) {
            return -1;
        } else if (order.getStatus() == 3 || order.getStatus() == 4) {
            order.setDeleteStatus(1);
            orderMapper.updateByPrimaryKey(order);
        } else {
            return -2;
        }
        return 1;
    }

    /**
     * 自动取消超时订单
     *
     * @return
     */
    @Override
    public Integer cancelTimeOutOrder() {
        Integer count = null;
        OmsOrderSetting orderSetting = orderSettingMapper.selectByPrimaryKey(1L);
        List<OmsOrderDetail> timeOutOrders = portalOrderMapper.getTimeOutOrders(orderSetting.getNormalOrderOvertime());
        if (CollectionUtils.isEmpty(timeOutOrders)) {
            return count;
        }
        List<Long> ids = new ArrayList<>();
        for (OmsOrderDetail timeOutOrder : timeOutOrders) {
            ids.add(timeOutOrder.getId());
        }
        //关闭订单
        portalOrderMapper.updateOrderStatus(ids, 4);
        for (OmsOrderDetail timeOutOrder : timeOutOrders) {
            //接触sku库存锁定
            portalOrderMapper.releaseSkuStockLock(timeOutOrder.getOrderItemList());
            //返还积分
            if (!StringUtils.isEmpty(timeOutOrder.getIntegration())) {
                UmsMember member = memberService.getById(timeOutOrder.getMemberId());
                memberService.updateIntegration(member.getId(), member.getIntegration() + timeOutOrder.getIntegration());
            }
        }
        return timeOutOrders.size();
    }

    /**
     * 取消单个超时订单
     *
     * @param orderId
     */
    @Override
    public int cancelOrder(Long orderId) {
        OmsOrderExample example = new OmsOrderExample();
        //查询未付款的取消订单
        example.createCriteria().andIdEqualTo(orderId).andStatusEqualTo(0).andDeleteStatusEqualTo(0);
        List<OmsOrder> cancelOrderList = orderMapper.selectByExample(example);
        if (CollectionUtils.isEmpty(cancelOrderList)) {
            return -1;
        }
        //需要取消的订单
        OmsOrder cancelOrder = cancelOrderList.get(0);
        if (!StringUtils.isEmpty(cancelOrder)) {
            cancelOrder.setStatus(4);
            orderMapper.updateByPrimaryKey(cancelOrder);
            OmsOrderItemExample orderItemExample = new OmsOrderItemExample();
            orderItemExample.createCriteria().andOrderIdEqualTo(orderId);
            List<OmsOrderItem> orderItems = orderItemMapper.selectByExample(orderItemExample);
            //解除订单商品锁定
            if (!CollectionUtils.isEmpty(orderItems)) {
                portalOrderMapper.releaseSkuStockLock(orderItems);
            }
            //返还积分
            if (!StringUtils.isEmpty(cancelOrder.getUseIntegration())) {
                UmsMember member = memberService.getById(cancelOrder.getMemberId());
                memberService.updateIntegration(member.getId(), member.getIntegration() + cancelOrder.getUseIntegration());
            }
        }
        return 1;
    }

    /**
     * 发送延迟消息给rabbitmq 取消订单
     *
     * @param orderId
     */
    @Override
    public void sendDelayMsgCancelOrder(Long orderId) {
        OmsOrderSetting orderSetting = orderSettingMapper.selectByPrimaryKey(1L);
        //120 * 60 * 1000 = 2H
        long delayTimes = orderSetting.getNormalOrderOvertime() * 60 * 1000;
        //发送延迟消息
        cancelOrderSender.sendMsg(orderId, delayTimes);
    }

    /**
     * 设置订单状态
     * @param orderId
     * @param status
     * @return
     */
    @Override
    public int updateOrderStatus(Long orderId, Integer status) {
        OmsOrder order = orderMapper.selectByPrimaryKey(orderId);
        order.setStatus(status);
        return orderMapper.updateByPrimaryKey(order);
    }


    /**
     * 计算总金额
     *
     * @param orderItemList
     * @return
     */
    private BigDecimal calcTotalAmount(List<OmsOrderItem> orderItemList) {
        BigDecimal totalAmount = new BigDecimal("0");
        for (OmsOrderItem item : orderItemList) {
            totalAmount = totalAmount.add(item.getProductPrice().multiply(new BigDecimal(item.getProductQuantity())));
        }
        return totalAmount;
    }

    /**
     * 锁定下单商品的所有库存
     *
     * @param cartPromotionItemList
     */
    private void lockStock(List<CartPromotionItem> cartPromotionItemList) {
        for (CartPromotionItem cartPromotionItem : cartPromotionItemList) {
            PmsSkuStock skuStock = skuStockMapper.selectByPrimaryKey(cartPromotionItem.getProductSkuId());
            skuStock.setLockStock(skuStock.getLockStock() + cartPromotionItem.getQuantity());
            skuStockMapper.updateByPrimaryKeySelective(skuStock);
        }
    }

    /**
     * 计算订单活动优惠
     *
     * @param orderItemList
     * @return
     */
    private BigDecimal calcPromotionAmount(List<OmsOrderItem> orderItemList) {
        BigDecimal promotionAmount = new BigDecimal(0);
        for (OmsOrderItem orderItem : orderItemList) {
            if (orderItem.getPromotionAmount() != null) {
                promotionAmount = promotionAmount.add(orderItem.getPromotionAmount().multiply(new BigDecimal(orderItem.getProductQuantity())));
            }
        }
        return promotionAmount;
    }

    /**
     * 获取订单促销信息
     *
     * @param orderItemList
     * @return
     */
    private String getOrderPromotionInfo(List<OmsOrderItem> orderItemList) {
        StringBuilder sb = new StringBuilder();
        for (OmsOrderItem orderItem : orderItemList) {
            sb.append(orderItem.getPromotionName());
            sb.append(";");
        }
        String result = sb.toString();
        if (result.endsWith(";")) {
            result = result.substring(0, result.length() - 1);
        }
        return result;
    }

    /**
     * 计算订单优惠券金额
     *
     * @param orderItemList
     * @return
     */
    private BigDecimal calcIntegrationAmount(List<OmsOrderItem> orderItemList) {
        BigDecimal integrationAmount = new BigDecimal(0);
        for (OmsOrderItem orderItem : orderItemList) {
            if (orderItem.getIntegrationAmount() != null) {
                integrationAmount = integrationAmount.add(orderItem.getIntegrationAmount().multiply(new BigDecimal(orderItem.getProductQuantity())));
            }
        }
        return integrationAmount;
    }

    /**
     * 计算订单应付金额
     *
     * @param order
     * @return
     */
    private BigDecimal calcPayAmount(OmsOrder order) {
        //总金额+运费-促销优惠-优惠券优惠-积分抵扣
        BigDecimal payAmount = order.getTotalAmount()
                .add(order.getFreightAmount())
                .subtract(order.getPromotionAmount())
                .subtract(order.getCouponAmount())
                .subtract(order.getIntegrationAmount());
        return payAmount;
    }


    /**
     * 生成18位订单编号:8位日期+2位平台号码+2位支付方式+6位以上自增id
     * @param order
     * @return
     */
    private String generateOrderSn(OmsOrder order) {
        StringBuilder sb = new StringBuilder();
        String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String key = REDIS_DATABASE+":"+ REDIS_KEY_ORDER_ID + date;
        Long increment = redisUtils.incr(key, 1);
        sb.append(date);
        sb.append(String.format("%02d", order.getSourceType()));
        sb.append(String.format("%02d", 1));
        String incrementStr = increment.toString();
        if (incrementStr.length() <= 6) {
            sb.append(String.format("%06d", increment));
        } else {
            sb.append(incrementStr);
        }
        return sb.toString();
    }

    /**
     * 删除下单商品的购物车信息
     * @param currentMember
     */
    private void deleteCartItemList(UmsMember currentMember) {
        List<Long> ids = new ArrayList<>();
        List<OmsCartItem> list = cartItemService.list(currentMember.getId());
        for (OmsCartItem omsCartItem : list) {
            ids.add(omsCartItem.getId());
        }
        cartItemService.delete(currentMember.getId(), ids);
    }
}
