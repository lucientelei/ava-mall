package com.lucien.mall.front.service.portal.impl;

import com.alibaba.fastjson.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.AlipayConfig;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.domain.AlipayTradeWapPayModel;
import com.alipay.api.request.AlipayTradePrecreateRequest;
import com.alipay.api.request.AlipayTradeWapPayRequest;
import com.alipay.api.response.AlipayTradePrecreateResponse;
import com.alipay.api.response.AlipayTradeWapPayResponse;
import com.lucien.mall.front.service.portal.AlipayService;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

/**
 * @Author Lucien
 * @Date 2023/9/9
 * 支付宝沙箱支付Impl
 */
@Service
@Primary
public class AlipayServiceImpl implements AlipayService {

    private static final String returnURL = "http://localhost::8710/paysuccess";

    private static final String privateKey = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDJNbgnikZzE8rMTHZNf4aVdAcdEk1i3CWsZ8pn4gflRgsl5S7jTgYgiM8qBFx5GzvdcErWTsgkfxyRd0X+UK7j2+3kqnxvQTKddLLJ7XuQQ7zpwCTeAb/MbSSnCPTyGK//4FpRrYVZRv8pnOuFmZRpFR0uUXohFzWO70TtLBn39rqJVdB7tqvJz9/M/UWBhhasz6Diu4eR3b8JZeqqYOs5IDD9czeSjTS5a16lPFE5PDyZhKeoK7fgRgY/+syex3pC93Y53lk4J46Pz3buY2Bj65mLrJloq1Edm1gTlpnQKaEZeqzGdLhbQEj/Hm18f9qEvqFJawa3bzxTM1bZtBJnAgMBAAECggEATn30Twh0HyRTcotJg0YCXH8c30xqf+xdjfoXTZsxdVFzu97CAc5IOZzlJAD7igsDuYi6yQuGrCYiIOUkmucisqTzEscnL8eBVUdXD8ri7w5dvdpFB44rIjZZnAe0dlUHI4yD72T/pio6FCOxBTc6XBvufEkwmYQSUqYof1U69C3M1zhO7+Lt5lNuKFOWB97Xiz9S3fJJYsZYLeku1KX0OJwvm/sb3iwQgW/dMWwphXpX8NT/IrVVTbth+FPdsYfcFe55t/G+rNhNAj/Xe/6WMlj0p1JY+4Aw4W1mJW8iG3xHTMQJlIn9NEiA67TzSz/0Nb6W9e9Oxd0XvfSE5G51UQKBgQDkKMa50g9CCBRVE/RyiDOIYwesjlu1W38A0XHJlRw4NLCFSwajTqsio2KWf19K5h6g62DtryZnbPsoBf60hbS8h+mDj31NjbEelP4k91nBxPjIdnZstK4p5xOwph0b2GtruNVx+3om5hARzh/py40sWZY8D7Mbd0WySFafpgb+rQKBgQDhwxkrm8wA/C1JwkoRM7YYB76kEf6eZJgcFKczG9RIAnMSsSzgRfdup2x3yc68fX5IRxfkHJVTTbIWkHDy+YQJEqUsGP3JnLwSRRFZDlkLDjmKZ/3WNbB8z32BOoOcLoMKxT7j6WdLj+1BLruD8xVU7t6mgcV9ab0jos0lf7Qb4wKBgGAf2dHR8UG1m7NYa+WRAn0Uk9gcRgD7Yl+a3iC6pJ/9et09hbdp3moCgfe8BA7PMtpDMJwS7dAnNw1esTenGUVQ0Y3u9zCkYJns1cIHQBaGAPacCjq0SKg4xa/n3F2t6VwCDFMwSv92cBDAUeuzKXAk8kmtp50LvB5noa8zSMElAoGBAKteX/XVPkalJW9utrBWE2wsPM7oBeGPtFLkboKCJmI+0cCnksvu8EIjfldzbaVwkPImXQE/nS3ttTghjksxkcMdTxmpIsPuYGhx2xhBpt+YfZ8NDwaSHJSxH7B/jTV5rOj5DqMMIeeeqdantZkUZOXiqEm2CgYHxJWPV6+WP05HAoGBALCSrk+zKagXgmxrIcW441pW86PfUl3514Orh4uBjRtszixrHQPY0DRK5WuZkcrjkMf/T9lniBCxDLfbR1FxJKTxuJBCOn7UxWGG8Ta75rqsKN/HWhE2P1wbW/NCSClSrxcX9EIfntrtXyypBc297o1g2iQuqVH2cKKyn61TLcDB";

