package com.lucien.mall.controller.oms;

import com.lucien.mall.rear.oms.OmsOrderReturnApplyResult;
import com.lucien.mall.rear.oms.OmsReturnApplyQueryParam;
import com.lucien.mall.rear.oms.OmsUpdateStatusParam;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.OmsOrderReturnApply;
import com.lucien.malll.service.oms.OmsOrderReturnApplyService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/2
 */
@RestController
@RequestMapping("/order/return/apply")
@Api(tags = "OmsOrderReturnApplyController", description = "后台退货申请管理")
public class OmsOrderReturnApplyController {

    @Autowired
    private OmsOrderReturnApplyService applyService;

    @GetMapping("/getitem/{id}")
    @ApiOperation(value = "获取指定申请信息")
    public GlobalResult getItem(@PathVariable("id") Long id){
        OmsOrderReturnApplyResult result = applyService.getItem(id);
        if (StringUtils.isEmpty(result)){
            return GlobalResult.error(result);
        }
        return GlobalResult.success(result);
    }

    @PostMapping("/update/status/{id}")
    @ApiOperation(value = "更新申请信息状态")
    public GlobalResult updateStatus(@PathVariable("id") Long id,
                                     @RequestBody OmsUpdateStatusParam statusParam){
        int result = applyService.updateStatus(id, statusParam);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @GetMapping("/listpage")
    @ApiOperation(value = "分页获取申请信息")
    public GlobalResult<GlobalPage<OmsOrderReturnApply>> listPage(OmsReturnApplyQueryParam queryParam,
                                             @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                             @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<OmsOrderReturnApply> result = applyService.listPage(queryParam, pageSize, pageNum);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @DeleteMapping("/del")
    @ApiOperation(value = "批量删除申请")
    public GlobalResult del(@RequestParam("ids") List<Long> ids){
        int result = applyService.del(ids);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

}
