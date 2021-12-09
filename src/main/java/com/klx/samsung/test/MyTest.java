package com.klx.samsung.test;

import com.klx.samsung.domain.CartItem;
import com.klx.samsung.domain.Product;
import com.klx.samsung.domain.User;
import com.klx.samsung.service.CartItemService;
import com.klx.samsung.service.ProductService;
import com.klx.samsung.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

import java.util.ArrayList;
import java.util.List;

@SpringJUnitConfig(locations = "classpath:spring/Spring.xml")
public class MyTest {

    @Autowired
    private ProductService service;

    @Autowired
    private UserService userService;

    @Autowired
    private CartItemService cartItemService;

    @Test
    public void testQuery() {
//        List<Product> list = service.getProductByType("手机");
        List<Product> list = service.getProductByNetwork("5G");

        for (Product product : list) {
            System.out.println(product);
        }
    }

    @Test
    public void testUser() {
//        用户名密码查询呼呼
//        User user = userService.getUserByNameAndPass("KLX", "123");
        User user = userService.getUserByNameAndPassWhitCartItem("KLX", "123");
        System.out.println(user);

        //根据权限查询用户
        List<User> userList = userService.getUserByRole(1);
        System.out.println(userList);

    }

    @Test
    public void cartTest() {
        List<CartItem> cartItemList = cartItemService.getCartItems(2);
        System.out.println(cartItemList + "\n");
    }

}
