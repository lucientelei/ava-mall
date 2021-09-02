package com.lucien.malll.service.oms.impl;

import com.lucien.mall.mapper.OmsOrderSettingMapper;
import com.lucien.mall.pojo.OmsOrderSetting;
import com.lucien.malll.service.oms.OmsOrderSettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author Lucien
 * @Date 2021/9/2
 * 订单设置管理Impl
 */
@Service
public class OmsOrderSettingServiceImpl implements OmsOrderSettingService {

    @Autowired
    private OmsOrderSettingMapper settingMapper;

    /**
     * 更新订单设置
     * @param id
     * @param orderSetting
     * @return
     */
    @Override
    public int update(Long id, OmsOrderSetting orderSetting) {
        orderSetting.setId(id);
        return settingMapper.updateByPrimaryKey(orderSetting);
    }

    /**
     * 获取订单设置
     * @param id
     * @return
     */
    @Override
    public OmsOrderSetting getItem(Long id) {
        return settingMapper.selectByPrimaryKey(id);
    }
}
