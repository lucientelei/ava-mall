package com.lucien.malll.service.pms.impl;

import cn.hutool.core.collection.CollUtil;
import com.github.pagehelper.PageHelper;
import com.lucien.mall.rear.pms.PmsProductParam;
import com.lucien.mall.rear.pms.PmsProductQueryParam;
import com.lucien.mall.rear.pms.PmsProductResult;
import com.lucien.mall.mapper.*;
import com.lucien.mall.pojo.*;
import com.lucien.malll.service.pms.PmsProductService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author Lucien
 * @Date 2023/9/1
 * 商品管理Impl
 */
@Service
public class PmsProductServiceImpl implements PmsProductService {

    private static final Logger log = LoggerFactory.getLogger(PmsProductServiceImpl.class);

    //商品表
    @Autowired
    private PmsProductMapper productMapper;

    //商品SKU表 库存量
    @Autowired
    private PmsSkuStockMapper stockMapper;

    /**
     * 建立和插入关系表操作
     *
     * @param mapper    可操作的mapper
     * @param dataList  插入的数据
     * @param productId 建立关系的ID
     *                  invoke通过反射包下的Method类调用invoke方法
     */
    private void relateAndInsertList(Object mapper, List dataList, Long productId) {
        try {
            if (CollectionUtils.isEmpty(dataList)) {
                return;
            }
            for (Object item : dataList) {
                Method setId = item.getClass().getMethod("setId", Long.class);
                setId.invoke(item, (Long) null);
                Method setProductId = item.getClass().getMethod("setProductId", Long.class);
                setProductId.invoke(item, productId);
            }
            Method insertList = mapper.getClass().getMethod("insertList", List.class);
            insertList.invoke(mapper, dataList);

        } catch (Exception e) {
            log.warn("创建产品出错:{}", e.getMessage());
            throw new RuntimeException(e.getMessage());
        }
    }