    private static final String alipayPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoUNOoz9ajpOfsGf7Ej5vmcElk7Q/18W9rjcZwKOAmkuXHEgsXRmPnMkigMR6HtJcpXEwM7YY2YS6uUUugNVURGiTARaVB/kS8WG0i0oPR52tNODb4Mk2IEMh/azJVjiJ+qHXDRHjAqNOAUuN/K5Wopn3vXmeSCrHT+Qg5HqJmEEMXWEZRiUUVs1rB5aJwMEzyph6CG7scDIV4uioq0sNJ02L3PGVTtPyKvtwmBOjhBqlb6cnofS+CSLD0SrN5I1tlVAYRBxYUD8TjHl5RvYdLxzTidOqOs+0JFs4YO1CbBWgf9fFb1m1xRNuNOaw2hp/u8fOvOX4Yg2kU8aq1cM4rwIDAQAB";

    private static final String appId = "2016110100784972";

    private static final AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipaydev.com/gateway.do",
            appId,
            privateKey,
            "json", "UTF-8",
            alipayPublicKey,
            "RSA2");


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
        AlipayConfig alipayConfig = new AlipayConfig();
        alipayConfig.setServerUrl("https://openapi.alipaydev.com/gateway.do");
        alipayConfig.setAppId("2016110100784972");
        alipayConfig.setPrivateKey(privateKey);
        alipayConfig.setFormat("json");
        alipayConfig.setAlipayPublicKey(alipayPublicKey);
        alipayConfig.setCharset("UTF8");
        alipayConfig.setSignType("RSA2");
        AlipayClient alipayClient = null;
        try {
            alipayClient = new DefaultAlipayClient(alipayConfig);
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        AlipayTradeWapPayRequest request = new AlipayTradeWapPayRequest();
        AlipayTradeWapPayModel model = new AlipayTradeWapPayModel();
        model.setOutTradeNo(tradeNo);
        model.setTotalAmount(String.valueOf(money));
        model.setSubject(subject);
        model.setProductCode("QUICK_WAP_PAY");
        model.setQuitUrl(returnURL);

        request.setBizModel(model);
        AlipayTradeWapPayResponse response = null;
        try {
            response = alipayClient.pageExecute(request);
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        payForm = response.getBody();
        System.out.println(response.getBody());
        if (response.isSuccess()) {
            System.out.println("调用成功");
        } else {
            System.out.println("调用失败");
        }
        return payForm;
    }

    @Override
    public String getCode(BigDecimal money, String tradeNo) {
        String qrCode = "";
        AlipayTradePrecreateRequest request = new AlipayTradePrecreateRequest();
        request.setNotifyUrl(returnURL);
        request.setReturnUrl(returnURL);
        JSONObject bizContent = new JSONObject();
        bizContent.put("out_trade_no", tradeNo);
        bizContent.put("total_amount", money);
        bizContent.put("subject", "AVAMall商城收款方");
        request.setBizContent(bizContent.toString());
        AlipayTradePrecreateResponse response = null;
        try {
            response = alipayClient.execute(request);
            qrCode = response.getQrCode();
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        if(response.isSuccess()){
            System.out.println("调用成功");
        } else {
            System.out.println("调用失败");
        }
        return qrCode;
    }


}
