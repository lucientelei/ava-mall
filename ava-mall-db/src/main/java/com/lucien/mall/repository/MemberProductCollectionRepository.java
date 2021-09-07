package com.lucien.mall.repository;

import com.lucien.mall.domain.MemberProductCollection;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 会员商品收藏
 */
public interface MemberProductCollectionRepository extends MongoRepository<MemberProductCollection, String> {

    /**
     * 通过用户ID和商品ID查询 收藏的商品
     * @param memberId
     * @param productId
     * @return
     */
    MemberProductCollection findByMemberIdAndProductId(Long memberId, Long productId);

    /**
     * 删除收藏
     * @param memberId
     * @param productId
     * @return
     */
    int deleteByMemberIdAndProductId(Long memberId,Long productId);

    /**
     * 分页获取会员收藏
     * @param memberId
     * @param pageable
     * @return
     */
    Page<MemberProductCollection> findByMemberId(Long memberId, Pageable pageable);

    /**
     * 根据用户ID删除全部收藏
     * @param memberId
     */
    void deleteAllByMemberId(Long memberId);
}
