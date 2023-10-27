package com.lucien.mall.front.service.oms;

import com.lucien.mall.front.OmsOrderReturnApplyParam;
import com.lucien.mall.pojo.OmsOrderReturnReason;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/7
 * 前台订单退货申请Service
 */
public interface OmsPortalOrderReturnApplyService {

    /**
     * 提交申请
     * @param param
     * @return
     */
    int insert(OmsOrderReturnApplyParam param);

    /**
     * 获取全部退货原因
     * @return
     */
    List<OmsOrderReturnReason> listReason();

    /**
     * 获取退货订单状态
     * @param orderId
     * @return
     */
    int applyStatus(Long orderId);

    /**
     * 判断订单是否被删除
     * @param orderId
     * @return
     */
    boolean isOrderExit(Long orderId);
}
