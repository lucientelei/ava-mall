package com.lucien.malll.service;

import com.lucien.mall.pojo.UmsAdminLoginLog;

/**
 * @Author Lucien
 * @Date 2021/8/23
 */
public interface UmsAdminLoginLogService {

    /**
     * 新增用户登录信息
     * @param umsAdminLoginLog
     * @return
     */
    int insertLog(UmsAdminLoginLog umsAdminLoginLog);


}
