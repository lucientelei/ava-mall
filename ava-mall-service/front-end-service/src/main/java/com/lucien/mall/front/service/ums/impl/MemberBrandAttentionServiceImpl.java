package com.lucien.mall.front.service.ums.impl;

import com.lucien.mall.domain.MemberBrandAttention;
import com.lucien.mall.front.service.ums.MemberBrandAttentionService;
import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.pojo.UmsMember;
import com.lucien.mall.repository.MemberBrandAttentionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 会员关注列表Impl
 */
@Service
@Primary
public class MemberBrandAttentionServiceImpl implements MemberBrandAttentionService {

    @Autowired
    private MemberBrandAttentionRepository brandAttentionRepository;

    @Autowired
    private UmsMemberService memberService;

    /**
     * 添加关注
     * @param brandAttention
     * @return
     */
    @Override
    public int add(MemberBrandAttention brandAttention) {
        int count = 0;
        UmsMember member = memberService.getCurrentMember();
        brandAttention.setMemberId(member.getId());
        brandAttention.setMemberNickname(member.getNickname());
        brandAttention.setMemberIcon(member.getIcon());
        brandAttention.setCreateTime(new Date());
        MemberBrandAttention findAttention = brandAttentionRepository.findByMemberIdAndBrandId(member.getId(), brandAttention.getBrandId());
        if (StringUtils.isEmpty(findAttention)){
            brandAttentionRepository.save(brandAttention);
            count = 1;
        }
        return count;
    }

    /**
     * 删除关注
     * @param brandId
     * @return
     */
    @Override
    public int delete(Long brandId) {
        UmsMember member = memberService.getCurrentMember();
        return brandAttentionRepository.deleteByMemberIdAndBrandId(member.getId(), brandId);
    }

    /**
     * 分页获取会员关注
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public Page<MemberBrandAttention> list(Integer pageNum, Integer pageSize) {
        UmsMember member = memberService.getCurrentMember();
        Pageable pageable = PageRequest.of(pageNum - 1, pageSize);
        return brandAttentionRepository.findByMemberId(member.getId(), pageable);
    }

    /**
     * 获取关注详情
     * @param brandId
     * @return
     */
    @Override
    public MemberBrandAttention detail(Long brandId) {
        UmsMember member = memberService.getCurrentMember();
        return brandAttentionRepository.findByMemberIdAndBrandId(member.getId(), brandId);
    }

    /**
     * 清空关注列表
     */
    @Override
    public void clearAll() {
        UmsMember member = memberService.getCurrentMember();
        brandAttentionRepository.deleteAllByMemberId(member.getId());
    }
}
