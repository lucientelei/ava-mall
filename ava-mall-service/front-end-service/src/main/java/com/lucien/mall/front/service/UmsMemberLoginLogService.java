package com.lucien.mall.front.service;

import com.lucien.mall.pojo.UmsMemberLoginLog;

/**
 * @Author Lucien
 * @Date 2021/8/31
 * 会员登录日志service
 */
public interface UmsMemberLoginLogService {

    /**
     * 新增会员登录信息
     * @param loginLog
     * @return
     */
    int insert(UmsMemberLoginLog loginLog);
}
