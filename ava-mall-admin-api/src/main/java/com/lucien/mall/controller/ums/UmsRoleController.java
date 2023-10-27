package com.lucien.mall.controller.ums;

import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.UmsMenu;
import com.lucien.mall.pojo.UmsResource;
import com.lucien.mall.pojo.UmsRole;
import com.lucien.malll.service.ums.UmsRoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/8/30
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
    public GlobalResult listAll() {
        return GlobalResult.success(roleService.listAll());
    }

    @GetMapping("/list")
    @ApiOperation(value = "分页获取角色列表")
    public GlobalResult<GlobalPage<UmsRole>> list(@RequestParam(value = "keyword", required = false) String keyWord,
                                                  @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
                                                  @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        List<UmsRole> result = roleService.list(keyWord, pageSize, pageNum);
        return GlobalResult.success(GlobalPage.restPage(result));
    }

    @PostMapping("/insert")
    @ApiOperation(value = "新增角色")
    public GlobalResult insert(@RequestBody UmsRole umsRole) {
        int result = roleService.insert(umsRole);
        if (result > 0) {
            return GlobalResult.success("新增角色成功", result);
        }
        return GlobalResult.error("新增角色失败", result);
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation(value = "删除角色")
    public GlobalResult del(@PathVariable("id") Long id) {
        int result = roleService.del(id);
        if (result > 0) {
            return GlobalResult.success("删除角色成功", result);
        }
        return GlobalResult.error("删除角色失败", result);

    }

    @PostMapping("/update/{id}")
    @ApiOperation(value = "更新角色")
    public GlobalResult update(@PathVariable("id") Long id,
                               @RequestBody UmsRole umsRole) {
        int result = roleService.update(id, umsRole);
        if (result > 0) {
            return GlobalResult.success("更新角色成功", result);
        }
        return GlobalResult.error("更新角色失败", result);
    }

    @GetMapping("/listmenu/role/{roleId}")
    @ApiOperation(value = "根据角色Id获取角色菜单")
    public GlobalResult listMenu(@PathVariable("roleId") Long roleId) {
        List<UmsMenu> result = roleService.listMenu(roleId);
        if (!CollectionUtils.isEmpty(result)){
            return GlobalResult.success(roleService.listMenu(roleId));
        }
        return GlobalResult.error();
    }

    @GetMapping("/listmenu/admin/{adminId}")
    @ApiOperation(value = "根据管理员Id获取对应菜单")
    public GlobalResult getMenuList(@PathVariable("adminId") Long adminId) {
        List<UmsMenu> result = roleService.getMenuList(adminId);
        if (!CollectionUtils.isEmpty(result)){
            return GlobalResult.success(roleService.getMenuList(adminId));
        }
        return GlobalResult.error();
    }

    @GetMapping("/listresource/{roleId}")
    @ApiOperation(value = "获取角色资源")
    public GlobalResult listResource(@PathVariable("roleId") Long roleId) {
        List<UmsResource> result = roleService.listResource(roleId);
        if (!CollectionUtils.isEmpty(result)){
            return GlobalResult.success(roleService.listResource(roleId));
        }
        return GlobalResult.error();
    }

    @PostMapping("/alloc/menu")
    @ApiOperation(value = "给角色分配菜单")
    public GlobalResult allocMenu(@RequestParam Long roleId,
                                  @RequestParam List<Long> menuIds) {
        int result = roleService.allocMenu(roleId, menuIds);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @PostMapping("/alloc/resource")
    @ApiOperation(value = "给角色分配资源")
    public GlobalResult allocResource(@RequestParam Long roleId,
                                      @RequestParam List<Long> resourceIds) {
        int result = roleService.allocResource(roleId, resourceIds);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @PutMapping("/update/status/{roleId}/{status}")
    @ApiOperation(value = "更新角色启用状态")
    public GlobalResult updateStatus(@PathVariable("roleId") Long roleId,
                                     @PathVariable("status") Integer status) {
        int result = roleService.updateStatus(roleId, status);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }
}
