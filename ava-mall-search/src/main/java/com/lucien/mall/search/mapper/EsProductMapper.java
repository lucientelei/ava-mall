package com.lucien.mall.search.mapper;

import com.lucien.mall.search.pojo.EsProduct;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/7
 * 搜索商品管理自定义Mapper
 */
public interface EsProductMapper {

    /**
     * 获取指定ID的搜索商品
     * @param id
     * @return
     */
    List<EsProduct> getAllEsProductList(@Param("id") Long id);

}
