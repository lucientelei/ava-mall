package com.lucien.mall.search;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @Author Lucien
 * @Date 2021/9/7
 * springboot 2.3.x 对应elasticsearch 6.7.2
 */
@SpringBootApplication
@MapperScan("com.lucien.mall.search.*")
public class SearchApplication {
    public static void main(String[] args) {
        SpringApplication.run(SearchApplication.class, args);
    }
}
