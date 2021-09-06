package com.lucien.mall.rear.ums;

import com.lucien.mall.pojo.UmsMenu;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/27
 * 后台菜单节点封装
 */
public class UmsMenuNode extends UmsMenu {

    @ApiModelProperty(value = "子级菜单")
    private List<UmsMenuNode> children;

    public List<UmsMenuNode> getChildren() {
        return children;
    }

    public void setChildren(List<UmsMenuNode> children) {
        this.children = children;
    }
}
