package com.lucien.mall.realm;

import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.pojo.UmsAdmin;
import com.lucien.mall.pojo.UmsMember;
import com.lucien.mall.pojo.UmsResource;
import com.lucien.mall.pojo.UmsRole;
import com.lucien.mall.utils.RedisUtils;
import com.lucien.malll.service.ums.UmsAdminService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @Author Lucien
 * @Date 2023/8/22
 */
@SuppressWarnings("serial")
public class ShiroRealm extends AuthorizingRealm {

    @Autowired
    private UmsAdminService umsAdminService;

    @Autowired
    private UmsMemberService umsMemberService;

    @Autowired
    private RedisUtils redisUtils;

    /**
     * 限定Realm 只处理 UsernamePasswordToken
     *
     * @param token
     * @return
     */
    @Override
    public boolean supports(AuthenticationToken token) {
        return token instanceof UsernamePasswordToken;
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //获取当前用户
        UmsAdmin umsAdmin = (UmsAdmin) principalCollection.getPrimaryPrincipal();

        //查询数据库，获取用户的角色信息
        Set<String> roleSet = new HashSet<>();
        List<UmsRole> roleList = umsAdminService.getRoleList(umsAdmin.getId());
        for (UmsRole umsRole : roleList) {
            System.out.println("查询用户角色"+umsRole.getName());
            roleSet.add(umsRole.getName());
        }

        //查询数据库，获取用户的权限信息
        Set<String> stringPermissions = new HashSet<>();
        List<UmsResource> resourceList = umsAdminService.getResourceList(umsAdmin.getId());
        for (UmsResource umsResource : resourceList) {
            System.out.println("查询用户权限信息"+umsResource.getName());
            stringPermissions.add(umsResource.getName());
        }

        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setRoles(roleSet);
        info.setStringPermissions(stringPermissions);

        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String username = (String) token.getPrincipal();

        //获取携带token
        Object credentials = token.getCredentials();

        Object cacheObject = redisUtils.get("TOKEN:" + credentials);
        //判断前台还是后台用户授权
        if (!StringUtils.isEmpty(cacheObject)){
            UmsMember umsMember = umsMemberService.getByUsername(username);
            if (umsMember.getStatus() == 0){
                throw new LockedAccountException("该用户已被锁定,暂时无法登录！");
            }
            SimpleAuthenticationInfo info =
                    new SimpleAuthenticationInfo(umsMember, umsMember.getPassword(), getName());
            return info;
        }else{
            UmsAdmin umsAdmin = umsAdminService.getAdminByUsername(username);
            if (umsAdmin.getStatus() == 0) {
                throw new LockedAccountException("该用户已被锁定,暂时无法登录！");
            }
            /**
             * 将获取到的用户数据封装成 AuthenticationInfo 对象返回，此处封装为 SimpleAuthenticationInfo 对象。
             *  参数1. 认证的实体信息，可以是从数据库中获取到的用户实体类对象或者用户名
             *  参数2. 查询获取到的登录密码
             *  参数3. 盐值
             *  参数4. 当前 Realm 对象的名称，直接调用父类的 getName() 方法即可
             */
            SimpleAuthenticationInfo info =
                    new SimpleAuthenticationInfo(umsAdmin, umsAdmin.getPassword(), getName());
            return info;
        }
    }
}

