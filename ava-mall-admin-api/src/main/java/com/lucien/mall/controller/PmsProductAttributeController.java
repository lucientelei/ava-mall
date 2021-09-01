package com.lucien.mall.controller;

import com.lucien.mall.dto.PmsProductAttributeParam;
import com.lucien.mall.dto.ProductAttrInfo;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.PmsProductAttribute;
import com.lucien.malll.service.PmsProductAttributeService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 */
@RestController
@RequestMapping("/product/attribute")
@Api(tags = "PmsProductAttributeController", description = "后台商品属性管理")
public class PmsProductAttributeController {

    @Autowired
    private PmsProductAttributeService attributeService;

    @PostMapping("/insert")
    @ApiOperation(value = "新增商品属性")
    public GlobalResult insert(@RequestBody PmsProductAttributeParam param){
        int result = attributeService.insert(param);
        if (result != 1) {
            return GlobalResult.error(result);
        }
        return GlobalResult.success(result);
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "修改商品属性")
    public GlobalResult update(@PathVariable("id") Long id,
                               @RequestBody PmsProductAttributeParam param){
        int result = attributeService.update(id, param);
        if (result != 1) {
            return GlobalResult.error(result);
        }
        return GlobalResult.success(result);
    }

    @GetMapping("/getitem/{id}")
    @ApiOperation(value = "获取商品属性信息")
    public GlobalResult getItem(@PathVariable("id") Long id){
        PmsProductAttribute result = attributeService.getItem(id);
        if (StringUtils.isEmpty(result)) {
            return GlobalResult.error(result);
        }
        return GlobalResult.success(result);
    }

    @GetMapping("/getlist/{cid}/{type}")
    @ApiOperation(value = "根据分类分页获取商品属性")
    public GlobalResult<GlobalPage<PmsProductAttribute>> getList(@PathVariable("cid") Long cid,
                                            @PathVariable("type") Integer type,
                                            @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                            @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<PmsProductAttribute> result = attributeService.getList(cid, type, pageSize, pageNum);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @DeleteMapping("/del")
    @ApiOperation(value = "批量删除商品属性")
    public GlobalResult delete(@RequestParam("ids") List<Long> ids){
        int result = attributeService.delete(ids);
        if (result != 1) {
            return GlobalResult.error(result);
        }
        return GlobalResult.success(result);
    }

    @GetMapping("/info/{productCategoryId}")
    @ApiOperation(value = "获取商品分类对应属性列表")
    public GlobalResult getProductAttrInfo(@PathVariable("productCategoryId") Long productCategoryId){
        List<ProductAttrInfo> result = attributeService.getProductAttrInfo(productCategoryId);
        if (StringUtils.isEmpty(result)) {
            return GlobalResult.error(result);
        }
        return GlobalResult.success(result);
    }
}
