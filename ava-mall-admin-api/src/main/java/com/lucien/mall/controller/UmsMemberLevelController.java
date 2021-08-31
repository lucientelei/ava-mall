package com.lucien.mall.controller;

import com.lucien.mall.global.GlobalResult;
import com.lucien.malll.service.UmsMemberLevelService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author Lucien
 * @Date 2021/8/31
 */
@RestController
@RequestMapping("/memberLevel")
@Api(tags = "UmsMemberLevelController", description = "用户等级管理")
public class UmsMemberLevelController {

    @Autowired
    private UmsMemberLevelService levelService;

    @GetMapping("/list")
    @ApiOperation(value = "查询所有等级信息")
    public GlobalResult list(@RequestParam("defaultStatus") Integer defaultStatus){
        return GlobalResult.success(levelService.list(defaultStatus));
    }



}
