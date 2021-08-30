package com.lucien.malll.service.impl;

import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.lucien.mall.mapper.UmsResourceMapper;
import com.lucien.mall.pojo.UmsResource;
import com.lucien.mall.pojo.UmsResourceExample;
import com.lucien.malll.service.UmsResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.net.UnknownServiceException;
import java.util.Date;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/30
 * 后台资源管理Impl
 */
@Service
public class UmsResourceServiceImpl implements UmsResourceService {

    @Autowired
    private UmsResourceMapper resourceMapper;

    /**
     * 获取所有资源
     * @return
     */
    @Override
    public List<UmsResource> listAll() {
        return resourceMapper.selectByExample(new UmsResourceExample());
    }

    /**
     * 分页模糊查询
     * @param categoryId
     * @param nameKeyword
     * @param urlKeyword
     * @param pageSize
     * @param pageNum
     * @return
     */
    @Override
    public List<UmsResource> list(Long categoryId, String nameKeyword, String urlKeyword, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        UmsResourceExample example = new UmsResourceExample();
        UmsResourceExample.Criteria criteria = example.createCriteria();
        if (categoryId != null){
            criteria.andCategoryIdEqualTo(categoryId);
        }
        if (StrUtil.isNotEmpty(nameKeyword)){
            criteria.andNameLike('%' + nameKeyword + '%');
        }
        if (StrUtil.isNotEmpty(urlKeyword)){
            criteria.andNameLike('%' + urlKeyword + '%');
        }
        return resourceMapper.selectByExample(example);
    }

    /**
     * 新增资源
     * @param umsResource
     * @return
     */
    @Override
    public int insert(UmsResource umsResource) {
        umsResource.setCreateTime(new Date());
        return resourceMapper.insert(umsResource);
    }

    /**
     * 更新资源
     * @param id
     * @param umsResource
     * @return
     */
    @Override
    public int update(Long id, UmsResource umsResource) {
        umsResource.setId(id);
        return resourceMapper.updateByPrimaryKeySelective(umsResource);
    }

    /**
     * 删除资源
     * @param id
     * @return
     */
    @Override
    public int del(Long id) {
        return resourceMapper.deleteByPrimaryKey(id);
    }

    /**
     * 获取资源
     * @param id
     * @return
     */
    @Override
    public UmsResource getItem(Long id) {
        return resourceMapper.selectByPrimaryKey(id);
    }
}
