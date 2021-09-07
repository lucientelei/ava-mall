package com.lucien.mall.controller.ums;

import com.lucien.mall.front.CartPromotionItem;
import com.lucien.mall.front.SmsCouponHistoryDetail;
import com.lucien.mall.front.service.oms.OmsCartItemService;
import com.lucien.mall.front.service.ums.UmsMemberCouponService;
import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.SmsCoupon;
import com.lucien.mall.pojo.SmsCouponHistory;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/7
 */
@RestController
@RequestMapping("/member/coupon")
@Api(tags = "UmsMemberCouponController", description = "用户优惠券管理")
public class UmsMemberCouponController {

    @Autowired
    private UmsMemberCouponService couponService;

    @Autowired
    private OmsCartItemService cartItemService;

    @Autowired
    private UmsMemberService memberService;

    @PostMapping("/add/{couponId}")
    @ApiOperation(value = "添加优惠券")
    public GlobalResult add(@PathVariable("couponId") Long couponId){
        int result = couponService.add(couponId);
        if (result == -1){
            return GlobalResult.error("优惠券不存在");
        }else if (result == -2){
            return GlobalResult.error("优惠券已经领完了");
        }else if (result == -3){
            return GlobalResult.error("优惠券还没到领取时间");
        }else if (result == -4){
            return GlobalResult.error("您已经领取过该优惠券");
        }
        return GlobalResult.success("领取成功");
    }

    @GetMapping("/list/history")
    @ApiOperation(value = "获取优惠券历史列表")
    @ApiImplicitParam(name = "useStatus", value = "优惠券筛选类型:0->未使用；1->已使用；2->已过期",
            allowableValues = "0,1,2", paramType = "query", dataType = "integer")
    public GlobalResult<List<SmsCouponHistory>> listHistory(@RequestParam(value = "useStatus", required = false) Integer useStatus){
        List<SmsCouponHistory> result = couponService.listHistory(useStatus);
        return GlobalResult.success(result);
    }

    @GetMapping("/list")
    @ApiOperation(value = "获取用户优惠券列表")
    @ApiImplicitParam(name = "useStatus", value = "优惠券筛选类型:0->未使用；1->已使用；2->已过期",
            allowableValues = "0,1,2", paramType = "query", dataType = "integer")
    public GlobalResult<List<SmsCoupon>> listCoupon(@RequestParam(value = "useStatus", required = false) Integer useStatus){
        List<SmsCoupon> result = couponService.listCoupon(useStatus);
        return GlobalResult.success(result);
    }

    @GetMapping("/list/cart")
    @ApiOperation(value = "获取登录会员购物车的相关优惠券")
    @ApiImplicitParam(name = "type", value = "使用可用:0->不可用；1->可用",
            defaultValue = "1", allowableValues = "0,1", paramType = "query", dataType = "integer")
    public GlobalResult<List<SmsCouponHistoryDetail>> listCart(@RequestParam Integer type){
        List<CartPromotionItem> promotionItems = cartItemService.listPromotion(memberService.getCurrentMember().getId(), null);
        List<SmsCouponHistoryDetail> result = couponService.listCart(promotionItems, type);
        return GlobalResult.success(result);
    }

    @GetMapping("/list/byproduct/{productId}")
    @ApiOperation(value = "获取当前商品相关优惠券")
    public GlobalResult<List<SmsCoupon>> listByProduct(@PathVariable Long productId){
        List<SmsCoupon> result = couponService.listByProduct(productId);
        return GlobalResult.success(result);
    }

}
