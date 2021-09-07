package com.lucien.mall.front.service.impl.ums;

import com.lucien.mall.front.service.ums.UmsMemberReceiveAddressService;
import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.mapper.UmsMemberReceiveAddressMapper;
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
        address.setMemberId(memberService.getCurrentMember().getId());
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
