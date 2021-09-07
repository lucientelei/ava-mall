package com.lucien.mall.front.service.impl.ums;

import com.lucien.mall.domain.MemberProductCollection;
import com.lucien.mall.front.service.ums.MemberProductCollectionService;
import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.pojo.UmsMember;
import com.lucien.mall.repository.MemberProductCollectionRepository;
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
 * 会员商品收藏Impl
 */
@Service
@Primary
public class MemberProductCollectionServiceImpl implements MemberProductCollectionService {

    @Autowired
    private MemberProductCollectionRepository collectionRepository;

    @Autowired
    private UmsMemberService memberService;

    /**
     * 添加收藏
     * @param productCollection
     * @return
     */
    @Override
    public int add(MemberProductCollection productCollection) {
        int count = 0;
        UmsMember member = memberService.getCurrentMember();
        productCollection.setMemberId(member.getId());
        productCollection.setMemberNickname(member.getNickname());
        productCollection.setMemberIcon(member.getIcon());
        productCollection.setCreateTime(new Date());
        MemberProductCollection findCollection = collectionRepository.findByMemberIdAndProductId(member.getId(), productCollection.getProductId());
        if (StringUtils.isEmpty(findCollection)){
            collectionRepository.save(productCollection);
            count = 1;
        }
        return count;
    }

    /**
     * 删除收藏
     * @param productId
     * @return
     */
    @Override
    public int delete(Long productId) {
        UmsMember member = memberService.getCurrentMember();
        return collectionRepository.deleteByMemberIdAndProductId(member.getId(), productId);
    }

    /**
     * 分页获取收藏
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public Page<MemberProductCollection> list(Integer pageNum, Integer pageSize) {
        UmsMember member = memberService.getCurrentMember();
        Pageable pageable = PageRequest.of(pageNum - 1, pageSize);
        return collectionRepository.findByMemberId(member.getId(), pageable);
    }

    /**
     * 查看收藏详情
     * @param productId
     * @return
     */
    @Override
    public MemberProductCollection detail(Long productId) {
        UmsMember member = memberService.getCurrentMember();
        return collectionRepository.findByMemberIdAndProductId(member.getId(), productId);
    }

    /**
     * 清空收藏列表
     */
    @Override
    public void clearAll() {
        UmsMember member = memberService.getCurrentMember();
        collectionRepository.deleteAllByMemberId(member.getId());
    }
}
