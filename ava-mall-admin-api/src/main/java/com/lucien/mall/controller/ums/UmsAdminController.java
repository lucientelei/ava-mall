package com.lucien.mall.controller.ums;

import com.lucien.mall.annotation.LoginInfoAnnotation;
import com.lucien.mall.rear.ums.UmsAdminFront;
import com.lucien.mall.rear.ums.UmsAdminRegisterDto;
import com.lucien.mall.rear.ums.UmsAdminLoginDto;
import com.lucien.mall.rear.ums.UpdateAdminPasswordDto;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.UmsAdmin;
import com.lucien.mall.pojo.UmsMenu;
import com.lucien.mall.pojo.UmsResource;
import com.lucien.mall.pojo.UmsRole;
import com.lucien.malll.service.ums.UmsAdminService;
import com.lucien.malll.service.ums.UmsRoleService;
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
 */
@RestController
@Api(tags = "UmsAdminController", description = "后台用户管理")
@RequestMapping("/admin")
public class UmsAdminController {

    @Autowired
    private UmsAdminService umsAdminService;

    @Autowired
    private UmsRoleService roleService;

    @GetMapping("/byname/{username}")
    @ApiOperation(value = "根据用户名获取后台管理员")
    public GlobalResult getAdminByUsername(@PathVariable("username") String username) {
        UmsAdmin result = umsAdminService.getAdminByUsername(username);
        if (StringUtils.isEmpty(result)){
            return GlobalResult.error("查询失败", -1);
        }
        return GlobalResult.success("查询成功", result);
    }

    @LoginInfoAnnotation
    @PostMapping("/login")
    @ApiOperation(value = "用户登录")
    public GlobalResult login(@RequestBody UmsAdminLoginDto dto) {
        String result = umsAdminService.login(dto);
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

    @PostMapping("/register")
    @ApiOperation(value = "用户注册")
    public GlobalResult register(@Validated @RequestBody UmsAdminRegisterDto umsAdminRegisterDto) {
        UmsAdmin result = umsAdminService.register(umsAdminRegisterDto);
        if (StringUtils.isEmpty(result)) {
            return GlobalResult.error("注册失败", -1);
        }
        return GlobalResult.success("注册成功", result);
    }

    @GetMapping("/getitem/{id}")
    @ApiOperation(value = "根据用户id获取用户")
    public GlobalResult getItem(@PathVariable("id") Long id) {
        UmsAdmin result = umsAdminService.getItem(id);
        if (StringUtils.isEmpty(result)) {
            return GlobalResult.error("查询失败", -1);
        }
        return GlobalResult.success("查询成功", result);
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "修改指定用户信息")
    public GlobalResult update(@PathVariable("id") Long id, @RequestBody UmsAdmin admin) {
        int result = umsAdminService.update(id, admin);
        if (result > 0) {
            return GlobalResult.success("更新成功", result);
        }
        return GlobalResult.error("修改失败", result);
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation(value = "删除指定用户")
    public GlobalResult delete(@PathVariable("id") Long id) {
        int result = umsAdminService.delete(id);
        if (result > 0) {
            return GlobalResult.success("删除成功", result);
        }
        return GlobalResult.error("删除失败", result);
    }

    @GetMapping("/role/{adminId}")
    @ApiOperation(value = "获取用户对应角色")
    public GlobalResult getRoleList(@PathVariable("adminId") Long adminId) {
        List<UmsRole> result = umsAdminService.getRoleList(adminId);
        if (result.size() > 0) {
            return GlobalResult.success("查询成功", result);
        }
        return GlobalResult.error("查询失败", result);
    }

    @GetMapping("/resource/{adminId}")
    @ApiOperation(value = "获取指定用户的可访问资源")
    public GlobalResult getResourceList(@PathVariable("adminId") Long adminId) {
        List<UmsResource> result = umsAdminService.getResourceList(adminId);
        if (result.size() > 0) {
            return GlobalResult.success("查询成功", result);
        }
        return GlobalResult.error("查询失败", result);
    }

    @PostMapping("/updatepwd")
    @ApiOperation(value = "修改密码")
    public GlobalResult updatePassword(@RequestBody UpdateAdminPasswordDto dto) {
        int result = umsAdminService.updatePassword(dto);
        if (result == -1) {
            return GlobalResult.error("含有未填写信息", result);
        } else if (result == -2) {
            return GlobalResult.error("查询不到用户", result);
        } else if (result == -3) {
            return GlobalResult.error("旧密码输入错误", result);
        } else if (result == -4) {
            return GlobalResult.error("新旧密码相同", result);
        }
        return GlobalResult.success("修改密码成功", result);
    }

    @PutMapping("/update/{id}/{status}")
    @ApiOperation(value = "修改账号状态")
    public GlobalResult updateStatus(@PathVariable("id") Long id,
                                     @PathVariable("status") Integer status) {
        int result = umsAdminService.updateStatus(id, status);
        if (result > 0) {
            return GlobalResult.success("修改成功！",result);
        }
        return GlobalResult.error("修改失败！",result);
    }

    @PostMapping("/logout")
    @ApiOperation(value = "用户退出登录")
    public GlobalResult logout(String token){
        int result = umsAdminService.logout(token);
        return GlobalResult.success("登出成功！", result);
    }

    @GetMapping("/getInfo")
    @ApiOperation(value = "获取登录用户信息")
    public GlobalResult getUser(){
        UmsAdminFront result = umsAdminService.getInfo();
        List<UmsMenu> menuList = roleService.getMenuList(result.getId());
        result.setMenuList(menuList);
        return GlobalResult.success(result);
    }

    @PostMapping("/update/role")
    @ApiOperation(value = "修改用户角色关系")
    @ResponseBody
    public GlobalResult updateRole(@RequestParam("adminId") Long adminId,
                                   @RequestParam("roleIds") List<Long> roleIds){
        int result = umsAdminService.updateRole(adminId, roleIds);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error();
    }

    @GetMapping("/list")
    @ApiOperation(value = "根据用户名或姓名分页获取用户列表")
    public GlobalResult<GlobalPage<UmsAdmin>> list(String keyword,
                                         @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                         @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<UmsAdmin> result = umsAdminService.list(keyword, pageSize, pageNum);
        return GlobalResult.success(GlobalPage.restPage(result));
    }
}
