package com.lucien.malll.service.cms;

import com.lucien.mall.pojo.CmsPrefrenceArea;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/2
 * 商品优选管理Service
 */
public interface CmsPrefrenceAreaService {

    /**
     * 查询所有优选
     * @return
     */
    List<CmsPrefrenceArea> list();
}
