package com.klx.samsung.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @RequestMapping("/")
    public String manager(){
        return "admin/manager_main";
    }

}
