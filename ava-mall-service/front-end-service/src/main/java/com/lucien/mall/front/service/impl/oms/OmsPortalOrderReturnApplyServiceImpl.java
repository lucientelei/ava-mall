package com.lucien.mall.front.service.impl.oms;

import com.lucien.mall.front.OmsOrderReturnApplyParam;
import com.lucien.mall.front.service.oms.OmsPortalOrderReturnApplyService;
import com.lucien.mall.mapper.OmsOrderReturnApplyMapper;
import com.lucien.mall.pojo.OmsOrderReturnApply;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.util.Date;

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
        //申请状态：0->待处理；1->退货中；2->已完成；3->已拒绝
        returnApply.setStatus(0);
        return returnApplyMapper.insert(returnApply);
    }
}
