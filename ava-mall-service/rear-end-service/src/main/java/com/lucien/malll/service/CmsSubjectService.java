package com.lucien.malll.service;

import com.lucien.mall.pojo.CmsSubject;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 商品专题管理Service
 */
public interface CmsSubjectService {

    /**
     * 查询所有专题
     * @return
     */
    List<CmsSubject> list();

    /**
     * 分页获取专题
     * @param keyWord
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<CmsSubject> listPage(String keyWord, Integer pageSize, Integer pageNum);
}
