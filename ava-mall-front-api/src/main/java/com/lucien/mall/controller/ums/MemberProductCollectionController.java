package com.lucien.mall.controller.ums;

import com.lucien.mall.domain.MemberProductCollection;
import com.lucien.mall.front.service.ums.MemberProductCollectionService;
import com.lucien.mall.global.GlobalResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

/**
 * @Author Lucien
 * @Date 2023/9/7
 */
@RestController
@RequestMapping("/member/product/collection")
@Api(tags = "MemberProductCollectionController", description = "会员商品收藏")
public class MemberProductCollectionController {

    @Autowired
    private MemberProductCollectionService collectionService;

    @PostMapping("/insert")
    @ApiOperation(value = "添加收藏")
    public GlobalResult add(@RequestBody MemberProductCollection productCollection){
        int result = collectionService.add(productCollection);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error();
    }

    @DeleteMapping("/delete")
    @ApiOperation(value = "删除收藏")
    public GlobalResult delete(Long productId){
        int result = collectionService.delete(productId);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error();
    }

    @GetMapping("/list")
    @ApiOperation(value = "分页获取收藏")
    public GlobalResult<Page<MemberProductCollection>> list(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                                            @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize){
        Page<MemberProductCollection> result = collectionService.list(pageNum, pageSize);
        return GlobalResult.success(result);
    }

    @GetMapping("/detail/{productId}")
    @ApiOperation(value = "查看收藏详情")
    public GlobalResult detail(@PathVariable Long productId){
        MemberProductCollection result = collectionService.detail(productId);
        return GlobalResult.success(result);
    }

    @GetMapping("/clear/all")
    @ApiOperation(value = "清空收藏列表")
    public GlobalResult clearAll(){
        collectionService.clearAll();
        return GlobalResult.success();
    }
}

