package com.lucien.mall.front.service.ums.impl;

import com.lucien.mall.front.service.ums.UmsMemberReceiveAddressService;
import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.mapper.UmsMemberReceiveAddressMapper;
import com.lucien.mall.pojo.UmsMember;
import com.lucien.mall.pojo.UmsMemberReceiveAddress;
import com.lucien.mall.pojo.UmsMemberReceiveAddressExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/31
 * 会员收货地址管理Impl
 */
@Service
@Primary
public class UmsMemberReceiveAddressServiceImpl implements UmsMemberReceiveAddressService {

    @Autowired
    private UmsMemberReceiveAddressMapper addressMapper;

    @Autowired
    private UmsMemberService memberService;

    /**
     * 获取当前会员的收货地址
     * @return
     */
    @Override
    public List<UmsMemberReceiveAddress> list() {
        UmsMemberReceiveAddressExample example = new UmsMemberReceiveAddressExample();
        example.createCriteria().andMemberIdEqualTo(memberService.getCurrentMember().getId());

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
        UmsMember member = memberService.getCurrentMember();
        address.setMemberId(member.getId());

        if (address.getDefaultStatus() == 1){
            UmsMemberReceiveAddressExample example = new UmsMemberReceiveAddressExample();
            example.createCriteria().andMemberIdEqualTo(member.getId()).andDefaultStatusEqualTo(1);
            List<UmsMemberReceiveAddress> receiveAddresses = addressMapper.selectByExample(example);
            if (receiveAddresses.size() > 0){
                UmsMemberReceiveAddress recordAddress = receiveAddresses.get(0);
                recordAddress.setDefaultStatus(0);
                addressMapper.updateByPrimaryKeySelective(recordAddress);
            }
        }

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
        UmsMember member = memberService.getCurrentMember();
        address.setId(id);
        if (address.getDefaultStatus() == 1){
            UmsMemberReceiveAddressExample example = new UmsMemberReceiveAddressExample();
            example.createCriteria().andMemberIdEqualTo(member.getId()).andDefaultStatusEqualTo(1);
            List<UmsMemberReceiveAddress> receiveAddresses = addressMapper.selectByExample(example);
            if (receiveAddresses.size() > 0){
                UmsMemberReceiveAddress recordAddress = receiveAddresses.get(0);
                recordAddress.setDefaultStatus(0);
                addressMapper.updateByPrimaryKey(recordAddress);
            }
        }
        return addressMapper.updateByPrimaryKeySelective(address);
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

    /**
     * 获取用户默认地址
     * @return
     */
    @Override
    public UmsMemberReceiveAddress getDefaultAddress() {
        UmsMember member = memberService.getCurrentMember();
        UmsMemberReceiveAddressExample example = new UmsMemberReceiveAddressExample();
        example.createCriteria().andMemberIdEqualTo(member.getId()).andDefaultStatusEqualTo(1);
        return addressMapper.selectByExample(example).get(0);
    }
}
