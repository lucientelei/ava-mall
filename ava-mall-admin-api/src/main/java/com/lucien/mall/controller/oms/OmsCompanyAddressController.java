package com.lucien.mall.controller.oms;

import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.OmsCompanyAddress;
import com.lucien.malll.service.oms.OmsCompanyAddressService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/2
 */
@RestController
@RequestMapping("/company/address")
@Api(tags = "OmsCompanyAddressController", description = "后台收货地址管理")
public class OmsCompanyAddressController {

    @Autowired
    private OmsCompanyAddressService addressService;

    @GetMapping("/list")
    @ApiOperation(value = "获取全部收货地址")
    public GlobalResult list(){
        List<OmsCompanyAddress> result = addressService.list();
        return GlobalResult.success(result);
    }
}
