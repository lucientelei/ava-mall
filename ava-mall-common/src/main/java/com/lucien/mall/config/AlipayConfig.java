package com.lucien.mall.config;

import com.alipay.easysdk.kernel.Config;
import org.springframework.stereotype.Component;
import com.alipay.easysdk.factory.Factory;
/**
 * @Author Lucien
 * @Date 2021/9/9
 * 支付宝沙箱支付配置类
 */
@Component
public class AlipayConfig {

    /**
     * 买家账号nysquj7563@sandbox.com
     * 登录密码111111
     * 支付密码111111
     * 用户名称nysquj7563
     * 证件类型身份证(IDENTITY_CARD)
     * 证件号码666199193203065402
     */

    static {
        Factory.setOptions(getOptions());
    }

    private static Config getOptions(){
        Config config = new Config();

        config.protocol = "https";

        // 沙箱环境为 openapi.alipaydev.com
        config.gatewayHost = "openapi.alipaydev.com";

        config.signType = "RSA2";

        config.appId = "2016110100784972";

        config.merchantPrivateKey = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDJNbgnikZzE8rMTHZNf4aVdAcdEk1i3CWsZ8pn4gflRgsl5S7jTgYgiM8qBFx5GzvdcErWTsgkfxyRd0X+UK7j2+3kqnxvQTKddLLJ7XuQQ7zpwCTeAb/MbSSnCPTyGK//4FpRrYVZRv8pnOuFmZRpFR0uUXohFzWO70TtLBn39rqJVdB7tqvJz9/M/UWBhhasz6Diu4eR3b8JZeqqYOs5IDD9czeSjTS5a16lPFE5PDyZhKeoK7fgRgY/+syex3pC93Y53lk4J46Pz3buY2Bj65mLrJloq1Edm1gTlpnQKaEZeqzGdLhbQEj/Hm18f9qEvqFJawa3bzxTM1bZtBJnAgMBAAECggEATn30Twh0HyRTcotJg0YCXH8c30xqf+xdjfoXTZsxdVFzu97CAc5IOZzlJAD7igsDuYi6yQuGrCYiIOUkmucisqTzEscnL8eBVUdXD8ri7w5dvdpFB44rIjZZnAe0dlUHI4yD72T/pio6FCOxBTc6XBvufEkwmYQSUqYof1U69C3M1zhO7+Lt5lNuKFOWB97Xiz9S3fJJYsZYLeku1KX0OJwvm/sb3iwQgW/dMWwphXpX8NT/IrVVTbth+FPdsYfcFe55t/G+rNhNAj/Xe/6WMlj0p1JY+4Aw4W1mJW8iG3xHTMQJlIn9NEiA67TzSz/0Nb6W9e9Oxd0XvfSE5G51UQKBgQDkKMa50g9CCBRVE/RyiDOIYwesjlu1W38A0XHJlRw4NLCFSwajTqsio2KWf19K5h6g62DtryZnbPsoBf60hbS8h+mDj31NjbEelP4k91nBxPjIdnZstK4p5xOwph0b2GtruNVx+3om5hARzh/py40sWZY8D7Mbd0WySFafpgb+rQKBgQDhwxkrm8wA/C1JwkoRM7YYB76kEf6eZJgcFKczG9RIAnMSsSzgRfdup2x3yc68fX5IRxfkHJVTTbIWkHDy+YQJEqUsGP3JnLwSRRFZDlkLDjmKZ/3WNbB8z32BOoOcLoMKxT7j6WdLj+1BLruD8xVU7t6mgcV9ab0jos0lf7Qb4wKBgGAf2dHR8UG1m7NYa+WRAn0Uk9gcRgD7Yl+a3iC6pJ/9et09hbdp3moCgfe8BA7PMtpDMJwS7dAnNw1esTenGUVQ0Y3u9zCkYJns1cIHQBaGAPacCjq0SKg4xa/n3F2t6VwCDFMwSv92cBDAUeuzKXAk8kmtp50LvB5noa8zSMElAoGBAKteX/XVPkalJW9utrBWE2wsPM7oBeGPtFLkboKCJmI+0cCnksvu8EIjfldzbaVwkPImXQE/nS3ttTghjksxkcMdTxmpIsPuYGhx2xhBpt+YfZ8NDwaSHJSxH7B/jTV5rOj5DqMMIeeeqdantZkUZOXiqEm2CgYHxJWPV6+WP05HAoGBALCSrk+zKagXgmxrIcW441pW86PfUl3514Orh4uBjRtszixrHQPY0DRK5WuZkcrjkMf/T9lniBCxDLfbR1FxJKTxuJBCOn7UxWGG8Ta75rqsKN/HWhE2P1wbW/NCSClSrxcX9EIfntrtXyypBc297o1g2iQuqVH2cKKyn61TLcDB";

        config.alipayPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoUNOoz9ajpOfsGf7Ej5vmcElk7Q/18W9rjcZwKOAmkuXHEgsXRmPnMkigMR6HtJcpXEwM7YY2YS6uUUugNVURGiTARaVB/kS8WG0i0oPR52tNODb4Mk2IEMh/azJVjiJ+qHXDRHjAqNOAUuN/K5Wopn3vXmeSCrHT+Qg5HqJmEEMXWEZRiUUVs1rB5aJwMEzyph6CG7scDIV4uioq0sNJ02L3PGVTtPyKvtwmBOjhBqlb6cnofS+CSLD0SrN5I1tlVAYRBxYUD8TjHl5RvYdLxzTidOqOs+0JFs4YO1CbBWgf9fFb1m1xRNuNOaw2hp/u8fOvOX4Yg2kU8aq1cM4rwIDAQAB";

        //可设置异步通知接收服务地址（可选）（该地址需要外网能够访问）
//        config.notifyUrl = "https://www.baidu.com/";

        return config;
    }
}
