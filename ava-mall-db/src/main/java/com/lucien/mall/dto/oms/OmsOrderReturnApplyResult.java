package com.lucien.mall.dto.oms;

import com.lucien.mall.pojo.OmsCompanyAddress;
import com.lucien.mall.pojo.OmsOrderReturnApply;
import io.swagger.annotations.ApiModelProperty;

/**
 * @Author Lucien
 * @Date 2021/9/2
 * 退货申请信息封装
 */
public class OmsOrderReturnApplyResult extends OmsOrderReturnApply {

    @ApiModelProperty(value = "公司收货地址")
    private OmsCompanyAddress companyAddress;

    public OmsCompanyAddress getCompanyAddress() {
        return companyAddress;
    }

    public void setCompanyAddress(OmsCompanyAddress companyAddress) {
        this.companyAddress = companyAddress;
    }
}
