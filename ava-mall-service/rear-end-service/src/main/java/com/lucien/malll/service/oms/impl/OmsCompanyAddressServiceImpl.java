package com.lucien.malll.service.oms.impl;

import com.lucien.mall.mapper.OmsCompanyAddressMapper;
import com.lucien.mall.pojo.OmsCompanyAddress;
import com.lucien.mall.pojo.OmsCompanyAddressExample;
import com.lucien.malll.service.oms.OmsCompanyAddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/2
 * 收货地址管理Impl
 */
@Service
public class OmsCompanyAddressServiceImpl implements OmsCompanyAddressService {

    @Autowired
    private OmsCompanyAddressMapper addressMapper;

    /**
     * 获取全部收货地址
     * @return
     */
    @Override
    public List<OmsCompanyAddress> list() {
        return addressMapper.selectByExample(new OmsCompanyAddressExample());
    }
}
