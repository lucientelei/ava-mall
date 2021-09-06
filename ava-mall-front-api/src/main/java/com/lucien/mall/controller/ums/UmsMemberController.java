package com.lucien.mall.controller.ums;

import com.lucien.mall.annotation.LoginInfoAnnotation;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.UmsMember;
import com.lucien.mall.front.service.UmsMemberService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

/**
 * @Author Lucien
 * @Date 2021/8/31
 */
@RestController
@RequestMapping("/member")
@Api(tags = "UmsMemberController", description = "会员操作")
public class UmsMemberController {

    @Autowired
    private UmsMemberService memberService;

    @GetMapping("/getbyname")
    @ApiOperation(value = "根据用户名获取会员")
    public GlobalResult getByUsername(String username) {
        UmsMember result = memberService.getByUsername(username);
        if (StringUtils.isEmpty(result)) {
            return GlobalResult.error("获取失败", result);
        } else {
            return GlobalResult.success(result);
        }
    }

    @PostMapping("/regist")
    @ApiOperation(value = "会员注册")
    public GlobalResult register(String username, String password, String telephone) {
        String result = memberService.register(username, password, telephone);
        return GlobalResult.success(result);
    }

    @GetMapping("/login")
    @ApiOperation(value = "会员登录")
    public GlobalResult login(String username, String password) {
        String result = memberService.login(username, password);
        if (result.equals("-1")) {
            return GlobalResult.error("不存在该用户！", result);
        } else if (result.equals("-2")) {
            return GlobalResult.error("用户名与密码不匹配！", result);
        } else if (result.equals("-3")) {
            return GlobalResult.error("该账户已被锁定！", result);
        } else if (result.equals("-4")) {
            return GlobalResult.error("登录异常！", result);
        } else if (result.equals("-5")) {
            return GlobalResult.error("登录失败！", result);
        }
        return GlobalResult.success("登录成功！", result);
    }

    @GetMapping("/getbyid/{id}")
    @ApiOperation(value = "根据会员编号获取会员")
    public GlobalResult getById(@PathVariable("id") Long id) {
        UmsMember result = memberService.getById(id);
        return GlobalResult.success(result);
    }

    @GetMapping("/logout")
    @ApiOperation(value = "会员退出登录")
    public GlobalResult logout(String token) {
        int result = memberService.logout(token);
        return GlobalResult.success("退出登录成功", result);
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "更新会员信息")
    public GlobalResult update(@PathVariable("id") Long id, @RequestBody UmsMember umsMember) {
        int result = memberService.update(id, umsMember);
        return GlobalResult.success("更新成功", result);
    }

}
