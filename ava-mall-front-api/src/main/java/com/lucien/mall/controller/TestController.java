package com.lucien.mall.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author Lucien
 * @Date 2021/9/12
 */
@RestController
public class TestController {

    @GetMapping("/test")
    public String Test(){
        return "test hhhh";
    }
}
