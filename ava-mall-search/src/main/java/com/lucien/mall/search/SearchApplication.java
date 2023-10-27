package com.lucien.mall.search;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.Environment;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * @Author Lucien
 * @Date 2023/9/7
 * springboot 2.3.x 对应elasticsearch 6.7.2
 */
@SpringBootApplication
@MapperScan("com.lucien.mall.search.*")
public class SearchApplication {

    private static Logger logger = LoggerFactory.getLogger(SearchApplication.class);

    public static void main(String[] args) throws UnknownHostException {
        ConfigurableApplicationContext application = SpringApplication.run(SearchApplication.class, args);

        Environment env = application.getEnvironment();
        String active = env.getProperty("spring.profiles.active");
        if ("prod".equals(active)) {
            logger.info("\n----------------------------------------------------------\n\t" +
                            "Application '{}' is running! Access URLs:\n\t" +
                            "Local: \t\thttp://localhost:{}\n\t" +
                            "External: \thttp://{}:{}\n\t" +
                            "----------------------------------------------------------",
                    env.getProperty("spring.application.name"),
                    env.getProperty("server.port"),
                    InetAddress.getLocalHost().getHostAddress(),
                    env.getProperty("server.port"));
        } else {
            logger.info("\n----------------------------------------------------------\n\t" +
                            "Application '{}' is running! Access URLs:\n\t" +
                            "Local: \t\thttp://localhost:{}\n\t" +
                            "External: \thttp://{}:{}\n\t" +
                            "Swagger: \thttp://localhost:{}/swagger-ui.html\n\t" +
                            "Druid: \t\thttp://localhost:{}/druid/index.html\n" +
                            "----------------------------------------------------------",
                    env.getProperty("spring.application.name"),
                    env.getProperty("server.port"),
                    InetAddress.getLocalHost().getHostAddress(),
                    env.getProperty("server.port"),
                    env.getProperty("server.port"),
                    env.getProperty("server.port"));
        }
    }
}
