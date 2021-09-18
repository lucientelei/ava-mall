package com.lucien.mall.front;

import com.lucien.mall.pojo.PmsBrand;
import com.lucien.mall.pojo.PmsProduct;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/6
 * 首页内容返回信息
 */
public class HomeContentResult {

    //推荐品牌
    private List<PmsBrand> brandList;

    //新品推荐
    private List<PmsProduct> newProductList;

    //人气推荐
    private List<PmsProduct> hotProductList;

    public List<PmsBrand> getBrandList() {
        return brandList;
    }

    public void setBrandList(List<PmsBrand> brandList) {
        this.brandList = brandList;
    }

    public List<PmsProduct> getNewProductList() {
        return newProductList;
    }

    public void setNewProductList(List<PmsProduct> newProductList) {
        this.newProductList = newProductList;
    }

    public List<PmsProduct> getHotProductList() {
        return hotProductList;
    }

    public void setHotProductList(List<PmsProduct> hotProductList) {
        this.hotProductList = hotProductList;
    }

    }
