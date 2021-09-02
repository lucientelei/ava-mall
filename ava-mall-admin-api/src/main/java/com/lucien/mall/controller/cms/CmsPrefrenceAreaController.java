package com.lucien.mall.controller.cms;

import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.CmsPrefrenceArea;
import com.lucien.malll.service.cms.CmsPrefrenceAreaService;
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
@RequestMapping("/area")
@Api(value = "CmsPrefrenceAreaController", description = "后台商品优选管理")
public class CmsPrefrenceAreaController {

    @Autowired
    private CmsPrefrenceAreaService areaService;

    @GetMapping("/list")
    @ApiOperation(value = "查询所有优选")
    public GlobalResult list(){
        List<CmsPrefrenceArea> result = areaService.list();
        return GlobalResult.success(result);
    }
}
