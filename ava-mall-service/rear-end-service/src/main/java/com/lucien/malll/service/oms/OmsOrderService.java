package com.lucien.malll.service.oms;

import com.lucien.mall.rear.oms.*;
import com.lucien.mall.pojo.OmsOrder;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/2
 * 后台订单管理Service
 */
public interface OmsOrderService {

    /**
     * 分页查询订单
     * @param param
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<OmsOrder> listPage(OmsOrderQueryParam param, Integer pageSize, Integer pageNum);

    /**
     * 批量关闭订单
     * @param ids
     * @param note
     * @return
     */
    int close(List<Long> ids, String note);

    /**
     * 批量删除订单
     * @param ids
     * @return
     */
    int del(List<Long> ids);

    /**
     * 批量发货
     * @param params
     * @return
     */
    int delivery(List<OmsOrderDeliveryParam> params);

    /**
     * 获取订单详情
     * @param id
     * @return
     */
    OmsOrderDetail getItem(Long id);

    /**
     * 修改订单费用信息
     * @param param
     * @return
     */
    int updateMoneyInfo(OmsMoneyInfoParam param);

    /**
     * 修改订单备注信息
     * @param id
     * @param note
     * @param status
     * @return
     */
    int updateNote(Long id, String note, Integer status);

    /**
     * 修改收件人信息
     * @param param
     * @return
     */
    int updateReceiverInfo(OmsReceiverInfoParam param);
}
