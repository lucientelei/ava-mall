package com.lucien.mall.controller.pms;

import com.lucien.mall.rear.pms.PmsProductCategoryParam;
import com.lucien.mall.rear.pms.PmsProductCategoryWithChildrenItem;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.PmsProductCategory;
import com.lucien.malll.service.pms.PmsProductCategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 */
@RestController
@RequestMapping("/product/category")
@Api(value = "PmsProductCategoryController", description = "后台商品分类管理")
public class PmsProductCategoryController {

    @Autowired
    private PmsProductCategoryService categoryService;

    @PostMapping("/insert")
    @ApiOperation(value = "新增商品分类")
    public GlobalResult insert(@RequestBody PmsProductCategoryParam param){
        int result = categoryService.insert(param);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @GetMapping("/list/{parentId}")
    @ApiOperation(value = "分页获取商品分类")
    public GlobalResult<GlobalPage<PmsProductCategory>> listPage(@PathVariable("parentId") Long parentId,
                                                                 @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                                 @RequestParam(value = "pageNum", defaultValue = "1")Integer pageNum){
        List<PmsProductCategory> result = categoryService.listPage(parentId, pageSize, pageNum);
        if (CollectionUtils.isEmpty(result)){
            return GlobalResult.error("未查询到数据");
        }
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "更新商品分类")
    public GlobalResult update(@PathVariable("id") Long id,
                               @RequestBody PmsProductCategoryParam param){
        int result = categoryService.update(id, param);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation(value = "删除商品分类")
    public GlobalResult delete(@PathVariable("id") Long id){
        int result = categoryService.delete(id);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @GetMapping("/getitem/{id}")
    @ApiOperation(value = "获取商品分类")
    public GlobalResult getItem(@PathVariable("id") Long id){
        PmsProductCategory result = categoryService.getItem(id);
        if (StringUtils.isEmpty(result)){
            return GlobalResult.error(result);
        }
        return GlobalResult.success(result);
    }

    @PostMapping("/update/nav")
    @ApiOperation(value = "批量修改导航状态")
    public GlobalResult updateNavStatus(@RequestParam("ids") List<Long> ids,
                                        @RequestParam("status") Integer status){
        for (Long id : ids) {
            System.out.println(id + "---" + status);
        }
        int result = categoryService.updateNavStatus(ids, status);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @PostMapping("/update/show")
    @ApiOperation(value = "批量修改显示状态")
    public GlobalResult updateShowStatus(@RequestParam("ids") List<Long> ids,
                                        @RequestParam("status") Integer status){
        int result = categoryService.updateShowStatus(ids, status);
        if (result > 0) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @GetMapping("/list/children")
    @ApiOperation(value = "以层级形式获取商品分类")
    public GlobalResult listWithChildren(){
        List<PmsProductCategoryWithChildrenItem> result = categoryService.listWithChildren();
        return GlobalResult.success(result);
    }
}
