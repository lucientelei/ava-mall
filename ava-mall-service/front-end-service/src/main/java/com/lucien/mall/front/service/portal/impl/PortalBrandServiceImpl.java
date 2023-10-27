package com.lucien.mall.front.service.portal.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.front.service.portal.PortalBrandService;
import com.lucien.mall.global.GlobalPage;
import com.lucien.mall.mapper.HomeMapper;
import com.lucien.mall.mapper.PmsBrandMapper;
import com.lucien.mall.mapper.PmsProductMapper;
import com.lucien.mall.pojo.PmsBrand;
import com.lucien.mall.pojo.PmsProduct;
import com.lucien.mall.pojo.PmsProductExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/7
 * 前台品牌Impl
 */
@Service
@Primary
public class PortalBrandServiceImpl implements PortalBrandService {

    @Autowired
    private HomeMapper homeMapper;

    @Autowired
    private PmsBrandMapper brandMapper;

    @Autowired
    private PmsProductMapper productMapper;

    /**
     * 分页获取推荐品牌
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public List<PmsBrand> recommendList(Integer pageNum, Integer pageSize) {
        int offSet = (pageNum - 1) * pageSize;
        return homeMapper.getRecommendBrandList(offSet, pageSize);
    }

    /**
     * 分页获取品牌关联商品
     * @param brandId
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public GlobalPage<PmsProduct> productList(Long brandId, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        PmsProductExample example = new PmsProductExample();
        example.createCriteria().andDeleteStatusEqualTo(0)
                .andBrandIdEqualTo(brandId);
        List<PmsProduct> productList = productMapper.selectByExample(example);
        return GlobalPage.restPage(productList);
    }

    /**
     * 获取品牌详情
     * @param brandId
     * @return
     */
    @Override
    public PmsBrand getItem(Long brandId) {
        return brandMapper.selectByPrimaryKey(brandId);
    }
}
