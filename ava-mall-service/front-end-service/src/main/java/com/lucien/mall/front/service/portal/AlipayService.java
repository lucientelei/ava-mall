package com.lucien.mall.front.service.portal;

import java.math.BigDecimal;

/**
 * @Author Lucien
 * @Date 2023/9/9
 * 支付宝沙箱支付Service
 */
public interface AlipayService {

    /**
     * 生成支付表单
     * @param subject 商品描述
     * @param money 支付金额
     * @param tradeNo 订单号
     * @return 返回一个支付表单
     * @throws Exception
     */
    String toPay(String subject, BigDecimal money, String tradeNo);

    String getCode(BigDecimal money, String tradeNo);
}
