package com.lucien.mall.front.service.ums;

import com.lucien.mall.domain.MemberProductCollection;
import org.springframework.data.domain.Page;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * 会员商品收藏Service
 */
public interface MemberProductCollectionService {

    /**
     * 添加收藏
     * @param productCollection
     * @return
     */
    int add(MemberProductCollection productCollection);

    /**
     * 删除收藏
     * @param productId
     * @return
     */
    int delete(Long productId);

    /**
     * 分页获取收藏
     * @param pageNum
     * @param pageSize
     * @return
     */
    Page<MemberProductCollection> list(Integer pageNum, Integer pageSize);

    /**
     * 查看收藏详情
     * @param productId
     * @return
     */
    MemberProductCollection detail(Long productId);

    /**
     * 清空收藏列表
     */
    void clearAll();

}
