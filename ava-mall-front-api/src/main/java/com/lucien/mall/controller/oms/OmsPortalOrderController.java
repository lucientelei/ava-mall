package com.lucien.mall.controller.oms;

import com.lucien.mall.front.ConfirmOrderResult;
import com.lucien.mall.front.OmsOrderDetail;
import com.lucien.mall.front.OrderParam;
import com.lucien.mall.front.service.oms.OmsPortalOrderService;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @Author Lucien
 * @Date 2021/9/9
 */
@RestController
@RequestMapping("/portal/order")
@Api(tags = "OmsPortalOrderController", description = "前台会员订单管理")
public class OmsPortalOrderController {

    @Autowired
    private OmsPortalOrderService orderService;

    @PostMapping("/generate/confirm/order")
    @ApiOperation(value = "根据购物车信息生成确认单")
    public GlobalResult generateConfirmOrder(@RequestBody List<Long> cartIds){
        ConfirmOrderResult result = orderService.generateConfirmOrder(cartIds);
        return GlobalResult.success(result);
    }

    @PostMapping("generate/order")
    @ApiOperation(value = "根据购物车信息生成订单")
    public GlobalResult generateOrder(@RequestBody OrderParam param){
        Map<String, Object> result = orderService.generateOrder(param);
        return GlobalResult.success("下单成功", result);
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

    @PostMapping("/cancel/timeout/order")
    @ApiOperation(value = "自动取消超时订单")
    public GlobalResult cancelTimeOutOrder(){
        orderService.cancelTimeOutOrder();
        return GlobalResult.success();
    }

    @PostMapping("/取消单个超时订单")
    @ApiOperation(value = "cancel/order")
    public GlobalResult cancelOrder(Long orderId){
        orderService.cancelOrder(orderId);
        return GlobalResult.success("取消订单成功");
    }

    @GetMapping("/list")
    @ApiOperation("按状态分页获取用户订单列表")
    @ApiImplicitParam(name = "status", value = "订单状态：-1->全部；0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭",
            defaultValue = "-1", allowableValues = "-1,0,1,2,3,4", paramType = "query", dataType = "int")
    public GlobalResult list(@RequestParam Integer status,
                             @RequestParam(required = false, defaultValue = "1") Integer pageNum,
                             @RequestParam(required = false, defaultValue = "5") Integer pageSize) {
        GlobalPage<OmsOrderDetail> result = orderService.list(status, pageNum, pageSize);
        return GlobalResult.success(result);
    }

    @GetMapping("/detail/{orderId}")
    @ApiOperation(value = "获取单个订单详情")
    public GlobalResult detail(@PathVariable("orderId") Long orderId){
        OmsOrderDetail result = orderService.getItem(orderId);
        return GlobalResult.success(result);
    }

    @PostMapping("/cancel/user/order")
    @ApiOperation(value = "用户取消订单")
    public GlobalResult cancelUserOrder(Long orderId){
        orderService.cancelOrder(orderId);
        return GlobalResult.success();
    }

    @PostMapping("/confirm/receive/order")
    @ApiOperation(value = "用户确认收货")
    public GlobalResult confirmReceiveOrder(Long orderId){
        int result = orderService.confirmReceiveOrder(orderId);
        if (result == -1){
            return GlobalResult.error("不能确认他人订单", result);
        }else if (result == -2){
            return GlobalResult.error("订单未发货 无法确认收货", result);
        }
        return GlobalResult.success(result);
    }

    @PostMapping("/delete/order")
    @ApiOperation(value = "用户删除订单")
    public GlobalResult deleteOrder(@RequestParam("orderId") Long orderId){
        int result = orderService.deleteOrder(orderId);
        if (result == -1){
            return GlobalResult.success("不能确认他人订单", result);
        }else if (result == -2){
            return GlobalResult.success("只能删除已完成或已关闭的订单", result);
        }
        return GlobalResult.success(result);
    }
}
