package com.lucien.mall.controller.oms;

import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.OmsOrderSetting;
import com.lucien.malll.service.oms.OmsOrderSettingService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

/**
 * @Author Lucien
 * @Date 2021/9/2
 */
@RestController
@RequestMapping("/order/setting")
@Api(tags = "OmsOrderSettingController", description = "订单设置管理")
public class OmsOrderSettingController {

    @Autowired
    private OmsOrderSettingService settingService;

    @PostMapping("/update/{id}")
    @ApiOperation(value = "更新订单设置")
    public GlobalResult update(@PathVariable("id") Long id,
                               @RequestBody OmsOrderSetting orderSetting){
        int result = settingService.update(id, orderSetting);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @GetMapping("/getitem/{id}")
    @ApiOperation(value = "获取订单设置")
    public GlobalResult getItem(@PathVariable("id") Long id){
        OmsOrderSetting result = settingService.getItem(id);
        if (StringUtils.isEmpty(result)){
            return GlobalResult.error(result);
        }
        return GlobalResult.success(result);
    }
}
