package com.lucien.malll.service.ums;

import com.lucien.mall.pojo.UmsAdminLoginLog;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/8/23
 * 后台用户登录日志
 */
public interface UmsAdminLoginLogService {

    /**
     * 新增用户登录信息
     * @param umsAdminLoginLog
     * @return
     */
    int insertLog(UmsAdminLoginLog umsAdminLoginLog);

    /**
     * 查询所有用户登录记录
     * @return
     */
    List<UmsAdminLoginLog> list(Integer pageNum, Integer pageSize);

    /**
     * 根据用户名查询登录日志
     * @param username
     * @return
     */
    List<UmsAdminLoginLog> listByName(String username);
}
