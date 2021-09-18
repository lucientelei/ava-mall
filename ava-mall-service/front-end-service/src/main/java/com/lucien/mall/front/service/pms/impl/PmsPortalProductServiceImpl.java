package com.lucien.mall.front.service.pms.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.front.PmsPortalProductDetail;
import com.lucien.mall.front.PmsProductCategoryNode;
import com.lucien.mall.front.service.pms.PmsPortalProductService;
import com.lucien.mall.mapper.*;
import com.lucien.mall.pojo.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 前台商品Impl
 */
@Service
@Primary
public class PmsPortalProductServiceImpl implements PmsPortalProductService {

    @Autowired
    private PmsProductMapper productMapper;

    @Autowired
    private PmsProductCategoryMapper productCategoryMapper;

    @Autowired
    private PmsBrandMapper brandMapper;

    @Autowired
    private PmsSkuStockMapper skuStockMapper;

    @Autowired
    private PortalProductMapper portalProductMapper;

    /**
     * 综合搜索商品
     * @param keyword
     * @param brandId
     * @param productCategoryId
     * @param pageNum
     * @param pageSize
     * @param sort
     * @return
     */
    @Override
    public List<PmsProduct> search(String keyword, Long brandId, Long productCategoryId, Integer pageNum, Integer pageSize, Integer sort) {
        PageHelper.startPage(pageNum, pageSize);
        PmsProductExample example = new PmsProductExample();
        PmsProductExample.Criteria criteria = example.createCriteria();
        criteria.andDeleteStatusEqualTo(0);
        if (!StringUtils.isEmpty(keyword)){
            criteria.andNameLike('%' + keyword + '%');
        }
        if (!StringUtils.isEmpty(brandId)){
            criteria.andBrandIdEqualTo(brandId);
        }
        if (!StringUtils.isEmpty(productCategoryId)){
            criteria.andProductCategoryIdEqualTo(productCategoryId);
        }
        //1->按新品；2->按销量；3->价格从低到高；4->价格从高到低
        if (!StringUtils.isEmpty(sort)){
            if (sort == 1){
                example.setOrderByClause("id desc");
            }else if(sort == 2){
                example.setOrderByClause("sale desc");
            }else if (sort == 3){
                example.setOrderByClause("price asc");
            }else if(sort == 4){
                example.setOrderByClause("price desc");
            }
        }
        return productMapper.selectByExample(example);
    }

    /**
     * 以树形结构获取所有商品分类
     * @return
     */
    @Override
    public List<PmsProductCategoryNode> categoryTreeList() {
        PmsProductCategoryExample example = new PmsProductCategoryExample();
        List<PmsProductCategory> categoryList = productCategoryMapper.selectByExample(example);
        List<PmsProductCategoryNode> nodeList = categoryList.stream()
                .filter(item -> item.getParentId().equals(0L))
                .map(item -> covert(item, categoryList)).collect(Collectors.toList());
        return nodeList;
    }

    /**
     * 初始对象转化为节点对象
     * @param item
     * @param allList
     * @return
     */
    private PmsProductCategoryNode covert(PmsProductCategory item, List<PmsProductCategory> allList) {
        PmsProductCategoryNode node = new PmsProductCategoryNode();
        BeanUtils.copyProperties(item, node);
        List<PmsProductCategoryNode> children = allList.stream()
                .filter(subItem -> subItem.getParentId().equals(item.getId()))
                .map(subItem -> covert(subItem, allList)).collect(Collectors.toList());
        node.setChildren(children);
        return node;
    }

    /**
     * 获取商品详情
     * @param id
     * @return
     */
    @Override
    public PmsPortalProductDetail detail(Long id) {
        PmsPortalProductDetail productDetail = new PmsPortalProductDetail();
        //商品信息
        PmsProduct product = productMapper.selectByPrimaryKey(id);
        productDetail.setProduct(product);
        //商品品牌
        PmsBrand brand = brandMapper.selectByPrimaryKey(product.getBrandId());
        productDetail.setBrand(brand);

        //商品的sku库存信息
        PmsSkuStockExample skuStockExample = new PmsSkuStockExample();
        skuStockExample.createCriteria().andProductIdEqualTo(product.getId());
        List<PmsSkuStock> skuStockList = skuStockMapper.selectByExample(skuStockExample);
        productDetail.setSkuStockList(skuStockList);

        return productDetail;
    }
}
