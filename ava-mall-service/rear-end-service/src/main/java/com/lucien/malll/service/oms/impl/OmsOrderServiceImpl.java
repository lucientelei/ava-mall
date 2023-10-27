package com.lucien.malll.service.oms.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.rear.oms.*;
import com.lucien.mall.mapper.OmsOrderMapper;
import com.lucien.mall.mapper.OmsOrderOperateHistoryMapper;
import com.lucien.mall.pojo.OmsOrder;
import com.lucien.mall.pojo.OmsOrderExample;
import com.lucien.mall.pojo.OmsOrderOperateHistory;
import com.lucien.malll.service.oms.OmsOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author Lucien
 * @Date 2023/9/2
 * 后台订单管理Impl
 */
@Service
public class OmsOrderServiceImpl implements OmsOrderService {

    @Autowired
    private OmsOrderMapper orderMapper;

    @Autowired
    private OmsOrderOperateHistoryMapper historyMapper;

    /**
     * 分页查询订单
     * @param param
     * @param pageSize
     * @param pageNum
     * @return
     */
    @Override
    public List<OmsOrder> listPage(OmsOrderQueryParam param, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        return orderMapper.getList(param);
    }

    /**
     * 批量关闭订单
     * @param ids
     * @param note
     * @return
     */
    @Override
    public int close(List<Long> ids, String note) {
        OmsOrder omsOrder = new OmsOrder();
        omsOrder.setStatus(4);
        OmsOrderExample example = new OmsOrderExample();
        example.createCriteria().andDeleteStatusEqualTo(0).andIdIn(ids);
        int count = orderMapper.updateByExampleSelective(omsOrder, example);
        //插入订单操作日志
        List<OmsOrderOperateHistory> historyList = ids.stream().map(orderId -> {
            OmsOrderOperateHistory operateHistory = new OmsOrderOperateHistory();
            operateHistory.setOrderId(orderId);
            operateHistory.setNote("订单关闭:" + note);
//            UmsAdmin umsAdmin = (UmsAdmin) SecurityUtils.getSubject();
            operateHistory.setOperateMan("后台管理员");
            operateHistory.setOrderStatus(4);
            operateHistory.setCreateTime(new Date());
            return operateHistory;
        }).collect(Collectors.toList());
        historyMapper.insertList(historyList);
        return count;
    }

    /**
     * 批量删除订单
     * @param ids
     * @return
     */
    @Override
    public int del(List<Long> ids) {
        OmsOrder omsOrder = new OmsOrder();
        omsOrder.setDeleteStatus(1);
        OmsOrderExample example = new OmsOrderExample();
        example.createCriteria().andDeleteStatusEqualTo(0).andIdIn(ids);
        return orderMapper.updateByExampleSelective(omsOrder, example);
    }

    /**
     * 批量发货
     * @param params
     * @return
     */
    @Override
    public int delivery(List<OmsOrderDeliveryParam> params) {
        int count = orderMapper.delivery(params);
        List<OmsOrderOperateHistory> historyList = params.stream().map(DeliveryParam -> {
            OmsOrderOperateHistory operateHistory = new OmsOrderOperateHistory();
            operateHistory.setOrderId(DeliveryParam.getOrderId());
            operateHistory.setCreateTime(new Date());
            operateHistory.setOrderStatus(2);
            operateHistory.setNote("商家发货");
            operateHistory.setOperateMan("后台管理员");
            return operateHistory;
        }).collect(Collectors.toList());
        historyMapper.insertList(historyList);
        return count;
    }

    /**
     * 获取订单详情
     * @param id
     * @return
     */
    @Override
    public OmsOrderDetail getItem(Long id) {
        return orderMapper.getDetail(id);
    }

    /**
     * 修改订单费用信息
     * @param param
     * @return
     */
    @Override
    public int updateMoneyInfo(OmsMoneyInfoParam param) {
        OmsOrder omsOrder = new OmsOrder();
        omsOrder.setId(param.getOrderId());
        omsOrder.setFreightAmount(param.getFreightAmount());
        omsOrder.setDiscountAmount(param.getDiscountAmount());
        omsOrder.setModifyTime(new Date());
        int count = orderMapper.updateByPrimaryKeySelective(omsOrder);

        OmsOrderOperateHistory history = new OmsOrderOperateHistory();
        history.setOrderId(param.getOrderId());
        history.setCreateTime(new Date());
        history.setNote("修改费用信息");
        history.setOperateMan("后台管理员");
        history.setOrderStatus(param.getStatus());
        historyMapper.insert(history);
        return count;
    }

    /**
     * 修改订单备注信息
     * @param id
     * @param note
     * @param status
     * @return
     */
    @Override
    public int updateNote(Long id, String note, Integer status) {
        OmsOrder omsOrder = new OmsOrder();
        omsOrder.setId(id);
        omsOrder.setNote(note);
        omsOrder.setModifyTime(new Date());
        int count = orderMapper.updateByPrimaryKeySelective(omsOrder);
        System.out.println(count);
        OmsOrderOperateHistory history = new OmsOrderOperateHistory();
        history.setOrderId(id);
        history.setCreateTime(new Date());
        history.setNote("修改订单备注信息:" + note);
        history.setOperateMan("后台管理员");
        history.setOrderStatus(status);
        historyMapper.insert(history);
        return count;
    }

    /**
     * 修改收件人信息
     * @param param
     * @return
     */
    @Override
    public int updateReceiverInfo(OmsReceiverInfoParam param) {
        OmsOrder omsOrder = new OmsOrder();
        omsOrder.setId(param.getOrderId());
        omsOrder.setReceiverName(param.getReceiverName());
        omsOrder.setReceiverPhone(param.getReceiverPhone());
        omsOrder.setReceiverPostCode(param.getReceiverPostCode());
        omsOrder.setReceiverDetailAddress(param.getReceiverDetailAddress());
        omsOrder.setReceiverCity(param.getReceiverCity());
        omsOrder.setReceiverRegion(param.getReceiverRegion());
        omsOrder.setModifyTime(new Date());
        int count = orderMapper.updateByPrimaryKeySelective(omsOrder);

        OmsOrderOperateHistory history = new OmsOrderOperateHistory();
        history.setOrderId(param.getOrderId());
        history.setOrderStatus(param.getStatus());
        history.setOperateMan("后台管理员");
        history.setCreateTime(new Date());
        history.setNote("修改收件人信息");
        historyMapper.insert(history);
        return count;
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

}
