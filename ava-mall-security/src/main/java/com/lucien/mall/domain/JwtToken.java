package com.lucien.mall.domain;

import com.lucien.mall.utils.JWTUtils;
import org.apache.shiro.authc.AuthenticationToken;

/**
 * @Author Lucien
 * @Date 2023/8/22
 * 封装成UsernamePasswordToken让shiro进行登录、登出等操作
 */
public class JwtToken implements AuthenticationToken {

    private static final long serialVersionUID = 1L;

    //加密后的 JWT token
    private String token;

    private String username;

    public JwtToken(String token){
        this.token = token;
        this.username = JWTUtils.getClaimFiled(token,"username");
    }

    @Override
    public Object getPrincipal() {
        return this.username;
    }

    @Override
    public Object getCredentials() {
        return token;
    }
}
