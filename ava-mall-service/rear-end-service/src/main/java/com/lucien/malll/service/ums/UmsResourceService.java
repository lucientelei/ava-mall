package com.lucien.malll.service.ums;

import com.lucien.mall.pojo.UmsResource;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/8/30
 * 后台资源管理Service
 */
public interface UmsResourceService {

    /**
     * 获取所有资源
     * @return
     */
    List<UmsResource> listAll();

    /**
     * 分页模糊查询
     * @param categoryId
     * @param nameKeyword
     * @param urlKeyword
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<UmsResource> list(Long categoryId, String nameKeyword, String urlKeyword, Integer pageSize, Integer pageNum);

    /**
     * 新增资源
     * @param umsResource
     * @return
     */
    int insert(UmsResource umsResource);

    /**
     * 更新资源
     * @param id
     * @param umsResource
     * @return
     */
    int update(Long id, UmsResource umsResource);

    /**
     * 删除资源
     * @param id
     * @return
     */
    int del(Long id);

    /**
     * 获取资源
     * @param id
     * @return
     */
    UmsResource getItem(Long id);

}
