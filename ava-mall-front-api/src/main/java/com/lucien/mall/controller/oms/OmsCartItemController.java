package com.lucien.mall.controller.oms;

import com.lucien.mall.front.CartProduct;
import com.lucien.mall.front.CartPromotionItem;
import com.lucien.mall.front.service.oms.OmsCartItemService;
import com.lucien.mall.front.service.ums.UmsMemberService;
import com.lucien.mall.global.GlobalResult;
import com.lucien.mall.pojo.OmsCartItem;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/6
 * 会员购物车管理
 */
@RestController
@RequestMapping("/oms")
@Api(tags = "OmsCartItemController", description = "会员购物车管理")
public class OmsCartItemController {

    @Autowired
    private OmsCartItemService cartItemService;

    @Autowired
    private UmsMemberService memberService;

    @PostMapping("/add/cart/item")
    @ApiOperation(value = "添加商品到购物车")
    public GlobalResult addCartItem(@RequestBody OmsCartItem cartItem){
        int result = cartItemService.add(cartItem);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @GetMapping("/list")
    @ApiOperation(value = "根据会员编号获取购物车列表")
    public GlobalResult<List<CartPromotionItem>> list(){
        List<OmsCartItem> result = cartItemService.list(memberService.getCurrentMember().getId());
        return GlobalResult.success(result);
    }

    @PostMapping("/update/quantity")
    @ApiOperation(value = "修改某个购物车商品的数量")
    public GlobalResult updateQuantity(@RequestParam Long id,
                                       @RequestParam Integer quantity){
        int result = cartItemService.updateQuantity(id, memberService.getCurrentMember().getId(), quantity);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @GetMapping("/get/cart/product/{productId}")
    @ApiOperation(value = "获取购物车中用于选择商品规格的商品信息")
    public GlobalResult<CartProduct> getCartProduct(@PathVariable("productId") Long productId){
        CartProduct result = cartItemService.getCartProduct(productId);
        if (!StringUtils.isEmpty(result)) {
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @PostMapping("/update/attr")
    @ApiOperation(value = "修改购物车中商品的规格")
    public GlobalResult updateAttr(@RequestBody OmsCartItem cartItem){
        int result = cartItemService.updateAttr(cartItem);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @DeleteMapping("/delete")
    @ApiOperation(value = "批量删除购物车中的商品")
    public GlobalResult delete(@RequestParam List<Long> ids){
        int result = cartItemService.delete(memberService.getCurrentMember().getId(), ids);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }

    @DeleteMapping("/clear/{memberId}")
    @ApiOperation(value = "清空购物车")
    public GlobalResult clear(@PathVariable("memberId") Long memberId){
        int result = cartItemService.clear(memberId);
        if (result > 0){
            return GlobalResult.success(result);
        }
        return GlobalResult.error(result);
    }
}
