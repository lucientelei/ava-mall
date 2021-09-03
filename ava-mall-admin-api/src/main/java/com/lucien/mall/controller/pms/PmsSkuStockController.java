package com.lucien.mall.controller.pms;

import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.PmsSkuStock;
import com.lucien.malll.service.pms.PmsSkuStockService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 */
@RestController
@RequestMapping("/sku")
@Api(value = "PmsSkuStockController", description = "后台商品库存管理")
public class PmsSkuStockController {

    @Autowired
    private PmsSkuStockService skuStockService;

    @GetMapping("/list/{id}")
    @ApiOperation(value = "根据产品Id和skuCode搜索")
    public GlobalResult list(@PathVariable("id") Long id,
                             @RequestParam(value = "keyword", required = false) String keyword){
        List<PmsSkuStock> result = skuStockService.list(id, keyword);
        return GlobalResult.success(result);
    }

    @PostMapping("/update/{pid}")
    @ApiOperation(value = "批量更新商品库存信息")
    public GlobalResult update(@PathVariable("pid") Long pid,
                               @RequestBody List<PmsSkuStock> skuStockList){
        int result = skuStockService.update(pid, skuStockList);
        if (result != 1){
            return GlobalResult.error();
        }
        return GlobalResult.success(result);
    }
}
