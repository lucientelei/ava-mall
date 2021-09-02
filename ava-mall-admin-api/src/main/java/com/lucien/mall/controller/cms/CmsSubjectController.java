package com.lucien.mall.controller.cms;

import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.CmsSubject;
import com.lucien.malll.service.cms.CmsSubjectService;
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
@RequestMapping("/subject")
@Api(tags = "CmsSubjectController", description = "后台商品专题管理")
public class CmsSubjectController {

    @Autowired
    private CmsSubjectService subjectService;

    @GetMapping("/list")
    @ApiOperation(value = "查询所有专题")
    public GlobalResult list(){
        List<CmsSubject> result = subjectService.list();
        return GlobalResult.success(result);
    }

    @GetMapping("/listpage/{keyWord}")
    @ApiOperation(value = "分页获取专题")
    public GlobalResult<GlobalPage<CmsSubject>> listPage(@PathVariable("keyWord") String keyWord,
                                             @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                             @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<CmsSubject> result = subjectService.listPage(keyWord, pageSize, pageNum);
        return GlobalResult.success(GlobalPage.restPage(result));
    }
}
