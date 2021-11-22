package com.lucien.mall.front.service.oms.impl;

import com.lucien.mall.front.OmsOrderReturnApplyParam;
import com.lucien.mall.front.service.oms.OmsPortalOrderReturnApplyService;
import com.lucien.mall.front.service.oms.OmsPortalOrderService;
import com.lucien.mall.mapper.OmsOrderMapper;
import com.lucien.mall.mapper.OmsOrderReturnApplyMapper;
import com.lucien.mall.mapper.OmsOrderReturnReasonMapper;
import com.lucien.mall.pojo.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 前台退货申请Impl
 */
@Service
@Primary
public class OmsPortalOrderReturnApplyServiceImpl implements OmsPortalOrderReturnApplyService {

    @Autowired
    private OmsOrderReturnApplyMapper returnApplyMapper;

    @Autowired
    private OmsOrderReturnReasonMapper reasonMapper;

    @Autowired
    private OmsPortalOrderService orderService;

    @Autowired
    private OmsOrderMapper omsOrderMapper;

    /**
     * 提交申请
     * @param param
     * @return
     */
    @Override
    public int insert(OmsOrderReturnApplyParam param) {
        OmsOrderReturnApply returnApply = new OmsOrderReturnApply();
        BeanUtils.copyProperties(param, returnApply);
        returnApply.setCreateTime(new Date());
        //设置订单为退货状态
        orderService.updateOrderStatus(param.getOrderId(), 5);
        //申请状态：0->待处理；1->退货中；2->已完成；3->已拒绝
        returnApply.setStatus(0);
        return returnApplyMapper.insert(returnApply);
    }

    /**
     * 获取全部退货原因
     * @return
     */
    @Override
    public List<OmsOrderReturnReason> listReason() {
        return reasonMapper.selectByExample(new OmsOrderReturnReasonExample());
    }

    /**
     * 获取退货订单状态
     * @param orderId
     * @return
     */
    @Override
    public int applyStatus(Long orderId) {
        OmsOrderReturnApplyExample example = new OmsOrderReturnApplyExample();
        example.createCriteria().andOrderIdEqualTo(orderId);
        return returnApplyMapper.selectByExample(example).get(0).getStatus();
    }

    /**
     * 判断订单是否被删除
     * @param orderId
     * @return
     */
    @Override
    public boolean isOrderExit(Long orderId) {
        OmsOrder omsOrder = omsOrderMapper.selectByPrimaryKey(orderId);
        if (StringUtils.isEmpty(omsOrder)){
            return true;
        }
        return false;
    }
}
