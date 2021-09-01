package com.lucien.malll.service;

import com.lucien.mall.dto.PmsProductParam;
import com.lucien.mall.dto.PmsProductQueryParam;
import com.lucien.mall.dto.PmsProductResult;
import com.lucien.mall.pojo.PmsProduct;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 商品管理Service
 */
public interface PmsProductService {

    /**
     * 新增商品
     * @param param
     * @return
     */
    int insert(PmsProductParam param);

    /**
     * 根据商品编号获取更新信息
     * @param id
     * @return
     */
    PmsProductResult getUpdateInfo(Long id);

    /**
     * 分页查询商品
     * @param productQueryParam
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<PmsProduct> list(PmsProductQueryParam productQueryParam, Integer pageSize, Integer pageNum);

    /**
     * 批量修改商品审核状态
     * @param ids
     * @param verifyStatus
     * @param detail
     * @return
     */
    int updateVerifyStatus(List<Long> ids, Integer verifyStatus, String detail);

    /**
     * 批量修改商品上架状态
     * @param ids
     * @param publishStatus
     * @return
     */
    int updatePublishStatus(List<Long> ids, Integer publishStatus);

    /**
     * 批量修改商品推荐状态
     * @param ids
     * @param commandStatus
     * @return
     */
    int updateRecommandStatus(List<Long> ids, Integer commandStatus);

    /**
     * 批量修改商品新品状态
     * @param ids
     * @param newStatus
     * @return
     */
    int updateNewStatus(List<Long> ids, Integer newStatus);

    /**
     * 批量修改商品删除状态
     * @param ids
     * @param deleteStatus
     * @return
     */
    int updateDeleteStatus(List<Long> ids, Integer deleteStatus);

    /**
     * 根据商品名称或货号模糊查询商品
     * @param keyWord
     * @return
     */
    List<PmsProduct> list(String keyWord);

    /**
     * 更新商品
     * @param id
     * @param productParam
     * @return
     */
    int update(Long id, PmsProductParam productParam);
}
