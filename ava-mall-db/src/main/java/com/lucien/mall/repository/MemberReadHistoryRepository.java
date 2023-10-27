package com.lucien.mall.repository;

import com.lucien.mall.domain.MemberReadHistory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;

/**
 * @Author Lucien
 * @Date 2023/9/7
 * 会员商品浏览历史Repository
 */
public interface MemberReadHistoryRepository extends MongoRepository<MemberReadHistory,String> {

    /**
     * 通过创建时间 降序查询会员浏览历史
     * @param memberId
     * @param pageable
     * @return
     */
    Page<MemberReadHistory> findByMemberIdOrderByCreateTimeDesc(Long memberId, Pageable pageable);

    /**
     * 清空浏览历史
     * @param memberId
     */
    void deleteAllByMemberId(Long memberId);

}
