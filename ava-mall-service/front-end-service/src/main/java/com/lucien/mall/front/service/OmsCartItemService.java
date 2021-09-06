package com.lucien.mall.front.service;

import com.lucien.mall.front.CartProduct;
import com.lucien.mall.front.CartPromotionItem;
import com.lucien.mall.pojo.OmsCartItem;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/6
 * 购物车管理Service
 */
public interface OmsCartItemService {

    /**
     * 查询购物车中是否包含该商品，有增加数量，无添加到购物车
     * @param cartItem
     * @return
     */
    @Transactional
    int add(OmsCartItem cartItem);

    /**
     * 根据会员编号获取购物车列表
     * @param memberId
     * @return
     */
    List<OmsCartItem> list(Long memberId);

    /**
     * 获取包含促销活动信息的购物车列表
     * @param memberId
     * @param cartIds
     * @return
     */
    List<CartPromotionItem> listPromotion(Long memberId, List<Long> cartIds);

    /**
     * 修改某个购物车商品的数量
     * @param id
     * @param memberId
     * @param quantity
     * @return
     */
    int updateQuantity(Long id, Long memberId, Integer quantity);

    /**
     * 批量删除购物车中的商品
     * @param memberId
     * @param ids
     * @return
     */
    int delete(Long memberId, List<Long> ids);

    /**
     * 获取购物车中用于选择商品规格的商品信息
     * @param productId
     * @return
     */
    CartProduct getCartProduct(Long productId);

    /**
     * 修改购物车中商品的规格
     * @param cartItem
     * @return
     */
    @Transactional
    int updateAttr(OmsCartItem cartItem);

    /**
     * 清空购物车
     * @param memberId
     * @return
     */
    int clear(Long memberId);


}
