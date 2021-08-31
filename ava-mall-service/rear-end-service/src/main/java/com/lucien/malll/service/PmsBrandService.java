package com.lucien.malll.service;

import com.lucien.mall.dto.PmsBrandDto;
import com.lucien.mall.pojo.PmsBrand;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/8/31
 * 商品品牌管理Service
 */
public interface PmsBrandService {

    /**
     * 添加品牌
     * @param pmsBrandDto
     * @return
     */
    int insert(PmsBrandDto pmsBrandDto);

    /**
     * 查看所有品牌
     * @return
     */
    List<PmsBrand> list();

    /**
     * 更新品牌信息
     * @param id
     * @param pmsBrand
     * @return
     */
    int update(Long id, PmsBrand pmsBrand);

    /**
     * 删除品牌信息
     * @param id
     * @return
     */
    int del(Long id);

    /**
     * 分页获取品牌
     * @param keyword
     * @param pageNum
     * @param pageSize
     * @return
     */
    List<PmsBrand> listBrand(String keyword, int pageNum, int pageSize);

    /**
     * 获取品牌详情
     * @param id
     * @return
     */
    PmsBrand getItem(Long id);

    /**
     * 批量删除
     * @param ids
     * @return
     */
    int deleteBrand(List<Long> ids);

    /**
     * 修改显示状态
     * @param ids
     * @param showStatus
     * @return
     */
    int updateShowStatus(List<Long> ids, Integer showStatus);

    /**
     * 修改厂家制造商状态
     * @param ids
     * @param factoryStatus
     * @return
     */
    int updateFactoryStatus(List<Long> ids, Integer factoryStatus);
}
