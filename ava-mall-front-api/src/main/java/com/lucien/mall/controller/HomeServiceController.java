package com.lucien.mall.controller;

import com.lucien.mall.front.HomeContentResult;
import com.lucien.mall.front.service.portal.HomeService;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.PmsProduct;
import com.lucien.mall.pojo.PmsProductCategory;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/6
 */
@RestController
@RequestMapping("/home")
@Api(tags = "HomeServiceController", description = "首页内容管理")
public class HomeServiceController {

    @Autowired
    private HomeService homeService;

    @GetMapping("/content")
    @ApiOperation(value = "获取首页内容")
    public GlobalResult content(){
        HomeContentResult result = homeService.content();
        return GlobalResult.success(result);
    }

    @GetMapping("/recommend/product/list")
    @ApiOperation(value = "首页商品推荐")
    public GlobalResult<GlobalPage<PmsProduct>> recommendProductList(@RequestParam(value = "pageSize", defaultValue = "20") Integer pageSize,
                                                         @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<PmsProduct> result = homeService.recommendProductList(pageSize, pageNum);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @GetMapping("/product/cate/list/{parentId}")
    @ApiOperation(value = "获取商品分类",notes = "0:获取一级分类；其他：获取指定二级分类")
    public GlobalResult getProductCateList(@PathVariable("parentId") Long parentId){
        List<PmsProductCategory> result = homeService.getProductCateList(parentId);
        return GlobalResult.success(result);
    }
    

    @GetMapping("/hot/product/list")
    @ApiOperation(value = "分页获取人气推荐商品")
    public GlobalResult<GlobalPage<PmsProduct>> hotProductList(@RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                       @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<PmsProduct> result = homeService.hotProductList(pageNum, pageSize);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @GetMapping("/new/product/list")
    @ApiOperation(value = "分页获取新品推荐商品")
    public GlobalResult<GlobalPage<PmsProduct>> newProductList(@RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                       @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<PmsProduct> result = homeService.newProductList(pageNum, pageSize);
        return GlobalResult.success(GlobalPage.restPage(result));
    }
}
