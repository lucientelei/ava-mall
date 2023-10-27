package com.lucien.mall.controller;

import com.lucien.mall.front.service.oms.OmsPortalOrderService;
import com.lucien.mall.front.service.portal.AlipayService;
import com.lucien.mall.global.GlobalResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;

/**
 * @Author Lucien
 * @Date 2023/9/9
 */
@RestController
@RequestMapping("/alipay")
@Api(tags = "AlipayController", description = "支付宝沙箱支付接口")
public class AlipayController {

    @Autowired
    private AlipayService alipayService;

    @Autowired
    private OmsPortalOrderService orderService;

    @PostMapping("/pay")
    @ApiOperation(value = "支付")
    public GlobalResult pay(String subject, BigDecimal money, String tradeNo){
        String result = alipayService.toPay(subject, money, tradeNo);
        return GlobalResult.success(result);
    }

    @PostMapping("/pay/code")
    @ApiOperation(value = "获取二维码")
    public GlobalResult getCode(BigDecimal money, String tradeNo){
        String result = alipayService.getCode(money, tradeNo);
        return GlobalResult.success("生成二维码成功",result);
    }

    @GetMapping("test")
    public GlobalResult test(){
        String from = "<form name=\"punchout_form\" method=\"post\" action=\"https://openapi.alipaydev.com/gateway.do?charset=UTF8&sign=P4KrtxQ0Gxhgus%2Bl8mGzT3cUqSJ%2BbCYFDxUwRcXlMs6VqtfQuESeHeNqJmtgh%2FoxzLRFbkaoYcgf90qfOKOBHmLzPE%2Bn6EVkfWsbt4TuFL5NPkIForMTXwHslG9GVyPRJctyWX07cZrImw%2F8tfzb9oIm77zuV144Nwb3iLaqPtGg3iQIFH8wdLjcRH89lpXolD%2BYP%2BJO4o%2B9AelDsFLRKZC9ftzhpmZO5ZRS1FFjHuuZv9XK%2Fy0MpyHiXOxrfuCIWqC%2By5rRCp4r%2F%2FUJ5RGwpPEw94Fh924DwcsthW2W1QtddANUBYWRGgPtLg4y8dI98CNL1iymAAAf1Mb%2FwbYccQ%3D%3D&app_id=2016110100784972&sign_type=RSA2&timestamp=2023-12-22+21%3A42%3A05&alipay_sdk=alipay-sdk-java-dynamicVersionNo&format=json\"> <input type=\"hidden\" name=\"biz_content\" value=\"{&quot;out_trade_no&quot;:&quot;2&quot;,&quot;total_amount&quot;:&quot;0.1&quot;,&quot;quit_url&quot;:&quot;http://localhost::8710/paysuccess&quot;,&quot;subject&quot;:&quot;大乐透&quot;,&quot;product_code&quot;:&quot;QUICK_WAP_PAY&quot;,&quot;seller_id&quot;:&quot;2088102147948060&quot;}\"> <input type=\"submit\" value=\"立即支付\" style=\"display:none\" > </form> <script>document.forms[0].submit();</script>";
        return GlobalResult.success("", from);
    }
}
