package com.klx.samsung.dao;


import com.klx.samsung.domain.OrderItem;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderItemMapper {
    /**
     * 生成一个订单
     * @param orderItemVO 订单对象
     * @return 返回true代表订单生成成功
     */
    boolean createOrderItem(OrderItem orderItemVO);


    /**
     * 根据用户id查询此用户未完成的订单，并放入购物车
     * @param uid 用户id
     * @return 返回此用户未完成的所有订单
     */
    List<OrderItem> queryOrders(int uid);

}
