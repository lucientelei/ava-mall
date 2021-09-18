package com.lucien.mall.front.service.oms.impl;

import cn.hutool.core.collection.CollUtil;
import com.lucien.mall.front.CartPromotionItem;
import com.lucien.mall.front.service.oms.OmsCartItemService;
import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.mapper.OmsCartItemMapper;
import com.lucien.mall.mapper.PortalProductMapper;
import com.lucien.mall.pojo.OmsCartItem;
import com.lucien.mall.pojo.OmsCartItemExample;
import com.lucien.mall.pojo.UmsMember;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author Lucien
 * @Date 2021/9/6
 * 购物车Impl
 */
@Primary
@Service
public class OmsCartItemServiceImpl implements OmsCartItemService {

    @Autowired
    private OmsCartItemMapper cartItemMapper;

    @Autowired
    private UmsMemberService memberService;

    @Autowired
    private PortalProductMapper portalProductMapper;


    /**
     * 根据会员id,商品id和规格获取购物车中商品
     *
     * @param cartItem
     * @return
     */
    public OmsCartItem getCartItem(OmsCartItem cartItem) {
        OmsCartItemExample example = new OmsCartItemExample();
        OmsCartItemExample.Criteria criteria = example.createCriteria().andMemberIdEqualTo(cartItem.getMemberId())
                .andProductIdEqualTo(cartItem.getProductId()).andDeleteStatusEqualTo(0);
        if (!StringUtils.isEmpty(cartItem.getProductSkuId())) {
            criteria.andProductSkuIdEqualTo(cartItem.getProductSkuId());
        }
        List<OmsCartItem> omsCartItems = cartItemMapper.selectByExample(example);
        if (!CollectionUtils.isEmpty(omsCartItems)) {
            return omsCartItems.get(0);
        }
        return null;
    }

    /**
     * 查询购物车中是否包含该商品，有增加数量，无添加到购物车
     *
     * @param cartItem
     * @return
     */
    @Override
    public int add(OmsCartItem cartItem) {
        int count;
        UmsMember umsMember = memberService.getCurrentMember();
        cartItem.setMemberId(umsMember.getId());
        cartItem.setMemberNickname(umsMember.getNickname());
        cartItem.setDeleteStatus(0);
        OmsCartItem existCartItem = getCartItem(cartItem);
        if (existCartItem == null) {
            cartItem.setCreateDate(new Date());
            count = cartItemMapper.insert(cartItem);
        } else {
            cartItem.setModifyDate(new Date());
            //修改数量
            existCartItem.setQuantity(existCartItem.getQuantity() + cartItem.getQuantity());
            count = cartItemMapper.updateByPrimaryKeySelective(existCartItem);
        }
        return count;
    }

    /**
     * 根据会员编号获取购物车列表
     *
     * @param memberId
     * @return
     */
    @Override
    public List<OmsCartItem> list(Long memberId) {
        OmsCartItemExample example = new OmsCartItemExample();
        example.createCriteria().andDeleteStatusEqualTo(0).andMemberIdEqualTo(memberId);
        return cartItemMapper.selectByExample(example);
    }

    /**
     * 修改某个购物车商品的数量
     *
     * @param id
     * @param memberId
     * @param quantity
     * @return
     */
    @Override
    public int updateQuantity(Long id, Long memberId, Integer quantity) {
        OmsCartItem item = new OmsCartItem();
        item.setQuantity(quantity);
        OmsCartItemExample example = new OmsCartItemExample();
        example.createCriteria().andDeleteStatusEqualTo(0)
                .andIdEqualTo(id).andMemberIdEqualTo(memberId);
        return cartItemMapper.updateByExampleSelective(item, example);
    }

    /**
     * 批量删除购物车中的商品
     *
     * @param memberId
     * @param ids
     * @return
     */
    @Override
    public int delete(Long memberId, List<Long> ids) {
        OmsCartItem cartItem = new OmsCartItem();
        cartItem.setDeleteStatus(1);
        OmsCartItemExample example = new OmsCartItemExample();
        example.createCriteria().andIdIn(ids).andMemberIdEqualTo(memberId);
        return cartItemMapper.updateByExampleSelective(cartItem, example);
    }

    /**
     * 修改购物车中商品的规格
     *
     * @param cartItem
     * @return
     */
    @Override
    public int updateAttr(OmsCartItem cartItem) {
        //删除原购物车信息
        OmsCartItem updateCart = new OmsCartItem();
        updateCart.setId(cartItem.getId());
        updateCart.setModifyDate(new Date());
        updateCart.setDeleteStatus(1);
        cartItemMapper.updateByPrimaryKeySelective(updateCart);
        cartItem.setId(null);
        add(cartItem);
        return 1;
    }

    /**
     * 清空购物车
     *
     * @param memberId
     * @return
     */
    @Override
    public int clear(Long memberId) {
        OmsCartItem cartItem = new OmsCartItem();
        cartItem.setDeleteStatus(1);
        OmsCartItemExample example = new OmsCartItemExample();
        example.createCriteria().andMemberIdEqualTo(memberId);
        return cartItemMapper.updateByExampleSelective(cartItem, example);
    }

    /**
     * 通过ids获取购物车商品数据
     * @param ids
     * @return
     */
    @Override
    public List<OmsCartItem> listByIds(List<Long> ids) {
        OmsCartItemExample example = new OmsCartItemExample();
        example.createCriteria().andIdIn(ids);
        return cartItemMapper.selectByExample(example);
    }
}
