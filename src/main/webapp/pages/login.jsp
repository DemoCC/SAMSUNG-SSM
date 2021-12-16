<%--
  Created by IntelliJ IDEA.
  User: KLX
  Date: 2021-5-29
  Time: 下午 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>登录账户</title>
    <script type="text/javascript" src="${webapp}/static/js/jquery.js"></script>
    <script type="text/javascript" src="${webapp}/static/layui/layui.js"></script>
    <script type="text/javascript" src="${webapp}/static/bootstrap-3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${webapp}/static/layui/css/layui.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/css/login.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/css/header.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/css/link_list.css" type="text/css"/>
    <link rel="shortcut icon" href="${webapp}/static/img/navhead/samsung_logo2.png" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/bootstrap-3.4.1/css/bootstrap.min.css" type="text/css">

</head>
<body>
<img src="${webapp}/static/img/other/login_bg.jpg" alt="图片加载失败" class="img_bg_login">
<div id="header1"> <%-- 导入头部jsp--%></div>
<%--登录表单--%>
<div class="loginFormDiv">
    <span class="glyphicon glyphicon-user" aria-hidden="true">用户登录</span>
    <form class="form-horizontal" id="form_login">
        <div class="form-group">
            <label class="col-sm-3 control-label">用户名</label>
            <div class="col-sm-7">
                <input type="text" id="input_name" name="username" class="form-control" placeholder="用户名">
                <span class="help-block"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">密码</label>
            <div class="col-sm-7">
                <input type="password" id="input_password" name="password" class="form-control" placeholder="密码">
                <span class="help-block" id="login_msg"></span>
            </div>
        </div>
        <div class="form-group div_btn_login">
            <div class="col-sm-offset-1">
                <button type="button" id="btn_login" class="btn btn-primary">登录</button>
            </div>
        </div>
    </form>
    <div class="div_goRegister">
        <a href="${webapp}/pages/register.jsp">
            注册账户
            <span class="glyphicon glyphicon-triangle-right"></span>
        </a>
    </div>
</div>

<footer id="index_foot">
    <p style="overflow: hidden">© 1995-2020 三星（中国）投资有限公司 版权所有</p>
    <p style="overflow: hidden">三星（中国）投资有限公司授权北京鹏泰宝尊电子商务有限公司运营三星网上商城并销售产品</p>
</footer>
<!-- 底部各种链接 -->
<div id="link_list"> <!-- link_list.html --></div>
</body>
<script type="text/javascript">
    $(function () {
        $("#header1").load("${webapp}/pages/header.jsp");    // 导入header.jsp
        $("#link_list").load("${webapp}/pages/link_list.jsp");    // 导入link_list.jsp
    });

    //点击登录
    $("#btn_login").click(function () {
        const username = $("#input_name").val();
        const password = $("#input_password").val();
        //校验表单
        if (!checking_form()) {
            return false;
        }
        //表单验证成功后发送登录请求
        $.ajax({
            url: '${webapp}/user/login',
            type: 'GET',
            data: {
                "username": username,
                "password": password
            },
            success: function (res) {
                if (res === "success") {
                    layer.msg('登录成功', {
                            offset: 'auto',
                            icon: 1,
                            anim: 5,
                            time: 800
                        },
                        function () {
                            window.location.href = "${webapp}/";
                            reset_form("#form_login");
                        });
                } else {
                    $("#input_name").removeClass("has-success");
                    $("#input_password").removeClass("has-success");
                    $("#input_name").parent().addClass("has-error");
                    $("#input_password").parent().addClass("has-error");
                    // $("#login_msg").text("用户名或密码错误");
                    layer.msg('用户名或密码错误', {
                        offset: 't',
                        anim: 6
                    });
                }
            }
        });
    });

    //验证表单
    function checking_form() {
        const username = $("#input_name").val();
        if (username === "" || username === undefined) {
            showCheckMsg("#input_name", "error", "请输入用户名");
            $("#input_name").focus();
            return false;
        } else {
            showCheckMsg("#input_name", "success", "");
        }

        const password = $("#input_password").val();
        if (password === "" || password === undefined) {
            showCheckMsg("#input_password", "error", "请输入密码");
            $("#input_password").focus();
            return false;
        } else {
            showCheckMsg("#input_password", "success", "");
        }
        return true;
    }

    //显示校验结果
    function showCheckMsg(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error");    //清空表单样式

        if ("success" === status) {      //如果校验状态为成功
            $(ele).parent().addClass("has-success");
        } else if ("error" === status) {
            $(ele).parent().addClass("has-error");
            layer.msg(msg, {
                offset: 't',    //位置，弹出在顶部
                // icon: 2,    //图标
                anim: 6     //动画
            });
        }
    }

    //重置表单
    function reset_form(ele) {
        $(ele)[0].reset();  //重置表单数据
        $(ele).find("*").removeClass("has-success has-error");  //清空表单样式
        $(ele).find(".help-block").text("");    //清空提示信息
    }
</script>
</html>

