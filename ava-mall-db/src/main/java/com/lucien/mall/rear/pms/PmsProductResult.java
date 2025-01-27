package com.lucien.mall.rear.pms;

import io.swagger.annotations.ApiModelProperty;

/**
 * @Author Lucien
 * @Date 2023/9/1
 * 查询单个产品进行修改时返回的结果
 */
public class PmsProductResult extends PmsProductParam{

    @ApiModelProperty("商品所选分类的父id")
    private Long cateParentId;

    public Long getCateParentId() {
        return cateParentId;
    }

    public void setCateParentId(Long cateParentId) {
        this.cateParentId = cateParentId;
    }
}
