package com.lucien.mall.front;

import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/7
 * 生成订单时参数
 */
public class OrderParam {

    @ApiModelProperty("收货地址ID")
    private Long memberReceiveAddressId;

    @ApiModelProperty("优惠券ID")
    private Long couponId;

    @ApiModelProperty("使用的积分数")
    private Integer useIntegration;

    @ApiModelProperty("支付方式")
    private Integer payType;

    @ApiModelProperty("被选中的购物车商品ID")
    private List<Long> cartIds;

    public Long getMemberReceiveAddressId() {
        return memberReceiveAddressId;
    }

    public void setMemberReceiveAddressId(Long memberReceiveAddressId) {
        this.memberReceiveAddressId = memberReceiveAddressId;
    }

    public Long getCouponId() {
        return couponId;
    }

    public void setCouponId(Long couponId) {
        this.couponId = couponId;
    }

    public Integer getUseIntegration() {
        return useIntegration;
    }

    public void setUseIntegration(Integer useIntegration) {
        this.useIntegration = useIntegration;
    }

    public Integer getPayType() {
        return payType;
    }

    public void setPayType(Integer payType) {
        this.payType = payType;
    }

    public List<Long> getCartIds() {
        return cartIds;
    }

    public void setCartIds(List<Long> cartIds) {
        this.cartIds = cartIds;
    }
}
