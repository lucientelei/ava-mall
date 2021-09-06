package com.lucien.mall.front.service;

import com.lucien.mall.front.CartPromotionItem;
import com.lucien.mall.pojo.OmsCartItem;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/6
 * 促销管理Service
 */
public interface OmsPromotionService {

    /**
     * 计算购物车中的促销活动信息
     * @param cartItemList
     * @return
     */
    List<CartPromotionItem> calcCartPromotion(List<OmsCartItem> cartItemList);
}
