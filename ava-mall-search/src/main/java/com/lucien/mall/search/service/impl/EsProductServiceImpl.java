package com.lucien.mall.search.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.github.pagehelper.PageHelper;
import com.lucien.mall.search.mapper.EsProductMapper;
import com.lucien.mall.search.pojo.EsProduct;
import com.lucien.mall.search.pojo.EsProductRelatedInfo;
import com.lucien.mall.search.repository.EsProductRepository;
import com.lucien.mall.search.service.EsProductService;
import org.apache.lucene.search.TotalHits;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.text.Text;
import org.elasticsearch.common.unit.TimeValue;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
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
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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

    @Autowired
    private RestHighLevelClient esClient;

    /**
     * 初始化索引库
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
     * 添加商品到ES库
     * @return
     */
    @Override
    public int create() {
        int result = 0;
        List<EsProduct> allEsProductList = productMapper.getAllEsProductList(null);
        Iterable<EsProduct> esProductIterable = productRepository.saveAll(allEsProductList);
        Iterator<EsProduct> iterator = esProductIterable.iterator();
        while (iterator.hasNext()){
            result++;
            iterator.next();
        }
        return result;
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
        if (!CollUtil.isNotEmpty(ids)) {
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
     * 删除ES库中的所有数据
     */
    @Override
    public void delete() {
        productRepository.deleteAll();
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

    @Override
    public List<EsProduct> test(String keyWord, Integer pageNum, Integer pageSize) {
        List<EsProduct> result = new ArrayList<>();
        try {
            PageHelper.startPage(pageNum, pageSize);
            QueryBuilder builder =  QueryBuilders.multiMatchQuery(keyWord, "brandName","name","keywords","subTitle");
            //设置高亮字段
            HighlightBuilder highlightBuilder = new HighlightBuilder();
            highlightBuilder.field("brandName");
            highlightBuilder.field("name");
            highlightBuilder.field("keywords");
            highlightBuilder.field("subTitle");
            //<span style="color: #FF6B01"></span>
            highlightBuilder.preTags("<span style=\"color: #FF6B01\">");
            highlightBuilder.postTags("</span>");

            SearchRequest searchRequest = new SearchRequest("pms");
            SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
            sourceBuilder.query(builder);
            sourceBuilder.from(0);
            sourceBuilder.size(10);
            sourceBuilder.highlighter(highlightBuilder);
            sourceBuilder.timeout(new TimeValue(1000));
            searchRequest.source(sourceBuilder);

            SearchResponse response = null;
            response = esClient.search(searchRequest, RequestOptions.DEFAULT);
            SearchHits searchHits = response.getHits();
            TotalHits totalHits = searchHits.getTotalHits();

            SearchHit[] hits = searchHits.getHits();
            for (SearchHit hit : hits) {
                Map sourceAsMap = hit.getSourceAsMap();
                EsProduct esProduct = createEsProduct(sourceAsMap);
                //商品名称
                if (hit.getHighlightFields().get("name") != null){
                    Text[] texts = hit.getHighlightFields().get("name").getFragments();
                    String name = "";
                    for (Text text : texts) {
                        name += text;
                    }
                    esProduct.setName(name);
                }else {
                    esProduct.setName(String.valueOf(sourceAsMap.get("name")));
                }
                //品牌名称
                if (hit.getHighlightFields().get("brandName") != null){
                    Text[] texts = hit.getHighlightFields().get("brandName").getFragments();
                    String name = "";
                    for (Text text : texts) {
                        name += text;
                    }
                    esProduct.setBrandName(name);
                }else {
                    esProduct.setBrandName(String.valueOf(sourceAsMap.get("brandName")));
                }
                //关键词
                if (hit.getHighlightFields().get("keywords") != null){
                    Text[] texts = hit.getHighlightFields().get("keywords").getFragments();
                    String name = "";
                    for (Text text : texts) {
                        name += text;
                    }
                    esProduct.setKeywords(name);
                }else {
                    esProduct.setKeywords(String.valueOf(sourceAsMap.get("keywords")));
                }
                //副标题
                if (hit.getHighlightFields().get("subTitle") != null){
                    Text[] texts = hit.getHighlightFields().get("subTitle").getFragments();
                    String name = "";
                    for (Text text : texts) {
                        name += text;
                    }
                    esProduct.setSubTitle(name);
                }else {
                    esProduct.setSubTitle(String.valueOf(sourceAsMap.get("subTitle")));
                }
                result.add(esProduct);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }

    private EsProduct createEsProduct(Map sourceAsMap){
        EsProduct esProduct = new EsProduct();
        esProduct.setId(Long.valueOf(String.valueOf(sourceAsMap.get("id"))));
        esProduct.setProductSn(String.valueOf(sourceAsMap.get("productSn")));
        esProduct.setBrandId(Long.valueOf(String.valueOf(sourceAsMap.get("brandId"))));
        esProduct.setProductCategoryId(Long.valueOf(String.valueOf(sourceAsMap.get("productCategoryId"))));
        esProduct.setProductCategoryName(String.valueOf(sourceAsMap.get("productCategoryName")));
        esProduct.setPic(String.valueOf(sourceAsMap.get("pic")));
        esProduct.setPrice(BigDecimal.valueOf((Double) sourceAsMap.get("price")));
        esProduct.setSale((Integer) sourceAsMap.get("sale"));
        esProduct.setNewStatus((Integer) sourceAsMap.get("newStatus"));
        esProduct.setRecommandStatus((Integer) sourceAsMap.get("recommandStatus"));
        esProduct.setStock((Integer) sourceAsMap.get("stock"));
        esProduct.setSort((Integer) sourceAsMap.get("sort"));
        return esProduct;
    }
}
