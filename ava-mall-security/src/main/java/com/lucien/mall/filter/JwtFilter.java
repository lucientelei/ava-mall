package com.lucien.mall.filter;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import cn.hutool.core.util.StrUtil;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.lucien.mall.constant.HttpStatus;
import com.lucien.mall.domain.JwtToken;
import com.lucien.mall.global.GlobalExceptionHandler;
import com.lucien.mall.global.error.MyException;
import com.lucien.mall.utils.JWTUtils;
import com.lucien.mall.utils.RedisUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.BasicHttpAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.cache.RedisCache;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * @Author Lucien
 * @Date 2021/8/22
 * 自定义的认证过滤器，用来拦截Header中携带token的请求
 */
@Component
public class JwtFilter extends BasicHttpAuthenticationFilter {

    /**
     * 前置拦截处理
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @Override
    protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {
        System.out.println("前置拦截");
        //servlet请求响应转换
        HttpServletRequest httpServletRequest = WebUtils.toHttp(request);
        HttpServletResponse httpServletResponse = WebUtils.toHttp(response);
//        try {
//            String token = httpServletRequest.getHeader("Authorization");
//            System.out.println(token);
//            String name = JWTUtils.getName(token);
//            boolean verifyFlag = JWTUtils.verify(token, name);
//            if (!verifyFlag){
//                throw new MyException("token校验错误");
//            }
//        }catch (JWTDecodeException e){
//            throw new MyException(e.getMessage());
//        }catch (NullPointerException e){
//            throw new MyException(e.getMessage());
//        }catch (IllegalArgumentException e){
//            throw new MyException(e.getMessage());
//        }

        if (httpServletRequest.getMethod().equals(RequestMethod.OPTIONS.name())) {
            httpServletResponse.setStatus(HttpStatus.SUCCESS);
            return false;
        }
        return super.preHandle(request, response);
    }

    /**
     * 后置拦截处理
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @Override
    protected void postHandle(ServletRequest request, ServletResponse response) throws Exception {
        //添加跨域支持
        this.fillCorsHeader(WebUtils.toHttp(request), WebUtils.toHttp(response));
    }

    /**
     * 过滤器拦截请求的入口方法
     *
     * @param request
     * @param response
     * @param mappedValue
     * @return 返回true则允许访问
     */
    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        //isLoginRequest() 调用了isLoginAttempt()方法
        if (this.isLoginRequest(request, response)) {
            //返回false后进入onAccessDenied()方法，返回错误信息
            return false;
        }

        boolean allowed = false;

        try {
            allowed = this.executeLogin(request, response);
        } catch (IllegalStateException e) { //未找到token
            e.printStackTrace();
            System.out.println("未找到token");
        } catch (TokenExpiredException e) {
            e.printStackTrace();
        }  catch (Exception e) {
            e.printStackTrace();
            System.out.println("token检验出错");
        }

        return allowed || super.isPermissive(mappedValue);
    }

    /**
     * 检测Header中是否包含token字段
     *
     * @param request
     * @param response
     * @return
     */
    @Override
    protected boolean isLoginAttempt(ServletRequest request, ServletResponse response) {
        return ((HttpServletRequest) request).getHeader(JWTUtils.AUTH_HEADER) == null;
    }

    /**
     * 身份验证，检查JWT token是否合法
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @Override
    protected boolean executeLogin(ServletRequest request, ServletResponse response) throws Exception {
        //从请求头里拿到token
        AuthenticationToken token = createToken(request, response);
        if (StringUtils.isEmpty(token)) {
            String msg = "createToken method implementation returned null. A valid non-null AuthenticationToken must be created in order to execute a login attempt.";
            throw new IllegalStateException(msg);
        }

        try {
            Subject subject = getSubject(request, response);
            //使用shiro进行登录验证
            subject.login(token);
            //验证成功
            return onLoginSuccess(token, subject, request, response);
        } catch (AuthenticationException e) {
            return onLoginFailure(token, e, request, response);
        }
    }

    /**
     * 从Header中提取 JWT token
     *
     * @param request
     * @param response
     * @return
     */
    @Override
    protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) {
        try {
            HttpServletRequest httpServletRequest = (HttpServletRequest) request;
            String authorization = httpServletRequest.getHeader(JWTUtils.AUTH_HEADER);
            JwtToken token = new JwtToken(authorization);
            return token;
        }catch (JWTDecodeException e){
            throw new MyException("用户Token不正确");
        }
    }

    /**
     * isAccessAllowed()方法返回false,会进入该方法，表示拒绝访问
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        //servlet请求响应转换
        HttpServletRequest httpServletRequest = WebUtils.toHttp(request);
        String token = httpServletRequest.getHeader("Authorization");
        if (!StringUtils.isEmpty(token)){
            return true;
        }
        HttpServletResponse httpServletResponse = WebUtils.toHttp(response);

        httpServletResponse.setCharacterEncoding("UTF-8");
        httpServletResponse.setContentType("application/json;charset=UTF-8");
        httpServletResponse.setStatus(HttpStatus.UNAUTHORIZED);

        PrintWriter printWriter = httpServletResponse.getWriter();
        printWriter.write("{\"code\":401,\"msg\":\"UNAUTHORIZED\"}");

        fillCorsHeader(WebUtils.toHttp(request), httpServletResponse);

        return false;
    }

    /**
     * 登录成功后，进入该方法 刷新token
     *
     * @param token
     * @param subject
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
        HttpServletResponse httpServletResponse = WebUtils.toHttp(response);
        String newToken = null;

        //登录成功后刷新token
        if (token instanceof JwtToken) {
            newToken = JWTUtils.refreshTokenExpired(token.getCredentials().toString(), JWTUtils.SECRET);
        }
        if (newToken != null) {
            httpServletResponse.setHeader(JWTUtils.AUTH_HEADER, newToken);
        }

        return true;
    }

    /**
     * 登录失败，会进入该方法
     *
     * @param token
     * @param e
     * @param request
     * @param response
     * @return
     */
    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
        //直接返回false,交给后面的 onAccessDenied()方法处理
        return false;
    }

    /**
     * 跨域请求配置
     *
     * @param request
     * @param response
     */
    protected void fillCorsHeader(HttpServletRequest request, HttpServletResponse response) {
        response.setHeader("Access-control-Allow-Origin", request.getHeader("Origin"));
        response.setHeader("Access-Control-Allow-Methods", "GET,POST,OPTIONS,HEAD");
        response.setHeader("Access-Control-Allow-Headers",
                request.getHeader("Access-Control-Request-Headers"));
    }
}