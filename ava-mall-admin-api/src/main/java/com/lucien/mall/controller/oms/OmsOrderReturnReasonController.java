package com.lucien.mall.controller.oms;

import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.OmsOrderReturnReason;
import com.lucien.malll.service.oms.OmsOrderReturnReasonService;
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
@RequestMapping("/order/return/reason")
@Api(value = "OmsOrderReturnReasonController", description = "后台退货原因管理")
public class OmsOrderReturnReasonController {

    @Autowired
    private OmsOrderReturnReasonService reasonService;

    @PostMapping("/insert")
    @ApiOperation(value = "新增退货原因")
    public GlobalResult insert(@RequestBody OmsOrderReturnReason returnReason) {
        int result = reasonService.insert(returnReason);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @DeleteMapping("/del")
    @ApiOperation(value = "批量删除退货原因")
    public GlobalResult del(@RequestParam("ids") List<Long> ids) {
        int result = reasonService.del(ids);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "修改退货原因")
    public GlobalResult update(@PathVariable("id") Long id,
                               @RequestBody OmsOrderReturnReason returnReason) {
        int result = reasonService.update(id, returnReason);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @GetMapping("/listpage")
    @ApiOperation(value = "分页获取退货原因")
    public GlobalResult<GlobalPage<OmsOrderReturnReason>> listPage(@RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                                   @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<OmsOrderReturnReason> result = reasonService.listPage(pageSize, pageNum);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @GetMapping("/getitem/{id}")
    @ApiOperation(value = "获取单个退货原因")
    public GlobalResult getItem(@PathVariable("id") Long id){
        OmsOrderReturnReason result = reasonService.getItem(id);
        if (StringUtils.isEmpty(result)) {
            return GlobalResult.error(result);
        }
        return GlobalResult.success(result);
    }

    @PostMapping("/update/status")
    @ApiOperation(value = "批量修改原因状态")
    public GlobalResult update(@RequestParam("ids") List<Long> ids,
                               @RequestParam Integer status){
        int result = reasonService.update(ids, status);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }
}
