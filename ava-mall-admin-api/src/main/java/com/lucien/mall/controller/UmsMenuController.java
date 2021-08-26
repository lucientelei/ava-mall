package com.lucien.mall.controller;

import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.UmsMenu;
import com.lucien.malll.service.UmsMenuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/26
 */
@RestController
@RequestMapping("/menu")
@Api(tags = "UmsMenuController", description = "后台菜单管理")
public class UmsMenuController {

    @Autowired
    private UmsMenuService menuService;

    @PostMapping("/create")
    @ApiOperation(value = "创建菜单")
    public GlobalResult create(@RequestBody UmsMenu umsMenu){
        int result = menuService.create(umsMenu);
        if (result > 0){
            return GlobalResult.success(result);
        }else {
            return GlobalResult.error();
        }
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "更新菜单")
    public GlobalResult update(@PathVariable Long id,
                               @RequestBody UmsMenu umsMenu){
        int result = menuService.update(id, umsMenu);
        if (result > 0){
            return GlobalResult.success(result);
        }else {
            return GlobalResult.error();
        }
    }

    @GetMapping("/item/{id}")
    @ApiOperation(value = "通过ID获取菜单详情")
    public GlobalResult getItem(@PathVariable Long id){
        UmsMenu result = menuService.getItem(id);
        if (StringUtils.isEmpty(result)){
            return GlobalResult.error("为查询到该菜单");
        }else {
            return GlobalResult.success(result);
        }
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation(value = "根据ID删除菜单")
    public GlobalResult delete(@PathVariable Long id){
        int result = menuService.delete(id);
        if (result > 0){
            return GlobalResult.success(result);
        }else {
            return GlobalResult.error();
        }
    }

    @GetMapping("/list/{parentId}")
    @ApiOperation(value = "分页获取菜单")
    public GlobalResult<GlobalPage<UmsMenu>> list(@PathVariable Long parentId,
                                         @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                         @RequestParam(value = "pageNum", defaultValue = "5")Integer pageNum){
        List<UmsMenu> result = menuService.list(parentId, pageSize, pageNum);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @PutMapping("/update/{id}")
    @ApiOperation(value = "修改菜单是否显示")
    public GlobalResult updateHidden(Long id, Integer hidden){
        int result = menuService.updateHidden(id, hidden);
        if (result > 0){
            return GlobalResult.success(result);
        }else {
            return GlobalResult.error();
        }
    }
}
