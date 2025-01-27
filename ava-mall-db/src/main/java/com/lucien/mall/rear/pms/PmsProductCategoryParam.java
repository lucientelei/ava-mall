package com.lucien.mall.rear.pms;

import com.lucien.mall.validator.FlagValidator;
import io.swagger.annotations.ApiModelProperty;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

/**
 * @Author Lucien
 * @Date 2023/9/1
 * 添加更新产品分类的参数
 */
public class PmsProductCategoryParam {

    @ApiModelProperty("父分类的编号")
    private Long parentId;

    @NotEmpty
    @ApiModelProperty(value = "商品分类名称",required = true)
    private String name;

    @ApiModelProperty("分类单位")
    private String productUnit;

    @FlagValidator(value = {"0","1"},message = "状态只能为0或1")
    @ApiModelProperty("是否在导航栏显示")
    private Integer navStatus;

    @FlagValidator(value = {"0","1"},message = "状态只能为0或1")
    @ApiModelProperty("是否进行显示")
    private Integer showStatus;

    @Min(value = 0)
    @ApiModelProperty("排序")
    private Integer sort;

    @ApiModelProperty("图标")
    private String icon;

    @ApiModelProperty("关键字")
    private String keywords;

    @ApiModelProperty("描述")
    private String description;

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProductUnit() {
        return productUnit;
    }

    public void setProductUnit(String productUnit) {
        this.productUnit = productUnit;
    }

    public Integer getNavStatus() {
        return navStatus;
    }

    public void setNavStatus(Integer navStatus) {
        this.navStatus = navStatus;
    }

    public Integer getShowStatus() {
        return showStatus;
    }

    public void setShowStatus(Integer showStatus) {
        this.showStatus = showStatus;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
