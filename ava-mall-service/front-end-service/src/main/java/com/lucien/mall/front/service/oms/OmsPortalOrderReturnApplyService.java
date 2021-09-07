package com.lucien.mall.front.service.oms;

import com.lucien.mall.front.OmsOrderReturnApplyParam;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 前台订单退货申请Service
 */
public interface OmsPortalOrderReturnApplyService {

    /**
     * 提交申请
     * @param param
     * @return
     */
    int insert(OmsOrderReturnApplyParam param);
}
