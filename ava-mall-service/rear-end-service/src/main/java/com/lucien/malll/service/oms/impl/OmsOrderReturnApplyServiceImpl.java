package com.lucien.malll.service.oms.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.dto.oms.OmsOrderReturnApplyResult;
import com.lucien.mall.dto.oms.OmsReturnApplyQueryParam;
import com.lucien.mall.dto.oms.OmsUpdateStatusParam;
import com.lucien.mall.mapper.OmsOrderReturnApplyMapper;
import com.lucien.mall.pojo.OmsOrderReturnApply;
import com.lucien.mall.pojo.OmsOrderReturnApplyExample;
import com.lucien.malll.service.oms.OmsOrderReturnApplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/2
 * 退货申请管理Impl
 */
@Service
public class OmsOrderReturnApplyServiceImpl implements OmsOrderReturnApplyService {

    @Autowired
    private OmsOrderReturnApplyMapper applyMapper;

    /**
     * 获取指定申请信息
     * @param id
     * @return
     */
    @Override
    public OmsOrderReturnApplyResult getItem(Long id) {
        return applyMapper.getDetail(id);
    }

    /**
     * 更新申请信息状态
     * @param id
     * @param statusParam
     * @return
     */
    @Override
    public int updateStatus(Long id, OmsUpdateStatusParam statusParam) {
        OmsOrderReturnApply returnApply = new OmsOrderReturnApply();
        Integer status = statusParam.getStatus();
        returnApply.setId(id);
        //申请状态：0->待处理；1->退货中；2->已完成；3->已拒绝
        if (status.equals(1)){
            returnApply.setStatus(1);
            returnApply.setReturnAmount(statusParam.getReturnAmount());
            returnApply.setCompanyAddressId(statusParam.getCompanyAddressId());
            returnApply.setHandleTime(new Date());
            returnApply.setHandleMan(statusParam.getHandleMan());
            returnApply.setHandleNote(statusParam.getHandleNote());
        }
        else if (status.equals(2)){
            returnApply.setStatus(2);
            returnApply.setHandleTime(new Date());
            returnApply.setHandleMan(statusParam.getHandleMan());
            returnApply.setHandleNote(statusParam.getHandleNote());
        }
        else if (status.equals(3)) {
            returnApply.setStatus(3);
            returnApply.setHandleTime(new Date());
            returnApply.setHandleMan(statusParam.getHandleMan());
            returnApply.setHandleNote(statusParam.getHandleNote());
        }else {
            return 0;
        }
        return applyMapper.updateByPrimaryKeySelective(returnApply);
    }

    /**
     * 分页获取申请信息
     * @param queryParam
     * @param pageSize
     * @param pageNum
     * @return
     */
    @Override
    public List<OmsOrderReturnApply> listPage(OmsReturnApplyQueryParam queryParam, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        return applyMapper.getList(queryParam);
    }

    /**
     * 批量删除申请
     * @param ids
     * @return
     */
    @Override
    public int del(List<Long> ids) {
        OmsOrderReturnApplyExample example = new OmsOrderReturnApplyExample();
        example.createCriteria().andIdIn(ids);
        return applyMapper.deleteByExample(example);
    }
}
