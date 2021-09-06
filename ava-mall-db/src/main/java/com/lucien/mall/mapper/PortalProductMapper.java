package com.lucien.mall.mapper;

import com.lucien.mall.front.CartProduct;
import com.lucien.mall.front.PromotionProduct;
import com.lucien.mall.pojo.SmsCoupon;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/6
 * 前台购物车商品管理自定义mapper
 */
public interface PortalProductMapper {

    /**
     * 获取购物车商品信息
     */
    CartProduct getCartProduct(@Param("id") Long id);

    /**
     * 获取促销商品信息列表
     */
    List<PromotionProduct> getPromotionProductList(@Param("ids") List<Long> ids);

    /**
     * 获取可用优惠券列表
     */
    List<SmsCoupon> getAvailableCouponList(@Param("productId") Long productId, @Param("productCategoryId") Long productCategoryId);

}
