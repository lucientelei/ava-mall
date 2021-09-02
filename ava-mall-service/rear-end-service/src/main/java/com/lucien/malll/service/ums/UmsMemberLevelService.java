package com.lucien.malll.service.ums;

import com.lucien.mall.pojo.UmsMemberLevel;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/31
 * 会员等级管理Service
 */
public interface UmsMemberLevelService {

    /**
     * 获取所有用户等级
     * @return
     */
    List<UmsMemberLevel> list(Integer defaultStatus);

}
