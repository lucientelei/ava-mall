package com.lucien.malll.service.oms;

import com.lucien.mall.pojo.OmsOrderSetting;

/**
 * @Author Lucien
 * @Date 2023/9/2
 * 订单设置管理Service
 */
public interface OmsOrderSettingService {

    /**
     * 更新订单设置
     * @param id
     * @param orderSetting
     * @return
     */
    int update(Long id, OmsOrderSetting orderSetting);

    /**
     * 获取订单设置
     * @param id
     * @return
     */
    OmsOrderSetting getItem(Long id);
}
