package com.lucien.mall.front.service.ums;

import com.lucien.mall.domain.MemberReadHistory;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2023/9/7
 * 会员浏览记录管理Service
 */
public interface MemberReadHistoryService {

    /**
     * 生成浏览记录
     * @param memberReadHistory
     * @return
     */
    int insert(MemberReadHistory memberReadHistory);

    /**
     * 批量删除浏览记录
     * @param ids
     * @return
     */
    int delete(List<String> ids);

    /**
     *分页获取用户浏览记录
     * @param pageNum
     * @param pageSize
     * @return
     */
    Page<MemberReadHistory> list(Integer pageNum, Integer pageSize);

    /**
     * 清空浏览记录
     */
    void clear();

    /**
     *
     * @param ids
     * @return
     */
//    Iterable<MemberReadHistory> findAllById(Iterable<String> ids);
}
