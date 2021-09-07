package com.lucien.mall.controller.ums;

import com.lucien.mall.domain.MemberBrandAttention;
import com.lucien.mall.front.service.ums.MemberBrandAttentionService;
import com.lucien.mall.global.GlobalResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

/**
 * @Author Lucien
 * @Date 2021/9/7
 */
@RestController
@RequestMapping("/member/brand/attention")
@Api(tags = "MemberBrandAttentionController", description = "会员关注列表")
public class MemberBrandAttentionController {

    @Autowired
    private MemberBrandAttentionService brandAttentionService;

    @PostMapping("/insert")
    @ApiOperation(value = "添加关注")
    public GlobalResult insert(@RequestBody MemberBrandAttention brandAttention){
        int result = brandAttentionService.add(brandAttention);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error();
    }

    @DeleteMapping("/delete")
    @ApiOperation(value = "删除关注")
    public GlobalResult delete(Long brandId){
        int result = brandAttentionService.delete(brandId);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error();
    }

    @GetMapping("/list")
    @ApiOperation(value = "分页获取会员关注")
    public GlobalResult list(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                             @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize){
        Page<MemberBrandAttention> result = brandAttentionService.list(pageNum, pageSize);
        return GlobalResult.success(result);
    }

    @GetMapping("/detail")
    @ApiOperation(value = "获取关注详情")
    public GlobalResult detail(Long brandId){
        MemberBrandAttention result = brandAttentionService.detail(brandId);
        return GlobalResult.success(result);
    }

    @DeleteMapping("/clear/all")
    @ApiOperation(value = "清空关注列表")
    public GlobalResult clearAll(){
        brandAttentionService.clearAll();
        return GlobalResult.success();
    }
}
