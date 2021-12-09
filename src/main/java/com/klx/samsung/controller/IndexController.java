package com.klx.samsung.controller;

import com.klx.samsung.dao.ProductMapper;
import com.klx.samsung.domain.Product;
import com.klx.samsung.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
public class IndexController {

    @Autowired
    private ProductService service;

    /**
     * 初始化主页数据
     * @param model 视图
     * @return 返回视图名称
     */
    @RequestMapping("/")
    public String index(Model model) {
        Integer[] idArr = {301, 401, 601, 501, 503, 110, 111, 113};
        List<Integer> idList = new ArrayList<>(Arrays.asList(idArr)); //将id加入List

        List<Product> productList = service.getProductsWithIds(idList); //查询出产品
        model.addAttribute("productList", productList);
        return "index";
    }
}
