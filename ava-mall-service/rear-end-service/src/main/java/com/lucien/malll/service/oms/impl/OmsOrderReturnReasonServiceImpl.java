package com.lucien.malll.service.oms.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.mapper.OmsOrderReturnReasonMapper;
import com.lucien.mall.pojo.OmsOrderReturnReason;
import com.lucien.mall.pojo.OmsOrderReturnReasonExample;
import com.lucien.malll.service.oms.OmsOrderReturnReasonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Lucie
 * @Date 2023/9/2
 * 退货原因管理Impl
 */
@Service
public class OmsOrderReturnReasonServiceImpl implements OmsOrderReturnReasonService {

    @Autowired
    private OmsOrderReturnReasonMapper reasonMapper;

    /**
     * 新增退货原因
     * @param returnReason
     * @return
     */
    @Override
    public int insert(OmsOrderReturnReason returnReason) {
        return reasonMapper.insert(returnReason);
    }

    /**
     * 批量删除退货原因
     * @param ids
     * @return
     */
    @Override
    public int del(List<Long> ids) {
        OmsOrderReturnReasonExample example = new OmsOrderReturnReasonExample();
        example.createCriteria().andIdIn(ids);
        return reasonMapper.deleteByExample(example);
    }

    /**
     * 修改退货原因
     * @param id
     * @param returnReason
     * @return
     */
    @Override
    public int update(Long id, OmsOrderReturnReason returnReason) {
        returnReason.setId(id);
        return reasonMapper.updateByPrimaryKey(returnReason);
    }

    /**
     * 分页获取退货原因
     * @param pageSize
     * @param pageNum
     * @return
     */
    @Override
    public List<OmsOrderReturnReason> listPage(Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        return reasonMapper.selectByExample(new OmsOrderReturnReasonExample());
    }

    /**
     * 获取单个退货原因
     * @param id
     * @return
     */
    @Override
    public OmsOrderReturnReason getItem(Long id) {
        return reasonMapper.selectByPrimaryKey(id);
    }

    /**
     * 批量修改原因状态
     * @param ids
     * @param status
     * @return
     */
    @Override
    public int update(List<Long> ids, Integer status) {
        OmsOrderReturnReason reason = new OmsOrderReturnReason();
        reason.setStatus(status);
        OmsOrderReturnReasonExample example = new OmsOrderReturnReasonExample();
        example.createCriteria().andIdIn(ids);
        return reasonMapper.updateByExampleSelective(reason, example);
    }
}
