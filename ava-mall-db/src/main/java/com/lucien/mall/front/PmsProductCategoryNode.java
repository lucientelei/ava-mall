package com.lucien.mall.front;

import com.lucien.mall.pojo.PmsProductCategory;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/7
 * 商品分类，包含子分类
 */
public class PmsProductCategoryNode extends PmsProductCategory {

    private List<PmsProductCategoryNode> children;

    public List<PmsProductCategoryNode> getChildren() {
        return children;
    }

    public void setChildren(List<PmsProductCategoryNode> children) {
        this.children = children;
    }
}
