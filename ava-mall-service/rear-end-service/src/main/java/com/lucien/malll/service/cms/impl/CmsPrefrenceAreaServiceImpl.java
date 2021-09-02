package com.lucien.malll.service.cms.impl;

import com.lucien.mall.mapper.CmsPrefrenceAreaMapper;
import com.lucien.mall.pojo.CmsPrefrenceArea;
import com.lucien.mall.pojo.CmsPrefrenceAreaExample;
import com.lucien.malll.service.cms.CmsPrefrenceAreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/2
 * 商品优选管理Impl
 */
@Service
public class CmsPrefrenceAreaServiceImpl implements CmsPrefrenceAreaService {

    @Autowired
    private CmsPrefrenceAreaMapper areaMapper;

    /**
     * 查询所有优选
     * @return
     */
    @Override
    public List<CmsPrefrenceArea> list() {
        return areaMapper.selectByExample(new CmsPrefrenceAreaExample());
    }
}
