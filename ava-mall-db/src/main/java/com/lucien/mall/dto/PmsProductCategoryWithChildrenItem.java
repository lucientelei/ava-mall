package com.lucien.mall.dto;

import com.lucien.mall.pojo.PmsProductCategory;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 携带子级分类的商品分类目录
 */
public class PmsProductCategoryWithChildrenItem extends PmsProductCategory {

    @ApiModelProperty("子级分类")
    private List<PmsProductCategory> children;

    public List<PmsProductCategory> getChildren() {
        return children;
    }

    public void setChildren(List<PmsProductCategory> children) {
        this.children = children;
    }
}
