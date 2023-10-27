package com.lucien.mall.controller.ums;

import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.UmsAdminLoginLog;
import com.lucien.malll.service.ums.UmsAdminLoginLogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/13
 */
@RestController
@RequestMapping("/admin/login/log")
@Api(tags = "UmsAdminLoginLogController", description = "后台用户登录日志")
public class UmsAdminLoginLogController {

    @Autowired
    private UmsAdminLoginLogService loginLogService;

    @GetMapping("/list")
    @ApiOperation(value = "分页获取后台用户登录记录")
    public GlobalResult<GlobalPage<UmsAdminLoginLog>> list(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                                           @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize){
        List<UmsAdminLoginLog> result = loginLogService.list(pageNum, pageSize);
        return GlobalResult.success(GlobalPage.restPage(result));
    }


}
