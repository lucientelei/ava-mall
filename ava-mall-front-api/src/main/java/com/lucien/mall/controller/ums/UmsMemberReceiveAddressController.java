package com.lucien.mall.controller.ums;

import com.lucien.mall.front.service.ums.UmsMemberReceiveAddressService;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.UmsMemberReceiveAddress;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/31
 * 会员收货地址
 */
@RestController
@RequestMapping("/address")
@Api(tags = "UmsMemberReceiveAddressController", description = "会员收货地址")
public class UmsMemberReceiveAddressController {

    @Autowired
    private UmsMemberReceiveAddressService addressService;

    @GetMapping("/list")
    @ApiOperation(value = "获取会员收货地址")
    public GlobalResult list(){
        List<UmsMemberReceiveAddress> result = addressService.list();
        if (CollectionUtils.isEmpty(result)){
            return GlobalResult.success("您还没有添加过收货地址", result);
        }else {
            return GlobalResult.success(result);
        }
    }


    @PostMapping("/insert")
    @ApiOperation(value = "添加收货地址")
    public GlobalResult insert(@RequestBody UmsMemberReceiveAddress address){
        Integer result = addressService.insert(address);
        if (result != 1){
            return GlobalResult.error(result);
        }else {
            return GlobalResult.success(result);
        }
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation(value = "删除收货地址")
    public GlobalResult del(@PathVariable("id") Long id){
        int result = addressService.del(id);
        if (result != 1){
            return GlobalResult.error(result);
        }else {
            return GlobalResult.success(result);
        }
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "更新收货地址")
    public GlobalResult update(@PathVariable("id") Long id, @RequestBody UmsMemberReceiveAddress address){
        int result = addressService.update(id, address);
        if (result != 1){
            return GlobalResult.error(result);
        }else {
            return GlobalResult.success(result);
        }
    }

    @GetMapping("/getitem/{id}")
    @ApiOperation(value = "获取地址详情")
    public GlobalResult getItem(@PathVariable("id") Long id){
        UmsMemberReceiveAddress result = addressService.getItem(id);
        if(StringUtils.isEmpty(result)){
            return GlobalResult.error(result);
        }else {
            return GlobalResult.success(result);
        }
    }
}
