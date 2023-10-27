package com.lucien.mall.mapper;

import com.lucien.mall.pojo.OmsOrderItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/8
 * 订单商品信息管理自定义Mapper
 */
public interface PortalOrderItemMapper {

    /**
     * 批量插入
     */
    int insertList(@Param("list") List<OmsOrderItem> list);
}
