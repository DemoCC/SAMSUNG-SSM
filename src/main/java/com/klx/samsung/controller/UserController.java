package com.klx.samsung.controller;

import com.klx.samsung.domain.User;
import com.klx.samsung.service.UserService;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    /**
     * 登录
     *
     * @param username 用户名
     * @param password 密码
     * @param session  session
     * @return 重定向到指定页面
     */
    @RequestMapping("/login")
    @ResponseBody
    public String login(@RequestParam("username") String username, @RequestParam("password") String password, HttpSession session) {
        User user = userService.getUserByNameAndPass(username, password);
        if (user != null) {
            session.setAttribute("userInfo", user);
            return "success";
        } else {
            return "fail";
        }
    }

    /**
     * 个人中心
     *
     * @return 个人中心视图
     */
    @RequestMapping("/personalCenter")
    public String personalCenter() {
        return "personal";
    }

    /**
     * 注册
     *
     * @return 返回json数据
     */
    @RequestMapping("/register")
    @ResponseBody
    public String register(HttpServletRequest request, @RequestParam("headImg") MultipartFile headImg, HttpSession session) throws IOException {
        String username = request.getParameter("name");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String gender2 = "M".equals(gender) ? "男" : "女";
        String tel = request.getParameter("tel");
        String birth = request.getParameter("birth");
        String address = request.getParameter("address");

        //处理生日
        DateTimeFormatter dtf = DateTimeFormat.forPattern("yyyy-MM-dd");
        DateTime parse = DateTime.parse(birth, dtf);
        Date birthday = parse.toDate();

        //处理头像
        UUID uuid = UUID.randomUUID();
        String uuidStr = uuid.toString().substring(0, 5);
        String fileName = uuidStr + headImg.getOriginalFilename();   //headImg.getOriginalFilename()：获取带后缀的文件名

        //获取服务器图片路径
        ServletContext context = session.getServletContext();
        String path = context.getRealPath("static/img/headImg");
        File file = new File(path, fileName);
        if (!file.exists()) {
            file.mkdirs();
        }
        headImg.transferTo(file);
        System.out.println("filePath--------" + file);

        User user = new User(null, username, password, gender2, tel, birthday, address, fileName, null, null, null);
        System.out.println(user);
        if (userService.addUser(user) > 0) {
            System.out.println("success");
            return "success";
        } else {
            return "fail";
        }
    }

    /**
     * 退出登录
     *
     * @param session session
     * @return 重定向到首页
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("userInfo");    //清除session
        return "redirect:/";    //重定向到首页
    }

    /**
     * 校验用户名是否存在
     *
     * @param username 用户名
     * @return 返回结果json数据
     */
    @RequestMapping("/checkUserName")
    @ResponseBody
    public String checkUserName(@RequestParam("username") String username) {
        //先判断用户名是否是合法
        String regName = "(^[a-zA-Z0-9_-]{5,15}$)|(^[\u2E80-\u9FFF]{2,8})";
        if (!username.matches(regName)) {
            return "error-check";
        }
        User user = userService.getUserByName(username);
        if (user == null) {     //用户不存在，返回non-existent
            return "non-existent";
        } else {
            return "exists";    //存在返回exists
        }
    }

    //更新用户
    @RequestMapping("/updateUser")
    @ResponseBody
    public String updateUser(@RequestParam("headImg") MultipartFile headImg, HttpSession session, HttpServletRequest request) throws IOException {
        Integer uid = Integer.valueOf(request.getParameter("uid"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String gender2 = "M".equals(gender) ? "男" : "女";
        String tel = request.getParameter("tel");
        String birth = request.getParameter("birth");
        String address = request.getParameter("address");

        //处理生日
        DateTimeFormatter dtf = DateTimeFormat.forPattern("yyyy-MM-dd");
        DateTime parse = DateTime.parse(birth, dtf);
        Date birthday = parse.toDate();

        //处理头像
        UUID uuid = UUID.randomUUID();
        String uuidStr = uuid.toString().substring(0, 6);
        String fileName = uuidStr + headImg.getOriginalFilename();   //headImg.getOriginalFilename()：获取带后缀的文件名

        //获取服务器图片路径
        ServletContext context = session.getServletContext();
        String path = context.getRealPath("static/img/headImg");
        File file = new File(path, fileName);
        if (!file.exists()) {
            file.mkdirs();
        }
        headImg.transferTo(file);
        System.out.println("更新后的头像位置------->" + file);

        User user = new User(uid, username, password, gender2, tel, birthday, address, fileName, null, null, null);
        System.out.println("更新后的用户:------->" + user);
        if (userService.updateUser(user) > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

}
