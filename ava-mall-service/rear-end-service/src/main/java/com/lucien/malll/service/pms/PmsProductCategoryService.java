package com.lucien.malll.service.pms;

import com.lucien.mall.dto.pms.PmsProductCategoryParam;
import com.lucien.mall.dto.pms.PmsProductCategoryWithChildrenItem;
import com.lucien.mall.pojo.PmsProductCategory;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/1
 * 后台商品分类管理service
 */
public interface PmsProductCategoryService {

    /**
     * 新增分类
     * @param param
     * @return
     */
    int insert(PmsProductCategoryParam param);

    /**
     * 分页获取商品分类
     * @param parentId
     * @param pageSize
     * @param pageNum
     * @return
     */
    List<PmsProductCategory> listPage(Long parentId, Integer pageSize, Integer pageNum);

    /**
     * 更新商品分类
     * @param id
     * @param param
     * @return
     */
    int update(Long id, PmsProductCategoryParam param);

    /**
     * 删除商品分类
     * @param id
     * @return
     */
    int delete(Long id);

    /**
     * 获取商品分类
     * @param id
     * @return
     */
    PmsProductCategory getItem(Long id);

    /**
     * 批量修改导航状态
     * @param ids
     * @param navStatus
     * @return
     */
    int updateNavStatus(List<Long> ids, Integer navStatus);

    /**
     * 批量修改显示状态
     * @param ids
     * @param showStatus
     * @return
     */
    int updateShowStatus(List<Long> ids, Integer showStatus);

    /**
     * 以层级形式获取商品分类
     * @return
     */
    List<PmsProductCategoryWithChildrenItem> listWithChildren();
}
