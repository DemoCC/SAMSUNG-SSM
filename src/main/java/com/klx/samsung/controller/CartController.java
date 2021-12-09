package com.klx.samsung.controller;

import com.klx.samsung.domain.CartItem;
import com.klx.samsung.domain.Product;
import com.klx.samsung.service.CartItemService;
import com.klx.samsung.service.ProductService;
import com.klx.samsung.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
     * @param uid 用户id
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

    @RequestMapping("/")
    public String cartItemList(){
        return "forward:/myCart/{uid}";
    }
}
