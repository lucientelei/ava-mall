package com.lucien.mall.global.error;

/**
 * @Author Lucien
 * @Date 2023/8/26
 * 全局异常基础接口类
 */
public interface BaseErrorInfoInterface {

    /**
     *  错误码
     * @return
     */
    String getResultCode();

    /**
     * 错误描述
     * @return
     */
    String getResultMsg();

}
