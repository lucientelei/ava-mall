package com.lucien.mall.front.service.rabbitmq;

import com.lucien.mall.front.service.oms.OmsPortalOrderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @Author Lucien
 * @Date 2023/9/8
 *  取消订单的消费者
 */
@Component
@RabbitListener(queues = "mall.order.cancel")
public class CancelOrderReceiver {

    private static final Logger log = LoggerFactory.getLogger(CancelOrderReceiver.class);

    @Autowired
    private OmsPortalOrderService portalOrderService;

    @RabbitHandler
    public void handle(Long orderId){
        int result = portalOrderService.cancelOrder(orderId);
        log.info("取消超时订单，订单号:{},操作结果:{}",orderId, result);
    }
}
