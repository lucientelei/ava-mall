package com.lucien.malll.service.pms.impl;

import com.lucien.mall.mapper.PmsSkuStockMapper;
import com.lucien.mall.pojo.PmsSkuStock;
import com.lucien.mall.pojo.PmsSkuStockExample;
import com.lucien.malll.service.pms.PmsSkuStockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/1
 * 商品库存管理Impl
 */
@Service
public class PmsSkuStockServiceImpl implements PmsSkuStockService {

    @Autowired
    private PmsSkuStockMapper stockMapper;

    /**
     * 根据产品Id和skuCode搜索
     * @param id
     * @param keyWord
     * @return
     */
    @Override
    public List<PmsSkuStock> list(Long id, String keyWord) {
        PmsSkuStockExample example = new PmsSkuStockExample();
        PmsSkuStockExample.Criteria criteria = example.createCriteria().andProductIdEqualTo(id);
        if (!StringUtils.isEmpty(keyWord)){
            criteria.andSkuCodeLike('%' + keyWord + '%');
        }
        return stockMapper.selectByExample(example);
    }

    /**
     * 批量更新商品库存信息
     * @param pid
     * @param skuStockList
     * @return
     */
    @Override
    public int update(Long pid, List<PmsSkuStock> skuStockList) {
        return stockMapper.replaceList(skuStockList);
    }
}
