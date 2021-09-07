package com.lucien.mall.controller.ums;

import com.lucien.mall.domain.MemberReadHistory;
import com.lucien.mall.front.service.ums.MemberReadHistoryService;
import com.lucien.mall.global.GlobalResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/7
 */
@RestController
@RequestMapping("/member/read/history")
@Api(tags = "MemberReadHistoryController", description = "会员浏览记录管理")
public class MemberReadHistoryController {

    @Autowired
    private MemberReadHistoryService readHistoryService;

    @PostMapping("/insert")
    @ApiOperation(value = "创建浏览记录")
    public GlobalResult insert(@RequestBody MemberReadHistory memberReadHistory){
        int result = readHistoryService.insert(memberReadHistory);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error();
    }

    @DeleteMapping("/delete")
    @ApiOperation(value = "批量删除浏览记录")
    public GlobalResult delete(List<String> ids){
        int result = readHistoryService.delete(ids);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error();
    }

    @GetMapping("/list")
    @ApiOperation(value = "分页获取用户浏览记录")
    public GlobalResult<Page<MemberReadHistory>> list(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                             @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize){
        Page<MemberReadHistory> result = readHistoryService.list(pageNum, pageSize);
        return GlobalResult.success(result);
    }

    @GetMapping("/clear")
    @ApiOperation(value = "清空浏览记录")
    public GlobalResult clear(){
        readHistoryService.clear();
        return GlobalResult.success();
    }
}
