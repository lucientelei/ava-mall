package com.lucien.mall.front.service.impl;

import com.lucien.mall.front.service.UmsMemberReceiveAddressService;
import com.lucien.mall.mapper.UmsMemberReceiveAddressMapper;
import com.lucien.mall.pojo.UmsMember;
import com.lucien.mall.pojo.UmsMemberReceiveAddress;
import com.lucien.mall.pojo.UmsMemberReceiveAddressExample;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/31
 * 会员收货地址管理Impl
 */
@Primary
@Service
public class UmsMemberReceiveAddressServiceImpl implements UmsMemberReceiveAddressService {

    @Autowired
    private UmsMemberReceiveAddressMapper addressMapper;

    /**
     * 获取当前会员的收货地址
     * @return
     */
    @Override
    public List<UmsMemberReceiveAddress> list() {
        UmsMember umsMember = (UmsMember) SecurityUtils.getSubject().getPrincipal();
        UmsMemberReceiveAddressExample example = new UmsMemberReceiveAddressExample();
        example.createCriteria().andMemberIdEqualTo(umsMember.getId());

        List<UmsMemberReceiveAddress> addresses = addressMapper.selectByExample(example);

        return addresses;
    }

    /**
     * 添加收货地址
     * @param address
     * @return
     */
    @Override
    public int insert(UmsMemberReceiveAddress address) {
        return addressMapper.insert(address);
    }

    /**
     * 删除收货地址
     * @param id
     * @return
     */
    @Override
    public int del(Long id) {
        return addressMapper.deleteByPrimaryKey(id);
    }

    /**
     * 更新收货地址
     * @param id
     * @param address
     * @return
     */
    @Override
    public int update(Long id, UmsMemberReceiveAddress address) {
        address.setId(id);
        int count = addressMapper.updateByPrimaryKeySelective(address);
        return count;
    }

    /**
     * 获取地址详情
     * @param id
     * @return
     */
    @Override
    public UmsMemberReceiveAddress getItem(Long id) {
        return addressMapper.selectByPrimaryKey(id);
    }
}
