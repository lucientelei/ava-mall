package com.lucien.mall.repository;

import com.lucien.mall.domain.MemberBrandAttention;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 会员关注
 */
public interface MemberBrandAttentionRepository extends MongoRepository<MemberBrandAttention,String> {

    MemberBrandAttention findByMemberIdAndBrandId(Long memberId, Long brandId);

    int deleteByMemberIdAndBrandId(Long memberId,Long brandId);

    Page<MemberBrandAttention> findByMemberId(Long memberId, Pageable pageable);

    void deleteAllByMemberId(Long memberId);
}
