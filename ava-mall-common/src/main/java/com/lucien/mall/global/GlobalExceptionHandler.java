package com.lucien.mall.global;

import com.lucien.mall.constant.HttpStatus;
import com.lucien.mall.global.error.MyException;
import com.lucien.mall.myEnum.ExceptionEnum;
import org.apache.shiro.authz.UnauthorizedException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * @Author Lucien
 * @Date 2023/8/26
 * 自定义异常处理
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(value = MyException.class)
    @ResponseBody
    public GlobalResult myExceptionHandler(HttpServletRequest req, MyException e){
        logger.error("发生业务异常！原因是：{}",e.getErrorMsg());
        return GlobalResult.error(e.getErrorMsg());
    }

    /**
     * 处理空指针的异常
     * @param req
     * @param e
     * @return
     */
    @ExceptionHandler(value =NullPointerException.class)
    @ResponseBody
    public GlobalResult exceptionHandler(HttpServletRequest req, NullPointerException e){
        logger.error("发生空指针异常！原因是:",e);
        return GlobalResult.error(400, String.valueOf(ExceptionEnum.BODY_NOT_MATCH));
    }

    /**
     * 权限异常处理
     * @param req
     * @param e
     * @return
     */
    @ExceptionHandler(value = UnauthorizedException.class)
    @ResponseBody
    public GlobalResult exceptionHandler(HttpServletRequest req, UnauthorizedException e){
        String message = e.getMessage();
        String[] split = message.split(" ");
        return GlobalResult.error(HttpStatus.UNAUTHORIZED,"您没有" + split[split.length - 1] + "角色");
    }

//    @ExceptionHandler(value = AvaMallException.class)
//    @ResponseBody
//    public GlobalResult exceptionHandler(HttpServletRequest req, AvaMallException e){
//        logger.error("发生异常！原因是:",e.getMsg());
//        return GlobalResult.error(500, String.valueOf(ExceptionEnum.BODY_NOT_MATCH));
//    }

    @ExceptionHandler(value =Exception.class)
    @ResponseBody
    public GlobalResult exceptionHandler(HttpServletRequest req, Exception e){
        logger.error("未知异常！原因是:",e);
        return GlobalResult.error(500, String.valueOf(ExceptionEnum.INTERNAL_SERVER_ERROR));
    }

}
