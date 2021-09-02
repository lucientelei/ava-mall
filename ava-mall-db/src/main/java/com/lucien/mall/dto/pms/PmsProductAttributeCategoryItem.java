package com.lucien.mall.dto.pms;

import com.lucien.mall.pojo.PmsProductAttribute;
import com.lucien.mall.pojo.PmsProductAttributeCategory;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 包含有分类下属性的dto
 */
public class PmsProductAttributeCategoryItem extends PmsProductAttributeCategory {

    @ApiModelProperty(value = "商品属性列表")
    private List<PmsProductAttribute> productAttributeList;

    public List<PmsProductAttribute> getProductAttributeList() {
        return productAttributeList;
    }

    public void setProductAttributeList(List<PmsProductAttribute> productAttributeList) {
        this.productAttributeList = productAttributeList;
    }
}

