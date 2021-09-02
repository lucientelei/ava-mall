package com.lucien.mall.controller.ums;

import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.UmsResource;
import com.lucien.malll.service.ums.UmsResourceService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/30
 * 后台资源管理控制器
 */
@RestController
@RequestMapping("/resource")
@Api(tags = "UmsResourceController", description = "后台资源管理")
public class UmsResourceController {

    @Autowired
    private UmsResourceService resourceService;

    @GetMapping("/listall")
    @ApiOperation(value = "获取所有资源")
    public GlobalResult listAll(){
        List<UmsResource> result = resourceService.listAll();
        return GlobalResult.success(result);
    }

    @GetMapping("/list")
    @ApiOperation(value = "分页模糊查询")
    public GlobalResult<GlobalPage<UmsResource>> list(@RequestParam(required = false) Long categoryId,
                                                            @RequestParam(required = false) String nameKeyword,
                                                            @RequestParam(required = false) String urlKeyword,
                                         @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                         @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<UmsResource> result = resourceService.list(categoryId, nameKeyword, urlKeyword, pageSize, pageNum);
        return  GlobalResult.success(GlobalPage.restPage(result));
    }

    @PostMapping("/insert")
    @ApiOperation(value = "新增资源")
    public GlobalResult insert(@RequestBody UmsResource umsResource){
        int result = resourceService.insert(umsResource);
        if (result != 1){
            return GlobalResult.error("新增资源失败");
        }else {
            return GlobalResult.success("新增资源成功", result);
        }
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "更新资源")
    public GlobalResult update(@PathVariable("id") Long id,
                            @RequestBody UmsResource UmsResource){
        Integer result = resourceService.update(id, UmsResource);
        if (result != 1){
            return GlobalResult.error("修改资源失败");
        }else {
            return GlobalResult.success("修改资源成功", result);
        }
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation(value = "删除资源")
    public GlobalResult del(@PathVariable("id") Long id){
        Integer result = resourceService.del(id);
        if (result != 1){
            return GlobalResult.error("删除资源失败");
        }else {
            return GlobalResult.success("删除资源成功", result);
        }
    }

    @GetMapping("/getitem/{id}")
    @ApiOperation(value = "获取资源")
    public GlobalResult getItem(@PathVariable("id") Long id){
        UmsResource result = resourceService.getItem(id);
        if (StringUtils.isEmpty(result)){
            return GlobalResult.error("获取资源失败", result);
        }else {
            return GlobalResult.success("获取资源成功", result);
        }
    }

}
