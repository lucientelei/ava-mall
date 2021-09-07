package com.lucien.mall.front.service.ums;

import com.lucien.mall.pojo.UmsMemberReceiveAddress;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/31
 * 会员收货地址管理Service
 */
public interface UmsMemberReceiveAddressService {

    /**
     * 获取当前会员的收货地址
     * @return
     */
    List<UmsMemberReceiveAddress> list();

    /**
     * 添加收货地址
     * @param address
     * @return
     */
    int insert(UmsMemberReceiveAddress address);

    /**
     * 删除收货地址
     * @param id
     * @return
     */
    int del(Long id);

    /**
     * 更新收货地址
     * @param id
     * @param address
     * @return
     */
    int update(Long id, UmsMemberReceiveAddress address);

    /**
     * 获取地址详情
     * @param id
     * @return
     */
    UmsMemberReceiveAddress getItem(Long id);
}