    /**
     * 处理sku的编码
     *
     * @param skuStockList
     * @param productId
     */
    private void handleSkuStockCode(List<PmsSkuStock> skuStockList, Long productId) {
        if (CollectionUtils.isEmpty(skuStockList)) {
            return;
        }
        for (int i = 0; i < skuStockList.size(); i++) {
            PmsSkuStock skuStock = skuStockList.get(i);
            if (StringUtils.isEmpty(skuStock.getSkuCode())) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
                StringBuilder sb = new StringBuilder();
                //日期
                sb.append(sdf.format(new Date()));
                //四位商品id
                sb.append(String.format("%04d", productId));
                //三位索引id
                sb.append(String.format("%03d", i + 1));
                skuStock.setSkuCode(sb.toString());
            }
        }
    }

    /**
     * 修改sku库存信息
     *
     * @param id
     * @param productParam
     */
    private void handleUpdateSkuStockList(Long id, PmsProductParam productParam) {
        //当前的sku信息
        List<PmsSkuStock> currSkuList = productParam.getSkuStockList();
        //当前没有sku直接删除
        if (CollUtil.isEmpty(currSkuList)) {
            PmsSkuStockExample skuStockExample = new PmsSkuStockExample();
            skuStockExample.createCriteria().andProductIdEqualTo(id);
            stockMapper.deleteByExample(skuStockExample);
            return;
        }
        //获取初始sku信息
        PmsSkuStockExample skuStockExample = new PmsSkuStockExample();
        skuStockExample.createCriteria().andProductIdEqualTo(id);
        List<PmsSkuStock> oriStuList = stockMapper.selectByExample(skuStockExample);
        //获取新增sku信息
        List<PmsSkuStock> insertSkuList = currSkuList.stream().filter(item -> item.getId() == null).collect(Collectors.toList());
        //获取需要更新的sku信息
        List<PmsSkuStock> updateSkuList = currSkuList.stream().filter(item -> item.getId() != null).collect(Collectors.toList());
        List<Long> updateSkuIds = updateSkuList.stream().map(PmsSkuStock::getId).collect(Collectors.toList());
        //获取需要删除的sku信息
        List<PmsSkuStock> removeSkuList = oriStuList.stream().filter(item -> !updateSkuIds.contains(item.getId())).collect(Collectors.toList());
        handleSkuStockCode(insertSkuList, id);
        handleSkuStockCode(updateSkuList, id);
        //新增sku
        if (CollUtil.isNotEmpty(insertSkuList)) {
            relateAndInsertList(stockMapper, insertSkuList, id);
        }
        //删除sku
        if (CollUtil.isNotEmpty(removeSkuList)) {
            List<Long> removeSkuIds = removeSkuList.stream().map(PmsSkuStock::getId).collect(Collectors.toList());
            PmsSkuStockExample removeExample = new PmsSkuStockExample();
            removeExample.createCriteria().andIdIn(removeSkuIds);
            stockMapper.deleteByExample(removeExample);
        }
        //修改sku
        if (CollUtil.isNotEmpty(updateSkuList)) {
            for (PmsSkuStock pmsSkuStock : updateSkuList) {
                stockMapper.updateByPrimaryKeySelective(pmsSkuStock);
            }
        }

    }


    /**
     * 新增商品
     *
     * @param param
     * @return
     */
    @Override
    public int insert(PmsProductParam param) {
        int count;
        PmsProduct product = param;
        product.setId(null);
        productMapper.insertSelective(product);

        Long productId = product.getId();
        //处理sku的编码
        handleSkuStockCode(param.getSkuStockList(), productId);
        //商品SKU表
        relateAndInsertList(stockMapper, param.getSkuStockList(), productId);
        count = 1;

        return count;
    }

    /**
     * 根据商品编号获取更新信息
     *
     * @param id
     * @return
     */
    @Override
    public PmsProductResult getUpdateInfo(Long id) {
        return productMapper.getUpdateInfo(id);
    }

    /**
     * 分页查询商品
     *
     * @param productQueryParam
     * @param pageSize
     * @param pageNum
     * @return
     */
    @Override
    public List<PmsProduct> list(PmsProductQueryParam productQueryParam, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        PmsProductExample example = new PmsProductExample();
        PmsProductExample.Criteria criteria = example.createCriteria();
        criteria.andDeleteStatusEqualTo(0);
        if (productQueryParam.getPublishStatus() != null) {
            criteria.andPublishStatusEqualTo(productQueryParam.getPublishStatus());
        }
        if (productQueryParam.getVerifyStatus() != null) {
            criteria.andVerifyStatusEqualTo(productQueryParam.getVerifyStatus());
        }
        if (!StringUtils.isEmpty(productQueryParam.getKeyword())) {
            criteria.andNameLike('%' + productQueryParam.getKeyword() + '%');
        }
        if (!StringUtils.isEmpty(productQueryParam.getProductSn())) {
            criteria.andProductSnEqualTo(productQueryParam.getProductSn());
        }
        if (productQueryParam.getProductCategoryId() != null) {
            criteria.andProductCategoryIdEqualTo(productQueryParam.getProductCategoryId());
        }
        if (productQueryParam.getBrandId() != null) {
            criteria.andBrandIdEqualTo(productQueryParam.getBrandId());
        }
//        System.out.println("执行搜索成功");
        return productMapper.selectByExample(example);
    }

    /**
     * 批量修改商品审核状态
     *
     * @param ids
     * @param verifyStatus
     * @param detail
     * @return
     */
    @Override
    public int updateVerifyStatus(List<Long> ids, Integer verifyStatus, String detail) {
        PmsProduct pmsProduct = new PmsProduct();
        pmsProduct.setVerifyStatus(verifyStatus);
        PmsProductExample example = new PmsProductExample();
        example.createCriteria().andIdIn(ids);

        List<PmsProductVertifyRecord> list = new ArrayList<>();
        int count = productMapper.updateByExampleSelective(pmsProduct, example);
        for (Long id : ids) {
            PmsProductVertifyRecord record = new PmsProductVertifyRecord();
            record.setProductId(id);
            record.setCreateTime(new Date());
            record.setDetail(detail);
            record.setStatus(verifyStatus);
            record.setVertifyMan("Admin");
            list.add(record);
        }
        return count;
    }

    /**
     * 批量修改商品上架状态
     *
     * @param ids
     * @param publishStatus
     * @return
     */
    @Override
    public int updatePublishStatus(List<Long> ids, Integer publishStatus) {
        PmsProduct product = new PmsProduct();
        product.setPublishStatus(publishStatus);
        PmsProductExample example = new PmsProductExample();
        example.createCriteria().andIdIn(ids);
        return productMapper.updateByExampleSelective(product, example);
    }

    /**
     * 批量修改商品推荐状态
     *
     * @param ids
     * @param commandStatus
     * @return
     */
    @Override
    public int updateRecommandStatus(List<Long> ids, Integer commandStatus) {
        PmsProduct product = new PmsProduct();
        product.setRecommandStatus(commandStatus);
        PmsProductExample example = new PmsProductExample();
        example.createCriteria().andIdIn(ids);
        return productMapper.updateByExampleSelective(product, example);
    }

    /**
     * 批量修改商品新品状态
     *
     * @param ids
     * @param newStatus
     * @return
     */
    @Override
    public int updateNewStatus(List<Long> ids, Integer newStatus) {
        PmsProduct product = new PmsProduct();
        product.setNewStatus(newStatus);
        PmsProductExample example = new PmsProductExample();
        example.createCriteria().andIdIn(ids);
        return productMapper.updateByExampleSelective(product, example);
    }

    /**
     * 批量修改商品删除状态
     *
     * @param ids
     * @param deleteStatus
     * @return
     */
    @Override
    public int updateDeleteStatus(List<Long> ids, Integer deleteStatus) {
        PmsProduct product = new PmsProduct();
        product.setNewStatus(deleteStatus);
        PmsProductExample example = new PmsProductExample();
        example.createCriteria().andIdIn(ids);
        return productMapper.updateByExampleSelective(product, example);
    }

    /**
     * 根据商品名称或货号模糊查询商品
     *
     * @param keyWord
     * @return
     */
    @Override
    public List<PmsProduct> list(String keyWord) {
        PmsProductExample example = new PmsProductExample();
        PmsProductExample.Criteria criteria = example.createCriteria();
        criteria.andDeleteStatusEqualTo(0);
        if (!StringUtils.isEmpty(keyWord)) {
            criteria.andNameLike('%' + keyWord + '%');
            example.or().andDeleteStatusEqualTo(0).andProductSnLike('%' + keyWord + '%');
        }
        return productMapper.selectByExample(example);
    }

    /**
     * 更新商品
     *
     * @param id
     * @param productParam
     * @return
     */
    @Override
    public int update(Long id, PmsProductParam productParam) {
        int count;
        PmsProduct product = productParam;
        product.setId(id);
        productMapper.updateByPrimaryKeySelective(product);
        //修改sku库存信息
        handleUpdateSkuStockList(id, productParam);
        count = 1;
        return count;
    }
}
