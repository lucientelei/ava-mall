package com.lucien.mall.mapper;

import com.lucien.mall.front.FlashPromotionProduct;
import com.lucien.mall.pojo.PmsBrand;
import com.lucien.mall.pojo.PmsProduct;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/6
 * 首页内容管理
 */
public interface HomeMapper {

    /**
     * 获取推荐品牌
     */
    List<PmsBrand> getRecommendBrandList(@Param("offset") Integer offset, @Param("limit") Integer limit);

    /**
     * 获取秒杀商品
     */
    List<FlashPromotionProduct> getFlashProductList(@Param("flashPromotionId") Long flashPromotionId, @Param("sessionId") Long sessionId);

    /**
     * 获取新品推荐
     */
    List<PmsProduct> getNewProductList(@Param("offset") Integer offset, @Param("limit") Integer limit);
    /**
     * 获取人气推荐
     */
    List<PmsProduct> getHotProductList(@Param("offset") Integer offset,@Param("limit") Integer limit);
    
}
