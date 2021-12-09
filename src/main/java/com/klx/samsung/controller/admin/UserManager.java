package com.klx.samsung.controller.admin;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.klx.samsung.domain.User;
import com.klx.samsung.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;

@Controller
@RequestMapping("/userManager")
public class UserManager {

    @Autowired
    private UserService userService;

    /**
     * 根据角色查询用户
     *
     * @param role 1：管理员 2：超级管理员 0：普通用户
     * @return 返回用户纪录
     */
    @RequestMapping("/role/{roleId}")
    public String getNormalUser(@RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber, @PathVariable("roleId") Integer role, Model model) {
        PageHelper.startPage(pageNumber, 5);
        List<User> userList = userService.getUserByRole(role);
        PageInfo pageInfo = new PageInfo(userList, 5);
        model.addAttribute("pageInfo", pageInfo);

        return "admin/user_role";
    }

    /**
     * 根据用户名查询用户
     *
     * @param username 用户名
     * @return 视图
     */
    @RequestMapping("/userInfo/{username}")
    @ResponseBody
    public String userInfoManage(@PathVariable("username") String username, Model model) {
        User user = userService.getUserByName(username);
        model.addAttribute("userInfo", user);
        return null;
    }

    /**
     * 根据id删除用户
     *
     * @param uid 用户id
     * @return json数据
     */
    @RequestMapping("/deleteUser")
    @ResponseBody
    public String deleteUser(@RequestParam("uid") Integer uid, HttpSession session) {
        //删除前先获取一下用户信息，得到头像地址
        User user = userService.getUserById(uid);

        if (user != null) {
            String headImgUrl = user.getHeadImgUrl();   //获取数据库中头像路径
            ServletContext context = session.getServletContext();
            //最终位置
            String imgPath = context.getRealPath("static/img/headImg/" + headImgUrl);
            System.out.println(imgPath);

            File file = new File(imgPath);
            if (file.exists()) {
                file.delete();
                System.out.println("---------->头像删除成功");
            }
        } else {
            return "fail";
        }
        //头像删了之后再删数据库
        int result = userService.deleteUserById(uid);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /**
     * 设置为管理员
     *
     * @param uid  用户id
     * @param role 用户权限 1:超级管理员 2：管理员 0：普通用户 3：开发
     * @return 返回json数据
     */
    @RequestMapping("/setRole")
    @ResponseBody
    public String setRoleById(@RequestParam("uid") Integer uid, @RequestParam("role") Integer role) {
        int result = userService.setRole(uid, role);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    /**
     * 查询所有用户
     *
     * @return 返回用户纪录
     */
//    @RequestMapping("allUser")
//    public String getAllUser(@RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber, Model model) {
//        PageHelper.startPage(pageNumber, 5);
//        List<User> userList = userService.getAllUser();
//        PageInfo pageInfo = new PageInfo(userList, 5);
//        model.addAttribute("pageInfo", pageInfo);
//        return "user_normal";
//    }

}
