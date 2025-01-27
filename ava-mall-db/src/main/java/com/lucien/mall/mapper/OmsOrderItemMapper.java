package com.lucien.mall.mapper;

import com.lucien.mall.pojo.OmsOrderItem;
import com.lucien.mall.pojo.OmsOrderItemExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OmsOrderItemMapper {
    long countByExample(OmsOrderItemExample example);

    int deleteByExample(OmsOrderItemExample example);

    int deleteByPrimaryKey(Long id);

    int insert(OmsOrderItem record);

    int insertSelective(OmsOrderItem record);

    List<OmsOrderItem> selectByExample(OmsOrderItemExample example);

    OmsOrderItem selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") OmsOrderItem record, @Param("example") OmsOrderItemExample example);

    int updateByExample(@Param("record") OmsOrderItem record, @Param("example") OmsOrderItemExample example);

    int updateByPrimaryKeySelective(OmsOrderItem record);

    int updateByPrimaryKey(OmsOrderItem record);

    /**
     * 批量插入
     */
    int insertList(@Param("list") List<OmsOrderItem> list);
}