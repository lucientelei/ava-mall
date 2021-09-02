package com.lucien.malll.service.oms;

import com.lucien.mall.pojo.OmsOrderReturnReason;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/2
 * 退货原因管理Service
 */
public interface OmsOrderReturnReasonService {

    /**
     * 新增退货原因
     * @param returnReason
     * @return
     */
    int insert(OmsOrderReturnReason returnReason);

    /**
     * 批量删除退货原因
     * @param ids
     * @return
     */
    int del(List<Long> ids);

    /**
     * 修改退货原因
     * @param id
     * @param returnReason
     * @return
     */
    int update(Long id, OmsOrderReturnReason returnReason);

    /**
     * 分页获取退货原因
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<OmsOrderReturnReason> listPage(Integer pageSize, Integer pageNum);

    /**
     * 获取单个退货原因
     * @param id
     * @return
     */
    OmsOrderReturnReason getItem(Long id);

    /**
     * 批量修改原因状态
     * @param ids
     * @param status
     * @return
     */
    int update(List<Long> ids, Integer status);
}
