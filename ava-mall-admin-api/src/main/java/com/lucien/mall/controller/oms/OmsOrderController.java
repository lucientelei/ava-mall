package com.lucien.mall.controller.oms;

import com.lucien.mall.rear.oms.*;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.OmsOrder;
import com.lucien.malll.service.oms.OmsOrderService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/2
 */
@RestController
@RequestMapping("/order")
@Api(tags = "OmsOrderController", description = "后台订单管理")
public class OmsOrderController {

    @Autowired
    private OmsOrderService orderService;

    @GetMapping("/listpage")
    @ApiOperation(value = "分页查询订单")
    public GlobalResult<GlobalPage<OmsOrder>> listPage(OmsOrderQueryParam param,
                                                       @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                       @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<OmsOrder> result = orderService.listPage(param, pageSize, pageNum);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @PostMapping("/close")
    @ApiOperation(value = "批量关闭订单")
    public GlobalResult close(@RequestParam("ids") List<Long> ids,
                              @RequestParam String note){
        int result = orderService.close(ids, note);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @PostMapping("/del")
    @ApiOperation(value = "批量删除订单")
    public GlobalResult del(@RequestParam("ids") List<Long> ids){
        int result = orderService.del(ids);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @PostMapping("/delivery")
    @ApiOperation(value = "批量发货")
    public GlobalResult delivery(@RequestBody List<OmsOrderDeliveryParam> params){
        int result = orderService.delivery(params);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @GetMapping("/getitem/{id}")
    @ApiOperation(value = "获取订单详情")
    public GlobalResult getItem(@PathVariable("id") Long id){
        OmsOrderDetail result = orderService.getItem(id);
        if (StringUtils.isEmpty(result)){
            return GlobalResult.error(result);
        }
        return GlobalResult.success(result);
    }

    @PostMapping("/update/money")
    @ApiOperation(value = "修改订单费用信息")
    public GlobalResult updateMoneyInfo(@RequestBody OmsMoneyInfoParam param){
        int result = orderService.updateMoneyInfo(param);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @PostMapping("/update/note")
    @ApiOperation(value = "修改订单备注信息")
    public GlobalResult updateNote(@RequestParam("id") Long id,
                                   @RequestParam("note") String note,
                                   @RequestParam("status") Integer status){
        int result = orderService.updateNote(id, note, status);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @PostMapping("/update/receiver")
    @ApiOperation(value = "修改收件人信息")
    public GlobalResult updateReceiverInfo(@RequestBody OmsReceiverInfoParam param){
        int result = orderService.updateReceiverInfo(param);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @PostMapping("/pay/success")
    @ApiOperation(value = "用户支付成功的回调")
    public GlobalResult paySuccess(@RequestParam Long orderId, @RequestParam Integer payType) {
        Integer result = orderService.paySuccess(orderId, payType);
        if (result > 0){
            return GlobalResult.success("支付成功", result);
        }
        return GlobalResult.error();
    }

}
