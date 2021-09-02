package com.lucien.mall.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author Lucien
 * @Date 2021/8/30
 */
@RestController
@RequestMapping("/test")
//@RequiresRoles("超级管理员")
@Api(tags = "TestController", description = "测试接口")
public class TestController {

    @GetMapping("/test1")
    @ApiOperation(value = "测试")
    public String test(){
        return "test1";
    }

}
