package com.lucien.mall.exception;

/**
 * @Author Lucien
 * @Date 2021/9/9
 * 自定义异常信息抛出类
 */
public class AvaMallException extends RuntimeException{

    private String msg;

    public AvaMallException(String msg){
        super(msg);
        this.msg = msg;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
