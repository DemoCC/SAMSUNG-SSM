package com.klx.samsung.service;

import com.klx.samsung.dao.CartItemMapper;
import com.klx.samsung.domain.CartItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartItemService {
    @Autowired
    private CartItemMapper cartItemMapper;

    /**
     * 查询购物车纪录
     *
     * @return 返回购物车纪录
     */
    public List<CartItem> getCartItems(Integer uid) {
        return cartItemMapper.getCartItems(uid);
    }

    /**
     * 添加到购物车
     *
     * @param cartItem item
     * @return 返回数据库执行纪录
     */
    public int addCart(CartItem cartItem) {
        return cartItemMapper.addCart(cartItem);
    }

    /**
     * 删除购物车的某一项
     *
     * @param itemId id
     * @return 返回数据库执行纪录
     */
    public int deleteCartItem(Integer itemId) {
        return cartItemMapper.deleteCartItem(itemId);
    }

    /**
     * 清空购物车
     * @param uid 用户id
     * @return 返回数据库执行纪录
     */
    public int clearCart(Integer uid){
        return cartItemMapper.clearCart(uid);
    }

}
