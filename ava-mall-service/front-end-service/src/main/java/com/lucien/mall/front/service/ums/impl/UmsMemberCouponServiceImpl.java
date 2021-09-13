package com.lucien.mall.front.service.ums.impl;

import cn.hutool.core.collection.CollUtil;
import com.lucien.mall.front.CartPromotionItem;
import com.lucien.mall.front.SmsCouponHistoryDetail;
import com.lucien.mall.front.service.ums.UmsMemberCouponService;
import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.mapper.*;
import com.lucien.mall.pojo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 用户优惠券Impl
 */
@Service
@Primary
public class UmsMemberCouponServiceImpl implements UmsMemberCouponService {

    @Autowired
    private UmsMemberService memberService;

    @Autowired
    private SmsCouponMapper couponMapper;

    @Autowired
    private SmsCouponHistoryMapper couponHistoryMapper;

    @Autowired
    private SmsCouponProductRelationMapper couponProductRelationMapper;

    @Autowired
    private SmsCouponProductCategoryRelationMapper couponProductCategoryRelationMapper;

    @Autowired
    private PmsProductMapper productMapper;

    /**
     * 添加优惠券
     *
     * @param couponId -1: 优惠券不存在
     *                 -2: 优惠券已经领完了
     *                 -3: 优惠券还没到领取时间
     *                 -4: 您已经领取过该优惠券
     */
    @Override
    public int add(Long couponId) {
        UmsMember umsMember = memberService.getCurrentMember();
        SmsCoupon smsCoupon = couponMapper.selectByPrimaryKey(couponId);
        if (StringUtils.isEmpty(smsCoupon)) {
            return -1;
        }
        if (smsCoupon.getCount() <= 0) {
            return -2;
        }
        Date now = new Date();
        if (StringUtils.isEmpty(smsCoupon.getEnableTime()) || now.before(smsCoupon.getEnableTime())) {
            return -3;
        }
        SmsCouponHistoryExample historyExample = new SmsCouponHistoryExample();
        historyExample.createCriteria().andCouponIdEqualTo(couponId).andMemberIdEqualTo(umsMember.getId());
        long count = couponHistoryMapper.countByExample(historyExample);
        if (count >= smsCoupon.getPerLimit()) {
            return -4;
        }

        //生成领取优惠券历史
        SmsCouponHistory couponHistory = new SmsCouponHistory();
        couponHistory.setCouponId(couponId);
        couponHistory.setCouponCode(generateCouponCode(umsMember.getId()));
        couponHistory.setCreateTime(now);
        couponHistory.setMemberId(umsMember.getId());
        couponHistory.setMemberNickname(umsMember.getNickname());
        //主动领取
        couponHistory.setGetType(1);
        //未使用
        couponHistory.setUseStatus(0);
        couponHistoryMapper.insert(couponHistory);
        //修改优惠券表的数量、领取数量
        smsCoupon.setCount(smsCoupon.getCount() - 1);
        smsCoupon.setReceiveCount(smsCoupon.getReceiveCount() == null ? 1 : smsCoupon.getReceiveCount() + 1);
        return couponMapper.updateByPrimaryKey(smsCoupon);
    }

    /**
     * 16位优惠码生成：时间戳后8位+4位随机数+用户id后4位
     */
    private String generateCouponCode(Long memberId) {
        StringBuilder sb = new StringBuilder();
        Long currentTimeMillis = System.currentTimeMillis();
        String timeMillisStr = currentTimeMillis.toString();
        sb.append(timeMillisStr.substring(timeMillisStr.length() - 8));
        for (int i = 0; i < 4; i++) {
            sb.append(new Random().nextInt(10));
        }
        String memberIdStr = memberId.toString();
        if (memberIdStr.length() <= 4) {
            sb.append(String.format("%04d", memberId));
        } else {
            sb.append(memberIdStr.substring(memberIdStr.length() - 4));
        }
        return sb.toString();
    }

    /**
     * 获取优惠券历史列表
     *
     * @param useStatus
     * @return
     */
    @Override
    public List<SmsCouponHistory> listHistory(Integer useStatus) {
        UmsMember member = memberService.getCurrentMember();
        SmsCouponHistoryExample example = new SmsCouponHistoryExample();
        SmsCouponHistoryExample.Criteria criteria = example.createCriteria();
        criteria.andMemberIdEqualTo(member.getId());
        if (!StringUtils.isEmpty(useStatus)) {
            criteria.andUseStatusEqualTo(useStatus);
        }
        return couponHistoryMapper.selectByExample(example);
    }

    /**
     * 获取用户优惠券列表
     *
     * @param useStatus
     * @return
     */
    @Override
    public List<SmsCoupon> listCoupon(Integer useStatus) {
        UmsMember member = memberService.getCurrentMember();
        return couponHistoryMapper.getCouponList(member.getId(), useStatus);
    }

