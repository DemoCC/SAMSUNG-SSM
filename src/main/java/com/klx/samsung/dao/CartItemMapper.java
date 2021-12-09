package com.klx.samsung.dao;


import com.klx.samsung.domain.CartItem;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartItemMapper {
    /**
     * 根据用户id查询购物车
     * @return 返回购物车商品列表
     */
    List<CartItem> getCartItems(@Param("id") Integer uid);

    /**
     * 添加购物车
     * @param cartItem 购物车条目
     * @return 返回true代表添加成功
     */
    boolean addCartItem(CartItem cartItem);

    /**
     * 根据条目id删除条目
     * @param itemId 条目id
     * @return 删除成功返回true
     */
    boolean deleteCartItem(int itemId);

    /**
     * 清空购物车
     * @return 返回true清空成功
     */
    boolean clearCart(int uid);


}
