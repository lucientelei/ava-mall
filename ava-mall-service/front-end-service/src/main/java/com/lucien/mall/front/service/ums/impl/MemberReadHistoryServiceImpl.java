package com.lucien.mall.front.service.ums.impl;

import com.lucien.mall.domain.MemberReadHistory;
import com.lucien.mall.front.service.ums.MemberReadHistoryService;
import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.pojo.UmsMember;
import com.lucien.mall.repository.MemberReadHistoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/7
 * 会员浏览记录管理Impl
 */
@Service
@Primary
public class MemberReadHistoryServiceImpl implements MemberReadHistoryService {

    @Autowired
    private MemberReadHistoryRepository readHistoryRepository;

    @Autowired
    private UmsMemberService memberService;

    /**
     * 生成浏览记录
     *
     * @param memberReadHistory
     * @return
     */
    @Override
    public int insert(MemberReadHistory memberReadHistory) {
        //商品重复标识
        boolean flag = false;
        List<MemberReadHistory> productHistoryList = readHistoryRepository.findAll();
        for (MemberReadHistory readHistory : productHistoryList) {
            if (readHistory.getProductId().equals(memberReadHistory.getProductId())){
                flag = true;
            }
        }
        if (!flag){
            UmsMember member = memberService.getCurrentMember();
            memberReadHistory.setMemberId(member.getId());
            memberReadHistory.setMemberNickname(member.getNickname());
            memberReadHistory.setMemberIcon(member.getIcon());
            memberReadHistory.setId(null);
            memberReadHistory.setCreateTime(new Date());
            //保存给定的实体
            readHistoryRepository.save(memberReadHistory);
        }
        return 1;
    }

    /**
     * 批量删除浏览记录
     *
     * @param ids
     * @return
     */
    @Override
    public int delete(List<String> ids) {
        List<MemberReadHistory> deleteList = new ArrayList<>();
        for (String id : ids) {
            MemberReadHistory history = new MemberReadHistory();
            history.setId(id);
            deleteList.add(history);
        }
        //删除给定的实体
        readHistoryRepository.deleteAll(deleteList);
        return 1;
    }

    /**
     * 分页获取用户浏览记录
     *
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public Page<MemberReadHistory> list(Integer pageNum, Integer pageSize) {
        UmsMember member = memberService.getCurrentMember();
        Pageable pageable = PageRequest.of(pageNum - 1, pageSize);
        return readHistoryRepository.findByMemberIdOrderByCreateTimeDesc(member.getId(), pageable);
    }

    /**
     * 清空浏览记录
     */
    @Override
    public void clear() {
        UmsMember member = memberService.getCurrentMember();
        readHistoryRepository.deleteAllByMemberId(member.getId());
    }
}
