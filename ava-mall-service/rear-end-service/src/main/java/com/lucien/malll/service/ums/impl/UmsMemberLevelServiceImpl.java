package com.lucien.malll.service.ums.impl;

import com.lucien.mall.mapper.UmsMemberLevelMapper;
import com.lucien.mall.pojo.UmsMemberLevel;
import com.lucien.mall.pojo.UmsMemberLevelExample;
import com.lucien.malll.service.ums.UmsMemberLevelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/31
 * 会员等级管理Impl
 */
@Service
public class UmsMemberLevelServiceImpl implements UmsMemberLevelService {

    @Autowired
    private UmsMemberLevelMapper memberLevelMapper;

    /**
     * 获取所有用户等级
     * @return
     */
    @Override
    public List<UmsMemberLevel> list(Integer defaultStatus) {
        UmsMemberLevelExample example = new UmsMemberLevelExample();
        example.createCriteria().andDefaultStatusEqualTo(defaultStatus);
        return memberLevelMapper.selectByExample(example);
    }
}
