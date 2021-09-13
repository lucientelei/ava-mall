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

import java.util.Date;

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
                QueueEnum.QUEUE_TTL_ORDER_CANCEL.getRouteKey(), orderId,
                new MessagePostProcessor() {
                    @Override
                    public Message postProcessMessage(Message message) throws AmqpException {
                        //给消息设置延时毫秒值
                        message.getMessageProperties().setExpiration(String.valueOf(delayTimes));
                        return message;
                    }
                });
        Date date = new Date(delayTimes);
        long hour = delayTimes/(60*60*1000);
        long minute = (delayTimes - hour*60*60*1000)/(60*1000);
        long second = (delayTimes - hour*60*60*1000 - minute*60*1000)/1000;
        System.out.println(hour+ "时" + minute + "分 " + second+"秒");
        log.info("发送订单延迟消息，订单号:{}", orderId);
    }

}
