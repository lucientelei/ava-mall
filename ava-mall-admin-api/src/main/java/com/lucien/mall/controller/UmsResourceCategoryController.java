package com.lucien.mall.controller;

import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.UmsResourceCategory;
import com.lucien.malll.service.UmsResourceCategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @Author Lucien
 * @Date 2021/8/30
 * 后台资源分类管理Controller
 */
@RestController
@RequestMapping("/resource/category")
@Api(tags = "UmsResourceCategoryController", description = "后台资源分类管理")
public class UmsResourceCategoryController {

    @Autowired
    private UmsResourceCategoryService categoryService;

    @PostMapping("/insert")
    @ApiOperation(value = "新增资源分类")
    public GlobalResult insert(@RequestBody UmsResourceCategory category){
        int result = categoryService.insert(category);
        if (result != 1){
            return GlobalResult.error("新增资源分类失败", result);
        }else {
            return GlobalResult.success("新增资源分类成功", result);
        }
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation(value = "删除资源分类")
    public GlobalResult del(@PathVariable("id") Long id){
        int result = categoryService.del(id);
        if (result != 1){
            return GlobalResult.error("删除资源分类失败", result);
        }else {
            return GlobalResult.success("删除资源分类成功", result);
        }
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "更新资源分类")
    public GlobalResult update(@PathVariable("id") Long id,
                               @RequestBody UmsResourceCategory category){
        int result = categoryService.update(id, category);
        if (result != 1){
            return GlobalResult.error("更新资源分类失败", result);
        }else {
            return GlobalResult.success("更新资源分类成功", result);
        }
    }

    @GetMapping("/list")
    @ApiOperation(value = "获取所有资源分类")
    public GlobalResult list(){
        return GlobalResult.success(categoryService.listAll());
    }

}
