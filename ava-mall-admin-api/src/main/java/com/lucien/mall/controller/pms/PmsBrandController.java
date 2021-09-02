package com.lucien.mall.controller.pms;

import com.lucien.mall.dto.pms.PmsBrandDto;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.PmsBrand;
import com.lucien.malll.service.pms.PmsBrandService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/31
 */
@RestController
@RequestMapping("/brands")
@Api(tags = "PmsBrandController", description = "商品品牌管理")
public class PmsBrandController {

    @Autowired
    private PmsBrandService brandService;

    @PostMapping("/insert")
    @ApiOperation(value = "添加品牌")
    public GlobalResult insert(@RequestBody PmsBrandDto dto){
        int result = brandService.insert(dto);
        if (result != 1){
            return GlobalResult.error(result);
        }else {
            return GlobalResult.success(result);
        }
    }

    @GetMapping("/list")
    @ApiOperation(value = "查看所有品牌")
    public GlobalResult list(){
        List<PmsBrand> result = brandService.list();
        if (CollectionUtils.isEmpty(result)){
            return GlobalResult.error(result);
        }else {
            return GlobalResult.success(result);
        }
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "更新品牌信息")
    public GlobalResult update(@PathVariable("id") Long id,
                               @RequestBody PmsBrand pmsBrand){
        int result = brandService.update(id, pmsBrand);
        if (result != 1){
            return GlobalResult.error(result);
        }else {
            return GlobalResult.success(result);
        }
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation(value = "删除品牌信息")
    public GlobalResult del(@PathVariable("id") Long id){
        int result = brandService.del(id);
        if (result != 1){
            return GlobalResult.error(result);
        }else {
            return GlobalResult.success(result);
        }
    }

    @GetMapping("/listbrand")
    @ApiOperation(value = "分页获取品牌信息")
    public GlobalResult<GlobalPage<PmsBrand>> listBrand(@RequestParam(required = false) String keyword,
                                              @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                                              @RequestParam(value = "pageSize", defaultValue = "5")int pageSize){
        List<PmsBrand> result = brandService.listBrand(keyword, pageNum, pageSize);
        if (CollectionUtils.isEmpty(result)){
            return GlobalResult.error(result);
        }else {
            return GlobalResult.success(GlobalPage.restPage(result));
        }
    }

    @GetMapping("/getitem/{id}")
    @ApiOperation(value = "获取品牌详情")
    public GlobalResult getItem(@PathVariable("id") Long id){
        PmsBrand result = brandService.getItem(id);
        if (StringUtils.isEmpty(result)){
            return GlobalResult.error();
        }else {
            return GlobalResult.success(result);
        }
    }

    @DeleteMapping("/del/brand")
    @ApiOperation(value = "批量删除品牌")
    public GlobalResult deleteBrand(@RequestParam("ids") List<Long> ids){
        int result = brandService.deleteBrand(ids);
        if (result != 1){
            return GlobalResult.error(result);
        }else {
            return GlobalResult.success(result);
        }
    }

    @PostMapping("/update/show")
    @ApiOperation(value = "修改显示状态")
    public GlobalResult updateShowStatus(@RequestParam("ids") List<Long> ids,
                                         @RequestParam("showStatus") Integer showStatus){
        int result = brandService.updateShowStatus(ids, showStatus);
        if (result != 1){
            return GlobalResult.error(result);
        }else {
            return GlobalResult.success(result);
        }
    }

    @PostMapping("/update/factory")
    @ApiOperation(value = "修改厂家制造商状态")
    public GlobalResult updateFactoryStatus(@RequestParam("ids") List<Long> ids,
                                         @RequestParam("factoryStatus") Integer factoryStatus){
        int result = brandService.updateFactoryStatus(ids, factoryStatus);
        if (result != 1){
            return GlobalResult.error(result);
        }else {
            return GlobalResult.success(result);
        }
    }
}
