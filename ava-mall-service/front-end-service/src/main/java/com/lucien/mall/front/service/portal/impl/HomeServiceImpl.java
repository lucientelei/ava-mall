package com.lucien.mall.front.service.portal.impl;


import com.github.pagehelper.PageHelper;
import com.lucien.mall.front.HomeContentResult;
import com.lucien.mall.front.service.portal.HomeService;
import com.lucien.mall.mapper.HomeMapper;
import com.lucien.mall.mapper.PmsProductCategoryMapper;
import com.lucien.mall.mapper.PmsProductMapper;
import com.lucien.mall.pojo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/6
 * 首页内容Impl
 */
@Primary
@Service
public class HomeServiceImpl implements HomeService {

    //首页内容自定义mapper
    @Autowired
    private HomeMapper homeMapper;

    @Autowired
    private PmsProductMapper productMapper;

    @Autowired
    private PmsProductCategoryMapper categoryMapper;



    /**
     * 获取首页内容
     */
    @Override
    public HomeContentResult content() {
        HomeContentResult result = new HomeContentResult();
         //推荐品牌
        result.setBrandList(homeMapper.getRecommendBrandList(0, 10));
         //新品推荐
        result.setNewProductList(homeMapper.getNewProductList(0, 8));
        //人气推荐
        result.setHotProductList(homeMapper.getHotProductList(0, 8));

        return result;
    }

    /**
     * 首页商品推荐
     */
    @Override
    public List<PmsProduct> recommendProductList(Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        PmsProductExample example = new PmsProductExample();
        example.createCriteria()
                .andDeleteStatusEqualTo(0)
                .andPublishStatusEqualTo(1);
        return productMapper.selectByExample(example);
    }

    /**
     * 获取商品分类
     *
     * @param parentId 0:获取一级分类；其他：获取指定二级分类
     */
    @Override
    public List<PmsProductCategory> getProductCateList(Long parentId) {
        PmsProductCategoryExample example = new PmsProductCategoryExample();
        example.createCriteria()
                .andShowStatusEqualTo(1)
                .andParentIdEqualTo(parentId);
        example.setOrderByClause("sort desc");
        return categoryMapper.selectByExample(example);
    }


    /**
     * 分页获取人气推荐商品
     */
    @Override
    public List<PmsProduct> hotProductList(Integer pageNum, Integer pageSize) {
        int offSet = pageSize * (pageNum - 1);
        return homeMapper.getHotProductList(offSet, pageSize);
    }

    /**
     * 分页获取新品推荐商品
     */
    @Override
    public List<PmsProduct> newProductList(Integer pageNum, Integer pageSize) {
        int offSet = pageSize * (pageNum - 1);
        return homeMapper.getNewProductList(offSet, pageSize);
    }
}