    /**
     * 获取商品相关的优惠券
     *
     * @param productId
     * @return
     */
    @Override
    public List<SmsCoupon> listByProduct(Long productId) {
        List<Long> allCouponIds = new ArrayList<>();
        //获取指定商品优惠券
        SmsCouponProductRelationExample relationExample = new SmsCouponProductRelationExample();
        relationExample.createCriteria().andProductIdEqualTo(productId);
        List<SmsCouponProductRelation> relationList = couponProductRelationMapper.selectByExample(relationExample);
        if (CollUtil.isNotEmpty(relationList)) {
            List<Long> couponIds = relationList.stream().map(SmsCouponProductRelation::getCouponId).collect(Collectors.toList());
            allCouponIds.addAll(couponIds);
        }

        //获取指定分类优惠券
        PmsProduct pmsProduct = productMapper.selectByPrimaryKey(productId);
        SmsCouponProductCategoryRelationExample categoryRelationExample = new SmsCouponProductCategoryRelationExample();
        categoryRelationExample.createCriteria().andProductCategoryIdEqualTo(pmsProduct.getProductCategoryId());
        List<SmsCouponProductCategoryRelation> categoryRelationList = couponProductCategoryRelationMapper.selectByExample(categoryRelationExample);
        if (CollUtil.isNotEmpty(categoryRelationList)) {
            List<Long> couponIds = categoryRelationList.stream().map(SmsCouponProductCategoryRelation::getCouponId).collect(Collectors.toList());
            allCouponIds.addAll(couponIds);
        }
        if (CollUtil.isEmpty(allCouponIds)) {
            return new ArrayList<>();
        }
        SmsCouponExample example = new SmsCouponExample();
        example.createCriteria().andEndTimeGreaterThan(new Date())
                .andStartTimeLessThan(new Date())
                .andUseTypeEqualTo(0);
        example.or(example.createCriteria()
                .andEndTimeGreaterThan(new Date())
                .andStartTimeLessThan(new Date())
                .andUseTypeNotEqualTo(0)
                .andIdIn(allCouponIds));
        return couponMapper.selectByExample(example);
    }

    /**
     * 根据购物车信息 获取优惠券信息
     *
     * @param cartItemList
     * @param type
     * @return
     */
    @Override
    public List<SmsCouponHistoryDetail> listCart(List<CartPromotionItem> cartItemList, Integer type) {
        UmsMember member = memberService.getCurrentMember();
        Date now = new Date();
        List<SmsCouponHistoryDetail> allList = couponHistoryMapper.getDetailList(member.getId());
        //根据优惠券使用类型来判断优惠券是否可用
        List<SmsCouponHistoryDetail> enableList = new ArrayList<>();
        List<SmsCouponHistoryDetail> disableList = new ArrayList<>();
        for (SmsCouponHistoryDetail historyDetail : allList) {
            Integer useType = historyDetail.getCoupon().getUseType();
            BigDecimal minPoint = historyDetail.getCoupon().getMinPoint();
            Date endTime = historyDetail.getCoupon().getEndTime();
            if (useType.equals(0)) {
                //0->全场通用 判断是否满足优惠起点 计算购物车商品的总价
                BigDecimal totalAmount = calcTotalAmount(cartItemList);
                if (now.before(endTime) && totalAmount.subtract(minPoint).intValue() >= 0) {
                    enableList.add(historyDetail);
                } else {
                    disableList.add(historyDetail);
                }
            } else if (useType.equals(1)) {
                //1->指定分类 计算指定分类商品的总价
                List<Long> productCategoryIds = new ArrayList<>();
                for (SmsCouponProductCategoryRelation categoryRelation : historyDetail.getCategoryRelationList()) {
                    productCategoryIds.add(categoryRelation.getProductCategoryId());
                }
                BigDecimal totalAmount = calcTotalAmountByproductCategoryId(cartItemList, productCategoryIds);
                if (now.before(endTime) && totalAmount.intValue() > 0 && totalAmount.subtract(minPoint).intValue() >= 0) {
                    enableList.add(historyDetail);
                } else {
                    disableList.add(historyDetail);
                }
            } else if (useType.equals(2)) {
                //2->指定商品 计算指定商品的总价
                List<Long> productIds = new ArrayList<>();
                for (SmsCouponProductRelation productRelation : historyDetail.getProductRelationList()) {
                    productIds.add(productRelation.getProductId());
                }
                BigDecimal totalAmount = calcTotalAmountByProductId(cartItemList, productIds);
                if (now.before(endTime) && totalAmount.intValue() > 0 && totalAmount.subtract(minPoint).intValue() >= 0) {
                    enableList.add(historyDetail);
                } else {
                    disableList.add(historyDetail);
                }
            }
        }
        if (type.equals(1)) {
            return enableList;
        } else {
            return disableList;
        }

    }

    //计算购物车总价格
    private BigDecimal calcTotalAmount(List<CartPromotionItem> cartItemList) {
        BigDecimal total = new BigDecimal("0");
        for (CartPromotionItem item : cartItemList) {
            BigDecimal realPrice = item.getPrice().subtract(item.getReduceAmount());
            total = total.add(realPrice.multiply(new BigDecimal(item.getQuantity())));
        }
        return total;
    }

    //通过商品分类id计算总价
    private BigDecimal calcTotalAmountByproductCategoryId(List<CartPromotionItem> cartItemList, List<Long> productCategoryIds) {
        BigDecimal total = new BigDecimal("0");
        for (CartPromotionItem item : cartItemList) {
            if (productCategoryIds.contains(item.getProductCategoryId())) {
                BigDecimal realPrice = item.getPrice().subtract(item.getReduceAmount());
                total = total.add(realPrice.multiply(new BigDecimal(item.getQuantity())));
            }
        }
        return total;
    }

    //通过商品id计算总价
    private BigDecimal calcTotalAmountByProductId(List<CartPromotionItem> cartItemList, List<Long> productIds) {
        BigDecimal total = new BigDecimal("0");
        for (CartPromotionItem item : cartItemList) {
            if (productIds.contains(item.getProductId())) {
                BigDecimal realPrice = item.getPrice().subtract(item.getReduceAmount());
                total = total.add(realPrice.multiply(new BigDecimal(item.getQuantity())));
            }
        }
        return total;
    }
}
