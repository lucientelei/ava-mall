package com.lucien.mall.search.pojo;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 搜索商品的品牌名称，分类名称及属性
 */
public class EsProductRelatedInfo {

    private List<String> brandNames;

    private List<String> productCategoryNames;

    private List<ProductAttr> productAttrs;

    public List<String> getBrandNames() {
        return brandNames;
    }

    public void setBrandNames(List<String> brandNames) {
        this.brandNames = brandNames;
    }

    public List<String> getProductCategoryNames() {
        return productCategoryNames;
    }

    public void setProductCategoryNames(List<String> productCategoryNames) {
        this.productCategoryNames = productCategoryNames;
    }

    public List<ProductAttr> getProductAttrs() {
        return productAttrs;
    }

    public void setProductAttrs(List<ProductAttr> productAttrs) {
        this.productAttrs = productAttrs;
    }

    public static class ProductAttr {
        private Long attrId;
        private String attrName;
        private List<String> attrValues;
    }
}
