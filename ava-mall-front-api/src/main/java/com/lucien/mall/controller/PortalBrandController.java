package com.lucien.mall.controller;

import com.lucien.mall.front.service.PortalBrandService;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.PmsBrand;
import com.lucien.mall.pojo.PmsProduct;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/7
 */
@RestController
@RequestMapping("/portal/brand")
@Api(tags = "PortalBrandController", description = "前台品牌")
public class PortalBrandController {

    @Autowired
    private PortalBrandService brandService;

    @GetMapping("/recommend/list")
    @ApiOperation(value = "分页获取推荐品牌")
    public GlobalResult<List<PmsBrand>> recommendList(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                      @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize){
        List<PmsBrand> result = brandService.recommendList(pageNum, pageSize);
        return GlobalResult.success(result);
    }

    @GetMapping("/product/list")
    @ApiOperation(value = "分页获取品牌关联商品")
    public GlobalResult<GlobalPage<PmsProduct>> productList(@RequestParam Long brandId,
                                    @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                    @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize){
        GlobalPage<PmsProduct> result = brandService.productList(brandId, pageNum, pageSize);
        return GlobalResult.success(result);
    }

    @GetMapping("/detail/{brandId}")
    @ApiOperation(value = "获取品牌详情")
    public GlobalResult getItem(@PathVariable("brandId") Long brandId){
        PmsBrand result = brandService.getItem(brandId);
        return GlobalResult.success(result);
    }

}
