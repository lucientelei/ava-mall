package com.lucien.mall.search.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.lucien.mall.search.mapper.EsProductMapper;
import com.lucien.mall.search.pojo.EsProduct;
import com.lucien.mall.search.pojo.EsProductRelatedInfo;
import com.lucien.mall.search.repository.EsProductRepository;
import com.lucien.mall.search.service.EsProductService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchRestTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/7
 */
@Service
@Primary
public class EsProductServiceImpl implements EsProductService {

    private static final Logger log = LoggerFactory.getLogger(EsProductServiceImpl.class);

    @Autowired
    private EsProductRepository productRepository;

    @Autowired
    private EsProductMapper productMapper;

    @Autowired
    private ElasticsearchRestTemplate elasticsearchRestTemplate;

    /**
     * 导入商品到ES
     *
     * @return
     */
    @PostConstruct
    public void importProduct() {
        int result = 0;
        List<EsProduct> allEsProductList = productMapper.getAllEsProductList(null);
        Iterable<EsProduct> esProductIterable = productRepository.saveAll(allEsProductList);
        Iterator<EsProduct> iterator = esProductIterable.iterator();
        while (iterator.hasNext()){
            result++;
            iterator.next();
        }
        log.info("初始化ES索引库成功，添加数据：" + result + "条");
    }

    /**
     * 根据ID创建商品
     *
     * @param id
     * @return
     */
    @Override
    public EsProduct create(Long id) {
        EsProduct result = null;
        List<EsProduct> allEsProductList = productMapper.getAllEsProductList(id);
        if (CollUtil.isNotEmpty(allEsProductList)) {
            EsProduct esProduct = allEsProductList.get(0);
            result = productRepository.save(esProduct);
        }
        return result;
    }

    /**
     * 根据ID删除商品
     *
     * @param id
     */
    @Override
    public void delete(Long id) {
        productRepository.deleteById(id);
    }

    /**
     * 批量删除商品
     *
     * @param ids
     * @return
     */
    @Override
    public void delete(List<Long> ids) {
        if (CollUtil.isNotEmpty(ids)) {
            List<EsProduct> esProductList = new ArrayList<>();
            for (Long id : ids) {
                EsProduct esProduct = new EsProduct();
                esProduct.setId(id);
                esProductList.add(esProduct);
            }
            productRepository.saveAll(esProductList);
        }
    }

    /**
     * 根据关键字搜索名称或者副标题
     *
     * @param keyword
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public Page<EsProduct> search(String keyword, Integer pageNum, Integer pageSize) {
        Pageable pageable = PageRequest.of(pageNum, pageSize);
        return productRepository.findByNameOrSubTitleOrKeywords(keyword, keyword, keyword, pageable);}

    /**
     * 根据关键字搜索名称或者副标题复合查询
     *
     * @param keyword
     * @param brandId
     * @param productCategoryId
     * @param pageNum
     * @param pageSize
     * @param sort
     * @return
     */
    @Override
    public Page<EsProduct> search(String keyword, Long brandId, Long productCategoryId, Integer pageNum, Integer pageSize, Integer sort) {
        return null;
    }

    /**
     * 根据商品id推荐相关商品
     *
     * @param id
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public Page<EsProduct> recommend(Long id, Integer pageNum, Integer pageSize) {
        return null;
    }

    /**
     * 获取搜索词相关品牌、分类、属性
     *
     * @param keyword
     * @return
     */
    @Override
    public EsProductRelatedInfo searchRelatedInfo(String keyword) {
        return null;
    }
}
