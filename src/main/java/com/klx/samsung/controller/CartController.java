package com.klx.samsung.controller;

import com.klx.samsung.domain.CartItem;
import com.klx.samsung.domain.Product;
import com.klx.samsung.service.CartItemService;
import com.klx.samsung.service.ProductService;
import com.klx.samsung.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/myCart")
public class CartController {

    @Autowired
    private CartItemService cartItemService;
    @Autowired
    private ProductService productService;
    @Autowired
    private UserService userService;

    /**
     * 查询当前登录用户的购物车
     *
     * @param uid   用户id
     * @param model
     * @return 返回查询到的纪录
     */
    @RequestMapping("/{uid}")
    public String cartItemList(@PathVariable("uid") Integer uid, Model model) {
        int productTotal = 0;  //商品总数
        BigDecimal totalMoney = null;   //每个cartItem的总价
        List<CartItem> cartItemList = cartItemService.getCartItems(uid);
        model.addAttribute("cartItemList", cartItemList);

        for (CartItem cartItem : cartItemList) {
            int quantity = cartItem.getQuantity();
            productTotal += quantity;   //算出商品总量
            BigDecimal totalMoney_item = cartItem.getTotalMoney();
            totalMoney = totalMoney_item.add(totalMoney_item);   //算出总价
        }
        model.addAttribute("productTotal", productTotal);
        model.addAttribute("totalMoney", totalMoney);
        return "cart";
    }

    //加入购物车
    @RequestMapping(value = "/addToCart", method = RequestMethod.POST)
    @ResponseBody
    public String addToCart(@RequestParam("uid") String uidStr,
                            @RequestParam("pid") String pidStr,
                            @RequestParam("quantity") String quantityStr,
                            @RequestParam("totalMoney") BigDecimal totalMoney) {
        Integer uid = Integer.valueOf(uidStr);
        Integer pid = Integer.valueOf(pidStr);
        Integer quantity = Integer.valueOf(quantityStr);
        CartItem cartItem = new CartItem(null, uid, pid, quantity, totalMoney, null);
        int result = cartItemService.addCart(cartItem);
        if (result > 0) {
            System.out.println("添加至购物车成功");
            return "success";
        } else {
            System.out.println("添加至购物车失败");
            return "fail";
        }
    }

    /**
     * 删除购物车中的某一项
     *
     * @param itemId id
     * @return 返回结果json数据
     */
    @RequestMapping("/deleteCartItem")
    @ResponseBody
    public String deleteCartItem(@RequestParam("id") Integer itemId) {
        int result = cartItemService.deleteCartItem(itemId);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /**
     * 清空购物车
     *
     * @param uid 用户id
     * @return 返回结果
     */
    @RequestMapping("/clearCart")
    @ResponseBody
    public String clearCart(@RequestParam("uid") Integer uid) {
        int result = cartItemService.clearCart(uid);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    @RequestMapping("/")
    public String cartItemList() {
        return "forward:/myCart/{uid}";
    }


}
