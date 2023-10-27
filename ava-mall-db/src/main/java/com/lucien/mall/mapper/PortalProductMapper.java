package com.lucien.mall.mapper;

import com.lucien.mall.pojo.OmsCartItem;
import org.apache.ibatis.annotations.Param;

/**
 * @Author Lucien
 * @Date 2023/9/6
 * 前台购物车商品管理自定义mapper
 */
public interface PortalProductMapper {

    /**
     * 获取购物车商品信息
     */
    OmsCartItem getCartProduct(@Param("id") Long id);

}
