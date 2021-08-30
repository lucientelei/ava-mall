package com.lucien.mall.controller;

import com.lucien.mall.dto.UmsAdminDto;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.UmsRole;
import com.lucien.malll.service.UmsRoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/30
 * 后台角色管理Controller
 */
@RestController
@RequestMapping("/role")
@Api(tags = "UmsRoleController", description = "后台角色管理")
public class UmsRoleController {

    @Autowired
    private UmsRoleService roleService;

    @GetMapping("/listall")
    @ApiOperation(value = "获取所有角色列表")
    public GlobalResult listAll(){
        return GlobalResult.success(roleService.listAll());
    }

    @GetMapping("/list")
    @ApiOperation(value = "分页获取角色列表")
    public GlobalResult<GlobalPage<UmsRole>> list(@RequestParam(required = false) String keyWord,
                                                  @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                  @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
        List<UmsRole> result = roleService.list(keyWord, pageSize, pageNum);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @PostMapping("/insert")
    @ApiOperation(value = "新增角色")
    public GlobalResult insert(@RequestBody UmsRole umsRole){
        int result = roleService.insert(umsRole);
        if (result != 1){
            return GlobalResult.error("新增角色失败", result);
        }else {
            return GlobalResult.success("新增角色成功", result);
        }
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation(value = "删除角色")
    public GlobalResult del(@PathVariable("id") Long id){
        int result = roleService.del(id);
        if (result != 1){
            return GlobalResult.error("删除角色失败", result);
        }else {
            return GlobalResult.success("删除角色成功", result);
        }
    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "更新角色")
    public GlobalResult update(@PathVariable("id") Long id,
                               @RequestBody UmsRole umsRole){
        int result = roleService.update(id, umsRole);
        if (result != 1){
            return GlobalResult.error("更新角色失败", result);
        }else {
            return GlobalResult.success("更新角色成功", result);
        }
    }

    @GetMapping("/listmenu/{roleId}")
    @ApiOperation(value = "获取角色菜单")
    public GlobalResult listMenu(@PathVariable("roleId") Long roleId){
        return GlobalResult.success(roleService.listMenu(roleId));
    }

    @GetMapping("/listresource/{roleId}")
    @ApiOperation(value = "获取角色资源")
    public GlobalResult listResource(@PathVariable("roleId") Long roleId){
        return GlobalResult.success(roleService.listResource(roleId));
    }
}
