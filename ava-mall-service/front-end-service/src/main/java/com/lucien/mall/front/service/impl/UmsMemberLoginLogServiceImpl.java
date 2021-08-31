package com.lucien.mall.front.service.impl;

import com.lucien.mall.front.service.UmsMemberLoginLogService;
import com.lucien.mall.mapper.UmsMemberLoginLogMapper;
import com.lucien.mall.pojo.UmsMemberLoginLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * @Author Lucien
 * @Date 2021/8/31
 * 会员登录日志Impl
 */
@Primary
@Service
public class UmsMemberLoginLogServiceImpl implements UmsMemberLoginLogService {

    @Autowired
    private UmsMemberLoginLogMapper loginLogMapper;

    @Override
    public int insert(UmsMemberLoginLog loginLog) {
        loginLog.setCreateTime(new Date());
        return loginLogMapper.insert(loginLog);
    }
}
