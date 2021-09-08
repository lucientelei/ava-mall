package com.lucien.mall.front.service.rabbitmq;

import com.lucien.mall.myEnum.QueueEnum;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.AmqpException;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.core.MessagePostProcessor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @Author Lucien
 * @Date 2021/9/8
 * 取消订单消息的生产者
 */
@Component
public class CancelOrderSender {

    private static final Logger log = LoggerFactory.getLogger(CancelOrderSender.class);

    @Autowired
    private AmqpTemplate amqpTemplate;

    public void sendMsg(Long orderId, final long delayTimes){
        amqpTemplate.convertAndSend(QueueEnum.QUEUE_TTL_ORDER_CANCEL.getExchange(),
                QueueEnum.QUEUE_TTL_ORDER_CANCEL.getRouteKey(),
                orderId,
                new MessagePostProcessor() {
                    @Override
                    public Message postProcessMessage(Message message) throws AmqpException {
                        //给消息设置延时毫秒值
                        message.getMessageProperties().setExpiration(String.valueOf(delayTimes));
                        return message;
                    }
                });
        log.info("send orderId:{}",orderId);
    }

}
