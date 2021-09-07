package com.lucien.mall.front.service.impl.oms;

import com.lucien.mall.front.ConfirmOrderResult;
import com.lucien.mall.front.OmsOrderDetail;
import com.lucien.mall.front.OrderParam;
import com.lucien.mall.front.service.oms.OmsPortalOrderService;
import com.lucien.mall.global.GlobalPage;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

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

    @Override
    public ConfirmOrderResult generateConfirmOrder(List<Long> cartIds) {
        return null;
    }

    @Override
    public Map<String, Object> generateOrder(OrderParam param) {
        return null;
    }

    @Override
    public Integer paySuccess(Long orderId, Integer payType) {
        return null;
    }

    @Override
    public void confirmReceiveOrder(Long orderId) {

    }

    @Override
    public GlobalPage<OmsOrderDetail> list(Integer status, Integer pageNum, Integer pageSize) {
        return null;
    }

    @Override
    public OmsOrderDetail getItem(Long orderId) {
        return null;
    }

    @Override
    public void deleteOrder(Long orderId) {

    }

    @Override
    public Integer cancelTimeOutOrder() {
        return null;
    }

    @Override
    public void cancelOrder(Long orderId) {

    }

    @Override
    public void sendDelayMsgCancelOrder(Long orderId) {

    }
}
