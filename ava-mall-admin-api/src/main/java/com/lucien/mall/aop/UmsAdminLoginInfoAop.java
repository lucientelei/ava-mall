package com.lucien.mall.aop;

import com.lucien.mall.pojo.UmsAdmin;
import com.lucien.mall.pojo.UmsAdminLoginLog;
import com.lucien.malll.service.ums.UmsAdminLoginLogService;
import com.lucien.malll.service.ums.UmsAdminService;
import eu.bitwalker.useragentutils.Browser;
import eu.bitwalker.useragentutils.UserAgent;
import org.apache.shiro.SecurityUtils;
import org.aspectj.lang.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * @Author Lucien
 * @Date 2021/8/23
 * 用户登录日志切面
 */
@Aspect
@Component
public class UmsAdminLoginInfoAop {

    private static final Logger logger = LoggerFactory.getLogger(UmsAdminLoginInfoAop.class);

    @Autowired
    private UmsAdminLoginLogService loginLogService;

    @Autowired
    private UmsAdminService adminService;

    @After(value = "@annotation(com.lucien.mall.annotation.LoginInfoAnnotation)")
    public void after() {
        //获取到请求的属性
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        //获取到请求对象
        HttpServletRequest request = attributes.getRequest();
        String agent = request.getHeader("User-Agent");
        //解析agent字符串
        UserAgent userAgent = UserAgent.parseUserAgentString(agent);
        //获取浏览器对象
        Browser browser = userAgent.getBrowser();

        try {
            UmsAdminLoginLog loginLog = new UmsAdminLoginLog();
            UmsAdmin umsAdmin = (UmsAdmin) SecurityUtils.getSubject().getPrincipal();
            loginLog.setAdminId(umsAdmin.getId());
            loginLog.setIp("127.0.0.1");
            loginLog.setUserAgent(browser.getName());
            loginLog.setCreateTime(new Date());

            adminService.updateLoginTime(umsAdmin.getId());
            loginLogService.insertLog(loginLog);
        }catch (NullPointerException e){

        }

    }

}
