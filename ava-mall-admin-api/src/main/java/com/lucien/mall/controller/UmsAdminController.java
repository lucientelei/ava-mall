package com.lucien.mall.controller;

import com.lucien.mall.dto.UmsAdminDto;
import com.lucien.mall.dto.UpdateAdminPasswordDto;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.UmsAdmin;
import com.lucien.mall.pojo.UmsResource;
import com.lucien.mall.pojo.UmsRole;
import com.lucien.malll.service.UmsAdminService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/22
 * 后台用户管理
 */
@RestController
@Api(tags = "UmsAdminController", description = "后台用户管理")
@RequestMapping("/admin")
public class UmsAdminController {

    @Autowired
    private UmsAdminService umsAdminService;

    @GetMapping("/byname/{username}")
    @ApiOperation(value = "根据用户名获取后台管理员")
    public GlobalResult getAdminByUsername(@PathVariable("username") String username){
        UmsAdmin result = umsAdminService.getAdminByUsername(username);
        return GlobalResult.success(result);
    }

    @PostMapping("/login")
    @ApiOperation(value = "用户登录")
    public GlobalResult login(String username, String password){
        String result = umsAdminService.login(username, password);
        return GlobalResult.success(result);
    }

    @PostMapping("/register")
    @ApiOperation(value = "用户注册")
    public GlobalResult register(@Validated @RequestBody UmsAdminDto umsAdminDto){
        UmsAdmin umsAdmin = umsAdminService.register(umsAdminDto);
        if (StringUtils.isEmpty(umsAdmin)){
            return GlobalResult.error("注册失败");
        }
        return GlobalResult.success("注册成功",umsAdmin);
    }

    @GetMapping("/getitem/{id}")
    @ApiOperation(value = "根据用户id获取用户")
    public GlobalResult getItem(@PathVariable("id") Long id){
        UmsAdmin umsAdmin = umsAdminService.getItem(id);
        System.out.println(umsAdmin.getUsername());
        if (StringUtils.isEmpty(umsAdmin)){
            return GlobalResult.error("查询失败");
        }
        return GlobalResult.success(umsAdmin);
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "修改指定用户信息")
    public GlobalResult update(@PathVariable("id") Long id, @RequestBody UmsAdmin admin){
        int result = umsAdminService.update(id, admin);
        if (result > 0){
            return GlobalResult.success("更新成功");
        }
        return GlobalResult.error("修改失败");
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "删除指定用户")
    public GlobalResult delete(Long id){
        int result = umsAdminService.delete(id);
        if (result > 0){
            return GlobalResult.success("删除成功");
        }
        return GlobalResult.error("删除失败");
    }

    @GetMapping("/role/{adminId}")
    @ApiOperation(value = "获取用户对应角色")
    public GlobalResult getRoleList(@PathVariable("adminId") Long adminId){
        List<UmsRole> result = umsAdminService.getRoleList(adminId);
        if (result.size() > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error("查询失败");
    }

    @GetMapping("/resource/{adminId}")
    @ApiOperation(value = "获取指定用户的可访问资源")
    public GlobalResult getResourceList(@PathVariable("adminId") Long adminId){
        List<UmsResource> result = umsAdminService.getResourceList(adminId);
        if (result.size() > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error("查询失败");
    }

    @PostMapping("/updatepwd")
    @ApiOperation(value = "修改密码")
    public GlobalResult updatePassword(@RequestBody UpdateAdminPasswordDto dto){
        int result = umsAdminService.updatePassword(dto);
        if (result == -1){
            return GlobalResult.error("含有为填写信息");
        }else if (result == -2) {
            return GlobalResult.error("查询不到用户");
        }else if (result == -3) {
            return GlobalResult.error("旧密码输入错误");
        }else if (result == -4) {
            return GlobalResult.error("新旧密码相同");
        }
        return GlobalResult.success("修改密码成功");
    }

    @PutMapping("/update/{id}")
    @ApiOperation(value = "修改账号状态")
    public GlobalResult updateStatus(@PathVariable("id") Long id, Integer status){
        int result = umsAdminService.updateStatus(id, status);
        if (result > 0){
            return GlobalResult.success("修改成功");
        }
        return GlobalResult.error("修改失败");
    }
}
