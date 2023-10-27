package com.lucien.mall.controller.pms;

import com.lucien.mall.front.PmsPortalProductDetail;
import com.lucien.mall.front.PmsProductCategoryNode;
import com.lucien.mall.front.service.pms.PmsPortalProductService;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.PmsProduct;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/7
 */
@RestController
@RequestMapping("/portal/product")
@Api(tags = "PmsPortalProductController", description = "前台商品")
public class PmsPortalProductController {

    @Autowired
    private PmsPortalProductService portalProductService;

    @GetMapping("/search")
    @ApiOperation(value = "综合搜索、筛选、排序商品")
    @ApiImplicitParam(name = "sort", value = "排序字段:0->按相关度；1->按新品；2->按销量；3->价格从低到高；4->价格从高到低",
            defaultValue = "0", allowableValues = "0,1,2,3,4", paramType = "query", dataType = "integer")
    public GlobalResult<GlobalPage<PmsProduct>> search(@RequestParam(required = false) String keyword,
                                                       @RequestParam(required = false) Long brandId,
                                                       @RequestParam(required = false) Long productCategoryId,
                                                       @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                                       @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                       @RequestParam(value = "sort", defaultValue = "0") Integer sort) {
        List<PmsProduct> result = portalProductService.search(keyword, brandId, productCategoryId, pageNum, pageSize, sort);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @GetMapping("/tree")
    @ApiOperation(value = "以树形结构获取所有商品分类")
    public GlobalResult<List<PmsProductCategoryNode>> categoryTreeList(){
        List<PmsProductCategoryNode> result = portalProductService.categoryTreeList();
        return GlobalResult.success(result);
    }

    @GetMapping("/detail/{id}")
    @ApiOperation(value = "获取商品详情")
    public GlobalResult<PmsPortalProductDetail> detail(@PathVariable("id") Long id){
        PmsPortalProductDetail result = portalProductService.detail(id);
        return GlobalResult.success(result);
    }
}
