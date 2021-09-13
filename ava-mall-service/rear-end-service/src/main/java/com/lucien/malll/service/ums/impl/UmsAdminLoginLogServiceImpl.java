package com.lucien.malll.service.ums.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.mapper.UmsAdminLoginLogMapper;
import com.lucien.mall.pojo.UmsAdminLoginLog;
import com.lucien.mall.pojo.UmsAdminLoginLogExample;
import com.lucien.malll.service.ums.UmsAdminLoginLogService;
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


    /**
     * 新增用户登录信息
     * @param umsAdminLoginLog
     * @return
     */
    @Override
    public int insertLog(UmsAdminLoginLog umsAdminLoginLog) {
        return loginLogMapper.insert(umsAdminLoginLog);
    }

    /**
     * 查询所有用户登录记录
     * @return
     */
    @Override
    public List<UmsAdminLoginLog> list(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<UmsAdminLoginLog> list = loginLogMapper.selectByExample(new UmsAdminLoginLogExample());
        return list;
    }

    /**
     * 根据用户名查询登录日志
     * @param username
     * @return
     */
    @Override
    public List<UmsAdminLoginLog> listByName(String username) {
        return null;
    }
}
