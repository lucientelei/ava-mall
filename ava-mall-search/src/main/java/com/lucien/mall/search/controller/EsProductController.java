package com.lucien.mall.search.controller;

import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.search.pojo.EsProduct;
import com.lucien.mall.search.service.EsProductService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/7
 */
@RestController
@RequestMapping("/es/product")
@Api(tags = "EsProductController", description = "搜索商品管理")
public class EsProductController {

    @Autowired
    private EsProductService productService;

    @PostMapping("/create")
    @ApiOperation(value = "添加商品到ES库")
    public GlobalResult create(){
        int result = productService.create();
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error();
    }

    @PostMapping("/create/{id}")
    @ApiOperation(value = "根据ID创建商品")
    public GlobalResult create(@PathVariable("id") Long id){
        EsProduct result = productService.create(id);
        if (!StringUtils.isEmpty(result)){
            return GlobalResult.success(result);
        }
        return GlobalResult.error();
    }

    @DeleteMapping("/delete/{id}")
    @ApiOperation(value = "根据ID删除商品/完全删除")
    public GlobalResult delete(@PathVariable("id") Long id){
        productService.delete(id);
        return GlobalResult.success("删除成功");
    }

    @DeleteMapping("/delete/ids")
    @ApiOperation(value = "批量删除商品/仅删除数据不删除索引")
    public GlobalResult delete(@RequestParam("ids") List<Long> ids){
        productService.delete(ids);
        return GlobalResult.success("批量删除成功");
    }

    @DeleteMapping("/delete/all")
    @ApiOperation(value = "清空ES索引库")
    public GlobalResult delete(){
        productService.delete();
        return GlobalResult.success();
    }

    @GetMapping("/search/simple")
    @ApiOperation(value = "根据关键字搜索名称或者副标题")
    public GlobalResult<GlobalPage<EsProduct>> search(@RequestParam(required = false) String keyWord,
                                                @RequestParam(required = false, value = "pageNum", defaultValue = "0") Integer pageNum,
                                                @RequestParam(required = false, value = "pageSize", defaultValue = "5") Integer pageSize){
        Page<EsProduct> result = productService.search(keyWord, pageNum, pageSize);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @GetMapping("/test")
    @ApiOperation(value = "test")
    public GlobalResult<GlobalPage<List<EsProduct>>> test(@RequestParam(required = false) String keyWord,
                                                          @RequestParam(required = false, value = "pageNum", defaultValue = "0") Integer pageNum,
                                                          @RequestParam(required = false, value = "pageSize", defaultValue = "5") Integer pageSize){
        List<EsProduct> result = productService.test(keyWord, pageNum, pageSize);
        System.out.println(result.size());
//        return null;
        return GlobalResult.success(GlobalPage.restPage(result));
    }
}
