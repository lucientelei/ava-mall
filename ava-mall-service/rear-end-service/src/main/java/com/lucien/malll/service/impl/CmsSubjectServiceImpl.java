package com.lucien.malll.service.impl;

import com.github.pagehelper.PageHelper;
import com.lucien.mall.mapper.CmsSubjectMapper;
import com.lucien.mall.pojo.CmsSubject;
import com.lucien.mall.pojo.CmsSubjectExample;
import com.lucien.malll.service.CmsSubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 商品专题管理Impl
 */
@Service
public class CmsSubjectServiceImpl implements CmsSubjectService {

    @Autowired
    private CmsSubjectMapper subjectMapper;

    /**
     * 查询所有专题
     * @return
     */
    @Override
    public List<CmsSubject> list() {
        return subjectMapper.selectByExample(new CmsSubjectExample());
    }

    /**
     * 分页获取专题
     * @param keyWord
     * @param pageSize
     * @param pageNum
     * @return
     */
    @Override
    public List<CmsSubject> listPage(String keyWord, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        CmsSubjectExample example = new CmsSubjectExample();
        CmsSubjectExample.Criteria criteria = example.createCriteria();
        if (!StringUtils.isEmpty(keyWord)){
            criteria.andTitleLike('%' + keyWord + '%');
        }
        return subjectMapper.selectByExample(example);
    }
}
