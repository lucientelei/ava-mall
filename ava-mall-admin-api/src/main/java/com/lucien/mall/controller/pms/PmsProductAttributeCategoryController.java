package com.lucien.mall.controller.pms;

import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.PmsProductAttributeCategory;
import com.lucien.malll.service.pms.PmsProductAttributeCategoryService;
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
@RequestMapping("/product/attr/category")
@Api(tags = "PmsProductAttributeCategoryController", description = "后台商品属性分类管理")
public class PmsProductAttributeCategoryController {

    @Autowired
    private PmsProductAttributeCategoryService categoryService;

    @PostMapping("/insert")
    @ApiOperation(value = "新增属性分类")
    public GlobalResult insert(@RequestParam("name") String name){
        int result = categoryService.insert(name);
        if (result != 1){
            return GlobalResult.error();
        }
        return GlobalResult.success(result);
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "更新属性分类")
    public GlobalResult update(@PathVariable("id") Long id,
                               @RequestParam("name") String name){
        int result = categoryService.update(id, name);
        if (result != 1){
            return GlobalResult.error();
        }
        return GlobalResult.success(result);
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation(value = "删除属性分类")
    public GlobalResult del(@PathVariable("id") Long id){
        int result = categoryService.del(id);
        if (result != 1){
            return GlobalResult.error();
        }
        return GlobalResult.success(result);
    }

    @GetMapping("/getitem/{id}")
    @ApiOperation(value = "获取属性分类信息")
    public GlobalResult getItem(@PathVariable("id") Long id){
        PmsProductAttributeCategory result = categoryService.getItem(id);
        if (StringUtils.isEmpty(result)){
            return GlobalResult.error();
        }
        return GlobalResult.success(result);
    }

    @GetMapping("/list")
    @ApiOperation(value = "分页获取属性分类信息")
    public GlobalResult<GlobalPage<PmsProductAttributeCategory>> list(@RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                             @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<PmsProductAttributeCategory> result = categoryService.list(pageSize, pageNum);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

}
