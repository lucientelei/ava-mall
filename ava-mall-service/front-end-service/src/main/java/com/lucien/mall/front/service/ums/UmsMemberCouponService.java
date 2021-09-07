package com.lucien.mall.front.service.ums;

import com.lucien.mall.front.CartPromotionItem;
import com.lucien.mall.front.SmsCouponHistoryDetail;
import com.lucien.mall.pojo.SmsCoupon;
import com.lucien.mall.pojo.SmsCouponHistory;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 用户优惠券Service
 */
public interface UmsMemberCouponService {

    /**
     * 添加优惠券
     * @param couponId
     */
    int add(Long couponId);

    /**
     * 获取优惠券历史列表
     * @param useStatus
     * @return
     */
    List<SmsCouponHistory> listHistory(Integer useStatus);

    /**
     * 获取用户优惠券列表
     * @param useStatus
     * @return
     */
    List<SmsCoupon> listCoupon(Integer useStatus);

    /**
     * 获取商品相关的优惠券
     * @param productId
     * @return
     */
    List<SmsCoupon> listByProduct(Long productId);

    /**
     * 根据购物车信息 获取优惠券信息
     * @param cartItemList
     * @param type
     * @return
     */
    List<SmsCouponHistoryDetail> listCart(List<CartPromotionItem> cartItemList, Integer type);

}
