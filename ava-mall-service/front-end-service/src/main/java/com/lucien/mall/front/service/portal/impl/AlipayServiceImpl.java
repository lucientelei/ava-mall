package com.lucien.mall.front.service.portal.impl;

import com.alipay.easysdk.factory.Factory;
import com.alipay.easysdk.kernel.util.ResponseChecker;
import com.alipay.easysdk.payment.page.models.AlipayTradePagePayResponse;
import com.lucien.mall.front.service.portal.AlipayService;
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

    private static final String returnURL = "http://localhost:8710/order";

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
                    Factory.Payment.Page().pay(subject, tradeNo, String.valueOf(money), returnURL);

            if (ResponseChecker.success(pay)) {
                payForm = pay.getBody();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return payForm;

    }

    @Override
    public String payTest() {
//        String order_no = UUID.randomUUID().toString();    //77777777
//        String body = "";
//        String total_fee = "999.99";  //真实金钱
//        AlipayClient alipayClient = new DefaultAlipayClient(aliPayConfig.getGatewayUrl(), aliPayConfig.getAppID(), aliPayConfig.getMerchantPrivateKey(), aliPayConfig.getFormat(),
//                aliPayConfig.getCharset(), aliPayConfig.getAlipayPublicKey(), aliPayConfig.getSignType()); //获得初始化的AlipayClient
//        AlipayTradePrecreateRequest request = new AlipayTradePrecreateRequest();//创建API对应的request类
//        JSONObject jsonObject = new JSONObject();
//        /**
//         * 订单号
//         */
//        jsonObject.put("out_trade_no", order_no);
//        /**
//         * 支付金额
//         */
//        jsonObject.put("total_amount", total_fee);
//        jsonObject.put("body", "");
//        /**
//         * 订单主题
//         */
//        jsonObject.put("subject", "测试支付宝支付");
//        /**
//         * 订单支付有效时间
//         */
//        jsonObject.put("timeout_express", "90m");
//        request.setBizContent(jsonObject.toString());
//        request.setNotifyUrl(aliPayConfig.getNotifyUrl());
//        AlipayTradePrecreateResponse response = alipayClient.execute(request);
//        System.err.print(response.getBody());
//        //根据response中的结果继续业务逻辑处理
//        if (response.getMsg().equals("Success")) {
//            String qrcode = response.getQrCode();
//            return qrcode;
//        }
        return "请求失败";

    }
}
