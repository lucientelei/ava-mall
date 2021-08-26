package com.lucien.malll.service.impl;

import com.lucien.mall.mapper.UmsAdminLoginLogMapper;
import com.lucien.mall.pojo.UmsAdminLoginLog;
import com.lucien.malll.service.UmsAdminLoginLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/23
 */
@Service
public class UmsAdminLoginLogServiceImpl implements UmsAdminLoginLogService {

    @Autowired
    private UmsAdminLoginLogMapper loginLogMapper;


    @Override
    public int insertLog(UmsAdminLoginLog umsAdminLoginLog) {
        return loginLogMapper.insert(umsAdminLoginLog);
    }

    @Override
    public List<UmsAdminLoginLog> list() {
        return null;
    }

    @Override
    public List<UmsAdminLoginLog> listByName(String username) {
        return null;
    }
}
