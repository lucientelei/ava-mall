package com.lucien.mall.controller;

import com.lucien.mall.front.service.AlipayService;
import com.lucien.mall.global.GlobalResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;

/**
 * @Author Lucien
 * @Date 2021/9/9
 */
@RestController
@RequestMapping("/alipay")
@Api(tags = "AlipayController", description = "支付宝沙箱支付接口")
public class AlipayController {
    @Autowired
    private AlipayService alipayService;

    @PostMapping("/pay")
    @ApiOperation(value = "支付")
    public GlobalResult pay(String subject, BigDecimal money, String tradeNo){
        String result = alipayService.toPay(subject, money, tradeNo);
        return GlobalResult.success(result);
    }
}
