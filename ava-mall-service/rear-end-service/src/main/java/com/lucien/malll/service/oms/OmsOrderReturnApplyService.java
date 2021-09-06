package com.lucien.malll.service.oms;

import com.lucien.mall.rear.oms.OmsOrderReturnApplyResult;
import com.lucien.mall.rear.oms.OmsReturnApplyQueryParam;
import com.lucien.mall.rear.oms.OmsUpdateStatusParam;
import com.lucien.mall.pojo.OmsOrderReturnApply;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/2
 * 退货申请管理Service
 */
public interface OmsOrderReturnApplyService {

    /**
     * 获取指定申请信息
     * @param id
     * @return
     */
    OmsOrderReturnApplyResult getItem(Long id);

    /**
     * 更新申请信息状态
     * @param id
     * @param statusParam
     * @return
     */
    int updateStatus(Long id, OmsUpdateStatusParam statusParam);

    /**
     * 分页获取申请信息
     * @param queryParam
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<OmsOrderReturnApply> listPage(OmsReturnApplyQueryParam queryParam, Integer pageSize, Integer pageNum);

    /**
     * 批量删除申请
     * @param ids
     * @return
     */
    int del(List<Long> ids);
}
