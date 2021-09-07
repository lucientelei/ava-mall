package com.lucien.mall.controller.oms;

import com.lucien.mall.front.OmsOrderReturnApplyParam;
import com.lucien.mall.front.service.oms.OmsPortalOrderReturnApplyService;
import com.lucien.mall.global.GlobalResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author Lucien
 * @Date 2021/9/7
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
}
