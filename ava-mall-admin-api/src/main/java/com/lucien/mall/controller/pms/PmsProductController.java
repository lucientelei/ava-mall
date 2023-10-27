package com.lucien.mall.controller.pms;

import com.lucien.mall.rear.pms.PmsProductParam;
import com.lucien.mall.rear.pms.PmsProductQueryParam;
import com.lucien.mall.rear.pms.PmsProductResult;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.PmsProduct;
import com.lucien.malll.service.pms.PmsProductService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/1
 */
@RestController
@RequestMapping("/product")
@Api(tags = "PmsProductController", description = "后台商品管理")
public class PmsProductController {

    @Autowired
    private PmsProductService productService;

    @PostMapping("/insert")
    @ApiOperation(value = "新增商品")
    public GlobalResult insert(@RequestBody PmsProductParam param){
        int result = productService.insert(param);
        if (result > 0){
            return GlobalResult.success(result);
        }else {
            return GlobalResult.error();
        }
    }

    @GetMapping("/info/{id}")
    @ApiOperation(value = "根据商品编号获取更新信息")
    public GlobalResult getUpdateInfo(@PathVariable("id") Long id){
        PmsProductResult result = productService.getUpdateInfo(id);
        if(StringUtils.isEmpty(result)){
            return GlobalResult.error();
        }
        return GlobalResult.success(result);
    }

    @GetMapping("/list")
    @ApiOperation(value = "分页查询商品")
    public GlobalResult<GlobalPage<PmsProduct>> list(PmsProductQueryParam productQueryParam,
                                                     @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                     @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<PmsProduct> result = productService.list(productQueryParam, pageSize, pageNum);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @GetMapping("/list/{keyword}")
    @ApiOperation(value = "模糊搜索")
    public GlobalResult list(@PathVariable("keyword") String keyWord){
        List<PmsProduct> result = productService.list(keyWord);
        return GlobalResult.success(result);
    }

    @PostMapping("/update/verify")
    @ApiOperation(value = "批量修改商品审核状态")
    public GlobalResult updateVerifyStatus(@RequestParam List<Long> ids,
                                           @RequestParam Integer status,
                                           @RequestParam String detail){
        int result = productService.updateVerifyStatus(ids, status, detail);
        if (result > 0){
            return GlobalResult.success(result);
        }else {
            return GlobalResult.error();
        }
    }

    @PostMapping("/update/publish")
    @ApiOperation(value = "批量修改商品上架状态")
    public GlobalResult updatePublishStatus(@RequestParam List<Long> ids,
                                            @RequestParam Integer publishStatus){
        int result = productService.updatePublishStatus(ids, publishStatus);
        if (result > 0){
            return GlobalResult.success(result);
        }else {
            return GlobalResult.error();
        }
    }

    @PostMapping("/update/recommend")
    @ApiOperation(value = "批量修改商品推荐状态")
    public GlobalResult updateRecommandStatus(@RequestParam List<Long> ids,
                                              @RequestParam Integer recommendStatus){
        int result = productService.updateRecommandStatus(ids, recommendStatus);
        if (result > 0){
            return GlobalResult.success(result);
        }else {
            return GlobalResult.error();
        }
    }

    @PostMapping("/update/new")
    @ApiOperation(value = "批量修改商品新品状态")
    public GlobalResult updateNewStatus(@RequestParam List<Long> ids,
                                        @RequestParam Integer newStatus){
        int result = productService.updateNewStatus(ids, newStatus);
        if (result > 0){
            return GlobalResult.success(result);
        }else {
            return GlobalResult.error();
        }
    }

    @PostMapping("/update/delete")
    @ApiOperation(value = "批量修改商品删除状态")
    public GlobalResult updateDeleteStatus(@RequestParam List<Long> ids,
                                           @RequestParam Integer deleteStatus){
        int result = productService.updateDeleteStatus(ids, deleteStatus);
        if (result > 0){
            return GlobalResult.success(result);
        }else {
            return GlobalResult.error();
        }
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "更新商品")
    public GlobalResult update(@PathVariable("id") Long id,
                               @RequestBody PmsProductParam productParam){
        int result = productService.update(id, productParam);
        if (result > 0){
            return GlobalResult.success(result);
        }else {
            return GlobalResult.error();
        }
    }
}
