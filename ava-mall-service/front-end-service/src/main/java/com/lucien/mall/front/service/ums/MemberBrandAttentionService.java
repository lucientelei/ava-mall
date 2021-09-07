package com.lucien.mall.front.service.ums;

import com.lucien.mall.domain.MemberBrandAttention;
import org.springframework.data.domain.Page;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 会员关注列表Service
 */
public interface MemberBrandAttentionService {

    /**
     * 添加关注
     * @param brandAttention
     * @return
     */
    int add(MemberBrandAttention brandAttention);

    /**
     * 删除关注
     * @param brandId
     * @return
     */
    int delete(Long brandId);

    /**
     * 分页获取会员关注
     * @param pageNum
     * @param pageSize
     * @return
     */
    Page<MemberBrandAttention> list(Integer pageNum, Integer pageSize);

    /**
     * 获取关注详情
     * @param brandId
     * @return
     */
    MemberBrandAttention detail(Long brandId);

    /**
     * 清空关注列表
     */
    void clearAll();
}
