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

}
