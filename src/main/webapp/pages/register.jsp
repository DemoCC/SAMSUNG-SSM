<%--
  Created by IntelliJ IDEA.
  User: KLX
  Date: 21-12-4
  Time: 下午 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<html>
<head>
    <title>用户注册</title>
    <script src="${webapp}/static/js/jquery.js"></script>
    <script src="${webapp}/static/bootstrap-3.4.1/js/bootstrap.min.js"></script>
    <script src="${webapp}/static/layui/layui.js"></script>
    <link rel="stylesheet" href="${webapp}/static/layui/css/layui.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/css/register.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/css/header.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/bootstrap-3.4.1/css/bootstrap.min.css" type="text/css"/>
    <link rel="shortcut icon" href="${webapp}/static/img/navhead/samsung_logo2.png" type="text/css"/>
</head>
<body>
<div id="header1"><%-- 导入头部jsp--%></div>
<img src="${webapp}/static/img/other/login_bg.jpg" alt="图片加载失败" class="img_bg_register">
<div class="row">
    <div class="col-md-6"></div>
    <div class="col-md-5" id="form_box">
        <h3>账户注册</h3>
        <form id="form_register" method="post" class="form-horizontal" enctype="multipart/form-data">
            <div class="form-group">
                <label class="col-sm-3 control-label">用户名：</label>
                <div class="col-sm-6">
                    <input type="text" name="name" class="form-control" id="input_name" placeholder="用户名">
                    <span class="help-block"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">密码：</label>
                <div class="col-sm-6">
                    <input type="password" name="password" class="form-control" id="input_password" placeholder="密码">
                    <span class="help-block"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">性别：</label>
                <label class="radio-inline col-sm-2">
                    <input type="radio" name="radio_gender" id="radio_gender1" value="M" checked="checked"> 男
                </label>
                <label class="radio-inline col-sm-1">
                    <input type="radio" name="radio_gender" id="radio_gender2" value="F"> 女
                </label>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">手机号：</label>
                <div class="col-sm-6">
                    <input type="number" name="tel" class="form-control" id="input_tel" placeholder="手机号">
                    <span class="help-block"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">生日：</label>
                <div class="col-sm-6">
                    <input type="date" name="birth" class="form-control" id="input_birth">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">地址：</label>
                <div class="col-sm-6">
                    <input type="text" name="address" class="form-control" id="input_address" placeholder="收货地址">
                    <span class="help-block"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">头像：</label>
                <div class="col-sm-6">
                    <input type="file" name="headImg" class="form-control" id="input_headImg">
                    <span class="help-block"></span>
                </div>
            </div>
        </form>
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-6">
                <button type="button" id="btn_register" class="btn btn-primary">注册</button>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    $(function () {
        $("#header1").load("${webapp}/pages/header.jsp");
    });

    //注册按钮点击
    $("#btn_register").click(function () {
        if (!checking_form()) {  //点击注册先校验表单数据
            return false;       //失败则直接返回
        }
        if ($(this).attr("btn_val") === "error") {
            return false;
        }
        //注册请求
        const form = document.querySelector("#form_register");
        const formData = new FormData(form);

        const name = $("#input_name").val().toString();
        const password = $("#input_password").val();
        const gender = $("input[name='radio_gender']:checked").val();
        const tel = $("#input_tel").val();
        const birth = $("#input_birth").val();
        const address = $("#input_address").val();
        const headImg = $("#input_headImg").val();//用户文件内容(文件)
        // var headImg = $("input[name='headImg']").val();//用户文件内容(文件),此处值为数组，因为可能有多个控件name值为headImg

        //将文本放入formData
        formData.append("name", name);
        formData.append("password", password);
        formData.append("gender", gender);
        formData.append("tel", tel);
        formData.append("birth", birth);
        formData.append("address", address);
        //将文件放入formData
        formData.append("headImg", headImg);

        $.ajax({
            url: '${webapp}/user/register',
            type: 'POST',   //必须
            enctype: 'multipart/form-data', //必须
            contentType: false,  //必须
            processData: false,  //必须
            // dataType: 'json',    //必须
            data: formData,
            success: function (res) {
                if (res === "success") {
                    layer.msg(
                        '注册成功', {icon: 1, time: 1000},
                        function () {
                            window.location.href = "login.jsp";
                        }
                    );
                }
                if (data === "fail") {
                    layer.msg('注册失败', {icon: 2, time: 1000});
                }
            }
        });
    });

    // 表单数据验证
    function checking_form() {
        //获取需要校验的数据
        const username = $("#input_name").val();
        const reg = /(^[a-zA-Z0-9_-]{5,15}$)|(^[\u2E80-\u9FFF]{2,8})/;
        if (!reg.test(username)) {
            //如果验证不通过
            showCheckMsg("#input_name", "error", "用户名为5-15位字母数字减号下划线或2-8位汉字");
            $("#input_name").focus();
            return false;   //校验不成功直接返回
        } else {
            showCheckMsg("#input_name", "success", "");
        }
        //完成以上再再校验密码
        const password = $("#input_password").val();
        const reg_password = /^[a-z0-9_-]{6,15}$/;
        if (!reg_password.test(password)) {
            showCheckMsg("#input_password", "error", "密码为6-15位字母数字减号下划线");
            $("#input_password").focus();
            return false;
        } else {
            showCheckMsg("#input_password", "success", "");
        }
        //完成以上再再校验手机号
        const tel = $("#input_tel").val();
        const reg_tel = /^1(3[0-9]|4[01456879]|5[0-35-9]|6[2567]|7[0-8]|8[0-9]|9[0-35-9])\d{8}$/;
        if (!reg_tel.test(tel)) {
            showCheckMsg("#input_tel", "error", "手机号格式不正确，请重新输入");
            $("#input_tel").focus();
            return false;
        } else {
            showCheckMsg("#input_tel", "success", "");
        }

        //完成以上再验证生日
        const birthday = $("#input_birth").val();
        if (birthday === "" || birthday === undefined) {
            showCheckMsg("#input_birth", "error", "请选择生日");
            $("#input_birth").focus();
            return false;
        }
        //完成以上再校验地址
        const address = $("#input_address").val();
        const reg_address = /(^[a-zA-Z0-9-]{5,30}$)|(^[\u2E80-\u9FFF]{3,20})/;
        if (!reg_address.test(address)) {
            showCheckMsg("#input_address", "error", "请输入正确地址");
            $("#input_address").focus();
            return false;
        } else {
            showCheckMsg("#input_address", "success", "");
        }
        //校验头像
        const headImg = $("#input_headImg").val();
        if (headImg == null || headImg === "") {
            showCheckMsg("#input_headImg", "error", "请选择头像");
            $("#input_headImg").focus();
            return false;
        } else {
            showCheckMsg("#input_headImg", "success", "");
        }
        return true;
    }

    //显示校验结果
    function showCheckMsg(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error");    //清空表单样式
        $(ele).next("span").text("")    //设置相邻span标签的提示文字为空

        if ("success" === status) {      //如果校验状态为成功
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" === status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //重置表单
    function reset_form(ele) {
        $(ele)[0].reset();  //重置表单数据
        $(ele).find("*").removeClass("has-success has-error");  //清空表单样式
        $(ele).find(".help-block").text("");    //清空提示信息
    }

    //校验用户名是否存在
    $("#input_name").change(function () {
        const username = $(this).val();    //获取username值$("#btn_register").reset();
        $("#btn_register").attr("btn_val", "");
        $.ajax({
            url: '${webapp}/user/checkUserName',
            type: 'GET',
            data: {
                "username": username
            },
            success: function (res) {
                if (res === "error-check") {
                    showCheckMsg("#input_name", "error", "用户名为5-15位字母数字减号下划线或2-8位汉字");
                    $("#btn_register").attr("btn_val", "error")
                }
                if (res === "exists") {
                    showCheckMsg("#input_name", "error", "用户名已存在");
                    $("#btn_register").attr("btn_val", "error")
                }
                if (res === "non-existent") {
                    showCheckMsg("#input_name", "success", "用户名可用");
                    $("#btn_register").attr("btn_val", "success");
                }
            }
        });
    })

</script>
</html>
