package com.lucien.mall.controller.oms;

import com.lucien.mall.front.OmsOrderReturnApplyParam;
import com.lucien.mall.front.service.oms.OmsPortalOrderReturnApplyService;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.OmsOrderReturnReason;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/7
 */
@RestController
@RequestMapping("/oms/return/apply")
@Api(tags = "OmsPortalOrderReturnApplyController", description = "前台退货申请")
public class OmsPortalOrderReturnApplyController {

    @Autowired
    private OmsPortalOrderReturnApplyService returnApplyService;

    @PostMapping("/insert")
    @ApiOperation(value = "提交退货申请")
    public GlobalResult insert(@RequestBody OmsOrderReturnApplyParam param){
        int result = returnApplyService.insert(param);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @GetMapping("/list/reason")
    @ApiOperation(value = "获取全部退货原因")
    public GlobalResult listReason(){
        List<OmsOrderReturnReason> result = returnApplyService.listReason();
        return GlobalResult.success(result);
    }

    @GetMapping("/apply/status/{orderId}")
    @ApiOperation(value = "获取退货订单状态")
    public GlobalResult applyStatus(@PathVariable("orderId") Long orderId){
        int result = returnApplyService.applyStatus(orderId);
        return GlobalResult.success(result);
    }
}
