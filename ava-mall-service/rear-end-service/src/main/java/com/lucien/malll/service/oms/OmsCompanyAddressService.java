package com.lucien.malll.service.oms;

import com.lucien.mall.pojo.OmsCompanyAddress;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/2
 * 收货地址管理Service
 */
public interface OmsCompanyAddressService {

    /**
     * 获取全部收货地址
     * @return
     */
    List<OmsCompanyAddress> list();
}
