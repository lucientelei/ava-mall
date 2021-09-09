package com.lucien.mall.front.service.impl;

import com.alipay.easysdk.factory.Factory;
import com.alipay.easysdk.kernel.util.ResponseChecker;
import com.alipay.easysdk.payment.page.models.AlipayTradePagePayResponse;
import com.lucien.mall.front.service.AlipayService;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

/**
 * @Author Lucien
 * @Date 2021/9/9
 * 支付宝沙箱支付Impl
 */
@Service
@Primary
public class AlipayServiceImpl implements AlipayService {


    /**
     * 生成支付表单
     *
     * @param subject 商品描述
     * @param money   支付金额
     * @param tradeNo 订单号
     * @return 返回一个支付表单
     * @throws Exception
     */
    @Override
    public String toPay(String subject, BigDecimal money, String tradeNo) {
        String payForm = null;
        try {
            AlipayTradePagePayResponse pay =
                    Factory.Payment.Page().pay(subject, tradeNo, String.valueOf(money), "https://cn.bing.com/");

            if (ResponseChecker.success(pay)) {
                payForm = pay.getBody();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return payForm;

    }
}
