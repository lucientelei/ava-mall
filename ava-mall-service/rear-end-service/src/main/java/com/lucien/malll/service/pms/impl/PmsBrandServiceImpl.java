package com.lucien.malll.service.pms.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.rear.pms.PmsBrandDto;
import com.lucien.mall.mapper.PmsBrandMapper;
import com.lucien.mall.pojo.PmsBrand;
import com.lucien.mall.pojo.PmsBrandExample;
import com.lucien.malll.service.pms.PmsBrandService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/8/31
 */
@Service
public class PmsBrandServiceImpl implements PmsBrandService {

    @Autowired
    private PmsBrandMapper brandMapper;

    /**
     * 添加品牌
     * @param pmsBrandDto
     * @return
     */
    @Override
    public int insert(PmsBrandDto pmsBrandDto) {
        PmsBrand pmsBrand = new PmsBrand();
        BeanUtils.copyProperties(pmsBrandDto, pmsBrand);
        if (StringUtils.isEmpty(pmsBrand.getFirstLetter())) {
            pmsBrand.setFirstLetter(pmsBrand.getName().substring(0, 1));
        }
        return brandMapper.insert(pmsBrand);
    }

    /**
     * 查看所有品牌
     * @return
     */
    @Override
    public List<PmsBrand> list() {
        return brandMapper.selectByExample(new PmsBrandExample());
    }

    /**
     * 更新品牌信息
     * @param id
     * @param pmsBrand
     * @return
     */
    @Override
    public int update(Long id, PmsBrand pmsBrand) {
        pmsBrand.setId(id);
        return brandMapper.updateByPrimaryKeySelective(pmsBrand);
    }

    /**
     * 删除品牌信息
     * @param id
     * @return
     */
    @Override
    public int del(Long id) {
        return brandMapper.deleteByPrimaryKey(id);
    }

    /**
     * 分页获取品牌
     * @param keyword
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public List<PmsBrand> listBrand(String keyword, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        PmsBrandExample example = new PmsBrandExample();
        example.setOrderByClause("id asc");
        PmsBrandExample.Criteria criteria = example.createCriteria();
        if (!StringUtils.isEmpty(keyword)){
            criteria.andNameLike('%' + keyword + '%');
        }
        return brandMapper.selectByExample(example);
    }

    /**
     * 获取品牌详情
     * @param id
     * @return
     */
    @Override
    public PmsBrand getItem(Long id) {
        return brandMapper.selectByPrimaryKey(id);
    }

    /**
     * 批量删除
     * @param ids
     * @return
     */
    @Override
    public int deleteBrand(List<Long> ids) {
        PmsBrandExample example = new PmsBrandExample();
        example.createCriteria().andIdIn(ids);
        return brandMapper.deleteByExample(example);
    }

    /**
     * 修改显示状态
     * @param ids
     * @param showStatus
     * @return
     */
    @Override
    public int updateShowStatus(List<Long> ids, Integer showStatus) {
        PmsBrand pmsBrand = new PmsBrand();
        pmsBrand.setShowStatus(showStatus);
        PmsBrandExample example = new PmsBrandExample();
        example.createCriteria().andIdIn(ids);
        return brandMapper.updateByExampleSelective(pmsBrand, example);
    }

    /**
     * 修改厂家制造商状态
     * @param ids
     * @param factoryStatus
     * @return
     */
    @Override
    public int updateFactoryStatus(List<Long> ids, Integer factoryStatus) {
        PmsBrand pmsBrand = new PmsBrand();
        pmsBrand.setFactoryStatus(factoryStatus);
        PmsBrandExample example = new PmsBrandExample();
        example.createCriteria().andIdIn(ids);
        return brandMapper.updateByExampleSelective(pmsBrand, example);
    }
}
