package com.klx.samsung.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.klx.samsung.domain.Product;
import com.klx.samsung.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private ProductService service;

    /**
     * 根据id列表查询产品
     *
     * @param id    产品id
     * @param model 视图模型
     * @return 返回查询到的产品纪录
     */
    @RequestMapping("/productInfo/{id}")
    public String productInfo(@PathVariable("id") List<Integer> id, Model model) {
        List<Product> product = service.getProductsWithIds(id);
        model.addAttribute("product", product);
        return "product_info";
    }

    /**
     * 通过类别查询产品
     *
     * @param type  列表
     * @param model 视图
     * @return 返回查询到的产品纪录
     */
    @RequestMapping("/{type}")
    public String getProductByType(@PathVariable("type") String type, @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber, Model model) {
        //分页
        PageHelper.startPage(pageNumber, 8);
        //查询产品
        String[] typeList = {"mobile", "wear", "houseHoldElect", "office"};
        if (typeList[0].equals(type)) {
            type = "手机";
        } else if (typeList[1].equals(type)) {
            type = "穿戴";
        } else if (typeList[2].equals(type)) {
            type = "家电";
        } else if (typeList[3].equals(type)) {
            type = "办公";
        }
        List<Product> productList = service.getProductByType(type);

        //分页，每页显示8个
        PageInfo pListWithPage = new PageInfo(productList, 5);
        model.addAttribute("pListWithPage", pListWithPage);
        return "products_type";
    }


    /**
     * 获取5G产品
     *
     * @param network    网络类型
     * @param pageNumber 页码
     * @param model      视图模型
     * @return 视图名称
     */
    @RequestMapping("/network/{network_type}")
    public String productFiveG(@PathVariable("network_type") String network, @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber, Model model) {
        //分页
        PageHelper.startPage(pageNumber, 8);
        List<Product> productList = service.getProductByNetwork(network);
        //分页，每页显示8个
        PageInfo pListWithPage = new PageInfo(productList, 5);
        model.addAttribute("pListWithPage", pListWithPage);
        return "product_fiveG";
    }

    /**
     * 若用户直接访问:/product
     *
     * @param model 视图模型
     * @return 返回查询到的产品纪录
     */
    @RequestMapping("/")
    public String productByMobile(Model model) {
        return "forward:/product/手机";
    }


//    @RequestMapping("/{type}")
//    @ResponseBody
//    public PageInfo getProductByType(@PathVariable("type") String type, @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber, Model model) {
//        PageHelper.startPage(pageNumber, 8);
//        List<Product> productList = mapper.getProductByType(type);
//        //分页，每页显示8个
//        PageInfo pListWithPage = new PageInfo(productList, 8);
////        model.addAttribute("pListWithPage", pListWithPage);
//        return pListWithPage;
//    }

}
