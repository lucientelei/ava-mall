package com.lucien.mall.front.service.impl;


import com.github.pagehelper.PageHelper;
import com.lucien.mall.front.FlashPromotionProduct;
import com.lucien.mall.front.HomeContentResult;
import com.lucien.mall.front.HomeFlashPromotion;
import com.lucien.mall.front.service.HomeService;
import com.lucien.mall.mapper.*;
import com.lucien.mall.pojo.*;
import com.lucien.mall.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/6
 * 首页内容Impl
 */
@Primary
@Service
public class HomeServiceImpl implements HomeService {

    //首页轮播广告
    @Autowired
    private SmsHomeAdvertiseMapper advertiseMapper;

    //首页内容自定义mapper
    @Autowired
    private HomeMapper homeMapper;

    //限时购表
    @Autowired
    private SmsFlashPromotionMapper promotionMapper;

    //限时购场次
    @Autowired
    private SmsFlashPromotionSessionMapper promotionSessionMapper;

    @Autowired
    private PmsProductMapper productMapper;

    @Autowired
    private PmsProductCategoryMapper categoryMapper;

    @Autowired
    private CmsSubjectMapper subjectMapper;

    /**
     * 获取首页广告
     *
     * @return
     */
    private List<SmsHomeAdvertise> getHomeAdvertise() {
        SmsHomeAdvertiseExample example = new SmsHomeAdvertiseExample();
        //status 上下线状态：0->下线；1->上线
        //type 轮播位置：0->PC首页轮播；1->app首页轮播
        example.createCriteria().andStatusEqualTo(1).andTypeEqualTo(1);
        example.setOrderByClause("sort desc");
        return advertiseMapper.selectByExample(example);
    }

    /**
     * 获取当前秒杀场次
     *
     * @return
     */
    private HomeFlashPromotion getHomeFlashPromotion() {
        HomeFlashPromotion promotion = new HomeFlashPromotion();
        //获取当前秒杀
        Date date = new Date();
        SmsFlashPromotion flashPromotion = getFlashPromotion(date);
        if (!StringUtils.isEmpty(flashPromotion)) {
            //当前秒杀场次
            SmsFlashPromotionSession flashPromotionSession = getFlashPromotionSession(date);
            if (!StringUtils.isEmpty(flashPromotionSession)) {
                promotion.setStartTime(flashPromotionSession.getStartTime());
                promotion.setEndTime(flashPromotionSession.getEndTime());
                //一下一个秒杀场次
                SmsFlashPromotionSession nextFlashPromotionSession = getNextFlashPromotionSession(promotion.getStartTime());
                if (!StringUtils.isEmpty(nextFlashPromotionSession)) {
                    promotion.setStartTime(nextFlashPromotionSession.getStartTime());
                    promotion.setEndTime(nextFlashPromotionSession.getEndTime());
                }
                //秒杀商品列表
                List<FlashPromotionProduct> flashProductList = homeMapper.getFlashProductList(flashPromotion.getId(), flashPromotionSession.getId());
                promotion.setProductList(flashProductList);
            }
        }
        return promotion;
    }

    /**
     * 根据时间获取秒杀活动
     *
     * @param date
     * @return
     */
    private SmsFlashPromotion getFlashPromotion(Date date) {
        Date currDate = DateUtil.getDate(date);
        SmsFlashPromotionExample example = new SmsFlashPromotionExample();
        example.createCriteria()
                .andStatusEqualTo(1)
                .andStartDateLessThanOrEqualTo(currDate)
                .andEndDateGreaterThanOrEqualTo(currDate);
        List<SmsFlashPromotion> flashPromotionList = promotionMapper.selectByExample(example);
        if (!CollectionUtils.isEmpty(flashPromotionList)) {
            return flashPromotionList.get(0);
        }
        return null;
    }

    /**
     * 根据时间获取秒杀场次
     *
     * @param date
     * @return
     */
    private SmsFlashPromotionSession getFlashPromotionSession(Date date) {
        Date currTime = DateUtil.getTime(date);
        SmsFlashPromotionSessionExample sessionExample = new SmsFlashPromotionSessionExample();
        sessionExample.createCriteria()
                .andStartTimeLessThanOrEqualTo(currTime)
                .andEndTimeGreaterThanOrEqualTo(currTime);
        List<SmsFlashPromotionSession> promotionSessionList = promotionSessionMapper.selectByExample(sessionExample);
        if (!CollectionUtils.isEmpty(promotionSessionList)) {
            return promotionSessionList.get(0);
        }
        return null;
    }

    /**
     * 获取下一个场次信息
     *
     * @param date
     * @return
     */
    private SmsFlashPromotionSession getNextFlashPromotionSession(Date date) {
        SmsFlashPromotionSessionExample sessionExample = new SmsFlashPromotionSessionExample();
        sessionExample.createCriteria()
                .andStartTimeGreaterThan(date);
        sessionExample.setOrderByClause("start_time asc");
        List<SmsFlashPromotionSession> promotionSessionList = promotionSessionMapper.selectByExample(sessionExample);
        if (!CollectionUtils.isEmpty(promotionSessionList)) {
            return promotionSessionList.get(0);
        }
        return null;
    }

    /**
     * 获取首页内容
     */
    @Override
    public HomeContentResult content() {
        HomeContentResult result = new HomeContentResult();
        //首页广告
        result.setAdvertiseList(getHomeAdvertise());
        //推荐品牌
        result.setBrandList(homeMapper.getRecommendBrandList(0, 6));
        //秒杀信息
        result.setHomeFlashPromotion(getHomeFlashPromotion());
        //新品推荐
        result.setNewProductList(homeMapper.getNewProductList(0, 4));
        //人气推荐
        result.setHotProductList(homeMapper.getHotProductList(0, 4));
        //推荐专题
        result.setSubjectList(homeMapper.getRecommendSubjectList(0, 4));

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
     * 根据专题分类分页获取专题
     *
     * @param cateId 专题分类id
     */
    @Override
    public List<CmsSubject> getSubjectList(Long cateId, Integer pageSize, Integer pageNum) {
        PageHelper.startPage(pageNum, pageSize);
        CmsSubjectExample example = new CmsSubjectExample();
        CmsSubjectExample.Criteria criteria = example.createCriteria();
        criteria.andShowStatusEqualTo(1);
        if (!StringUtils.isEmpty(cateId)){
            criteria.andCategoryIdEqualTo(cateId);
        }
        return subjectMapper.selectByExample(example);
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
