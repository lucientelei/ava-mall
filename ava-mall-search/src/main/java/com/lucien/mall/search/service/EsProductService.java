package com.lucien.mall.search.service;

import com.lucien.mall.search.pojo.EsProduct;
import com.lucien.mall.search.pojo.EsProductRelatedInfo;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/7
 *  搜索商品管理Service
 */
public interface EsProductService {

    /**
     * 添加商品到ES库
     * @return
     */
    int create();

    /**
     *根据ID创建商品
     * @param id
     * @return
     */
    EsProduct create(Long id);

    /**
     * 根据ID删除商品
     * @param id
     */
    void delete(Long id);

    /**
     * 批量删除商品
     * @param ids
     * @return
     */
    void delete(List<Long> ids);

    /**
     * 删除ES库中的所有数据
     */
    void delete();

    /**
     *根据关键字搜索名称或者副标题
     * @param keyword
     * @param pageNum
     * @param pageSize
     * @return
     */
    Page<EsProduct> search(String keyword, Integer pageNum, Integer pageSize);

    /**
     *根据关键字搜索名称或者副标题复合查询
     * @param keyword
     * @param brandId
     * @param productCategoryId
     * @param pageNum
     * @param pageSize
     * @param sort
     * @return
     */
    Page<EsProduct> search(String keyword, Long brandId, Long productCategoryId, Integer pageNum, Integer pageSize, Integer sort);

    /**
     * 根据商品id推荐相关商品
     * @param id
     * @param pageNum
     * @param pageSize
     * @return
     */
    Page<EsProduct> recommend(Long id, Integer pageNum, Integer pageSize);

    /**
     * 获取搜索词相关品牌、分类、属性
     * @param keyword
     * @return
     */
    EsProductRelatedInfo searchRelatedInfo(String keyword);

    List<EsProduct> test(String keyWord, Integer pageNum, Integer pageSize);
}
