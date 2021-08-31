package com.lucien.mall.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * @Author Lucien
 * @Date 2021/8/22
 */
@Configuration
@MapperScan(basePackages = "com.lucien.mall.**")
@ComponentScan({"com.lucien"})
public class ApplicationConfig {

}
