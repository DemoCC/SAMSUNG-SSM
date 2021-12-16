package com.klx.samsung.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.klx.samsung.domain.Product;
import com.klx.samsung.domain.User;
import com.klx.samsung.service.ProductService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/productManager")
public class ProductManager {

    @Autowired
    private ProductService productService;

    /**
     * 根据类别显示产品
     *
     * @param type       产品类别
     * @param pageNumber 页面
     * @param model      model
     * @return 视图
     */
    @RequestMapping("/{type}")
    public String getProductByType(@PathVariable("type") String type, @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber, Model model) {
        //分页，每页显示5个
        PageHelper.startPage(pageNumber, 5);
        //查询产品
        List<Product> productList = productService.getProductByType(type);
        PageInfo pageInfo = new PageInfo(productList, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/product_type";
    }

    /**
     * 添加商品
     *
     * @param productImg 图片
     * @param request    request
     * @return 返回json数据
     */
    @RequestMapping("/addProduct")
    @ResponseBody
    public String addProduct(@RequestParam("input_img") MultipartFile productImg, HttpServletRequest request, HttpSession session) throws IOException {
        String name = request.getParameter("pName");
        BigDecimal price = BigDecimal.valueOf(Long.parseLong(request.getParameter("price")));
        String color = request.getParameter("color");
        String type = request.getParameter("type");
        String network = request.getParameter("network");
        int stock = Integer.parseInt(request.getParameter("stock"));
        //处理类型
        String type_ZH = null;
        if ("mobile".equals(type)) {
            type_ZH = "手机";
        } else if ("wear".equals(type)) {
            type_ZH = "穿戴";
        } else if ("home".equals(type)) {
            type_ZH = "家电";
        } else if ("office".equals(type)) {
            type_ZH = "办公";
        } else if ("other".equals(type)) {
            type_ZH = "其他";
        }
        //处理图片
        UUID uuid = UUID.randomUUID();
        String uuidStr = uuid.toString().substring(0, 6);
        String imgName = type + "/" + uuidStr + productImg.getOriginalFilename();
        //获取服务器路径
        ServletContext context = session.getServletContext();
        String path = context.getRealPath("static/img/products");
        File file = new File(path, imgName);
        if (!file.exists()) {
            file.mkdirs();
        }
        productImg.transferTo(file);
        System.out.println("filePath--------" + file);

        Product product = new Product(null, name, price, color, type_ZH, network, stock, imgName);
        int result = productService.addProduct(product);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /**
     * 根据产品id删除产品
     *
     * @param id 产品id
     * @return 返回json数据
     */
    @RequestMapping("/deleteProduct")
    @ResponseBody
    String deleteProduct(@RequestParam("id") Integer id, HttpSession session) {
        //先拿到产品数据把图片文件删除
        List<Integer> ids = new ArrayList<>();
        ids.add(id);
        List<Product> products = productService.getProductsWithIds(ids);
        //获取到产品存在数据库里的路径
        String imgUrl = products.get(0).getUrl();
        //获取服务器存放此产品图片的路径
        ServletContext context = session.getServletContext();
        String imgAbsPath = context.getRealPath("static/img/products/" + imgUrl);
        File file = new File(imgAbsPath);
        System.out.println("待删除:---------------->" + file);
        if (file.exists()) {
            file.delete();
            System.out.println("----------------->图片删除成功");
        }

        //图片删除后再删数据库
        int result = productService.deleteProduct(id);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }


    /**
     * 回显商品信息
     *
     * @param pid 商品id
     * @return 返回json数据
     */
    @RequestMapping("/getProductById")
    @ResponseBody
    public Product getProductById(@RequestParam("pid") Integer pid) {
        List<Integer> ids = new ArrayList<>();
        ids.add(pid);
        List<Product> productList = productService.getProductsWithIds(ids);
        Product product = productList.get(0);

        if ("手机".equals(product.getType())) {
            product.setType("mobile");
        } else if ("穿戴".equals(product.getType())) {
            product.setType("wear");
        } else if ("家电".equals(product.getType())) {
            product.setType("home");
        } else if ("办公".equals(product.getType())) {
            product.setType("office");
        } else if ("其他".equals(product.getType())) {
            product.setType("other");
        }
        System.out.println("更新产品回显的信息：----->" + product);
        return product;
    }

    /**
     * 更新商品
     */
    @RequestMapping("/updateProduct")
    @ResponseBody
    public String updateProduct(@RequestParam("productImg") MultipartFile productImg, HttpSession session, HttpServletRequest request) throws IOException {
        Integer pid = Integer.valueOf(request.getParameter("pid"));
        String pName = request.getParameter("pName");
        BigDecimal price = BigDecimal.valueOf(Long.parseLong(request.getParameter("price")));
        String color = request.getParameter("color");
        String type = request.getParameter("type");
        String network = request.getParameter("network");
        int stock = Integer.parseInt(request.getParameter("stock"));

        //处理类型
        String type_ZH = null;
        if ("mobile".equals(type)) {
            type_ZH = "手机";
        } else if ("wear".equals(type)) {
            type_ZH = "穿戴";
        } else if ("home".equals(type)) {
            type_ZH = "家电";
        } else if ("office".equals(type)) {
            type_ZH = "办公";
        } else if ("other".equals(type)) {
            type_ZH = "其他";
        }

        //处理图片
        UUID uuid = UUID.randomUUID();
        String uuidStr = uuid.toString().substring(0, 6);
        String imgName = type + "/" + uuidStr + productImg.getOriginalFilename();

        //获取服务器路径
        ServletContext context = session.getServletContext();
        String path = context.getRealPath("static/img/products");
        File file = new File(path, imgName);
        if (!file.exists()) {
            file.mkdirs();
        }
        productImg.transferTo(file);
        System.out.println("filePath--------" + file);

        Product product = new Product(pid, pName, price, color, type_ZH, network, stock, imgName);

        int result = productService.updateProduct(product);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /**
     * 多条件查询
     *
     * @param network  产品名
     * @param price 价格
     * @return 产品纪录
     */
    @RequestMapping("/getProductByMore")
    public String getProductByMore(@Param("network") String network, @Param("price") BigDecimal price, @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber, Model model) {
        //分页，每页显示5个
        PageHelper.startPage(pageNumber, 5);

        Product product = new Product();
        product.setNetwork(network);
        product.setPrice(price);
        List<Product> productList = productService.getProductByMore(product);
        System.out.println(productList);
        PageInfo pageInfo = new PageInfo(productList, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/productList_query";
    }

}
