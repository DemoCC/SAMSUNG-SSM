<%@ page import="com.klx.samsung.domain.User" %><%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-5-30
  Time: 上午 12:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<html>
<head>
    <title>个人中心</title>
    <script src="${webapp}/static/js/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="${webapp}/static/layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <script src="${webapp}/static/bootstrap-3.4.1/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" href="${webapp}/static/layui/css/layui.css" type="text/css">
    <link rel="stylesheet" href="${webapp}/static/css/personal.css" type="text/css">
    <link rel="stylesheet" href="${webapp}/static/css/header.css" type="text/css">
    <link rel="stylesheet" href="${webapp}/static/bootstrap-3.4.1/css/bootstrap.min.css" type="text/css">
    <link rel="shortcut icon" href="${webapp}/static/img/navhead/samsung_logo2.png" type="text/css"/>
</head>
<body>
<c:choose>
    <%--没有用户登陆--%>
    <c:when test="${sessionScope.userInfo == null}">
        <% response.sendRedirect(request.getContextPath() + "/pages/login.jsp"); %>
    </c:when>
    <%--以下是有用户登陆--%>
    <c:otherwise>
        <div id="header1"> <!-- 导入头部jsp --> </div>
        <div class="row">
                <%-- 左边导航--%>
            <div class="col-sm-6 col-md-2">
                <ul class="nav nav-pills nav-stacked">
                    <li role="presentation" class="nav_li li_myInfo"><a href="${webapp}/user/personalCenter">我的信息</a>
                    </li>
                    <li role="presentation" class="nav_li"><a href="#">我的订单</a></li>
                    <li role="presentation" class="nav_li"><a href="#">消息通知</a></li>
                </ul>
            </div>
                <%--右边--%>
            <div class="col-xs-6 col-md-6 col-md-offset-2">
                    <%-- 头像 --%>
                <div id="headImg">
                    <c:choose>
                        <%-- 如果头像路径为空，则使用默认头像 --%>
                        <c:when test="${sessionScope.userInfo.headImgUrl == null || sessionScope.userInfo.headImgUrl == '' }">
                            <%--判断性别--%>
                            <c:choose>
                                <c:when test="${sessionScope.userInfo.sex=='男'}">
                                    <img src="${webapp}/static/img/headImg/sex1.png" alt="图片加载失败">
                                </c:when>
                                <c:otherwise>
                                    <img src="${webapp}/static/img/headImg/sex0.png" alt="图片加载失败">
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <%--如果用户头像不为空，使用自定义的头像--%>
                        <c:otherwise>
                            <img src="${webapp}/static/img/headImg/${sessionScope.userInfo.headImgUrl}" alt="图片加载失败">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="tb_box">
                    <table class="tb_userInfo">
                        <tr>
                            <td><label>ID：</label></td>
                            <td><label class="label_userInfo">${sessionScope.userInfo.id}</label></td>
                        </tr>
                        <tr>
                            <td><label>用户名：</label></td>
                            <td><label class="label_userInfo">${sessionScope.userInfo.name}</label></td>
                        </tr>
                        <tr>
                            <td><label>性别：</label></td>
                            <td><label class="label_userInfo">${sessionScope.userInfo.sex}</label></td>
                        </tr>
                        <tr>
                            <td><label>电话：</label></td>
                            <td><label class="label_userInfo">${sessionScope.userInfo.tel}</label></td>
                        </tr>
                        <tr>
                            <td><label>生日：</label></td>
                            <td><label class="label_userInfo">
                                <fmt:formatDate value="${sessionScope.userInfo.birth}" pattern="yyyy年MM月dd日"/></label>
                            </td>
                        </tr>
                        <tr>
                            <td><label>地址：</label></td>
                            <td><label class="label_userInfo">${sessionScope.userInfo.address}</label></td>
                        </tr>
                    </table>
                </div>
                <div class="foot_btn_box">
                    <c:choose>
                        <c:when test="${sessionScope.userInfo.role == 1 || sessionScope.userInfo.role == 2}">
                            <button type="button" class="btn btn-primary">
                                <a href="${webapp}/admin/">后台管理</a>
                            </button>
                            <button type="button" class="btn btn-primary btn_admin_update">
                                <a onclick="openEdit(${sessionScope.userInfo.id});" class="span_edit">修改信息</a>
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button type="button" class="btn btn-primary">
                                <a onclick="openEdit(${sessionScope.userInfo.id});" class="updateSpan">修改信息</a>
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>
<!-- 更新员工modal -->
<div class="modal fade" id="userEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">修改信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="form_editUser" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="uId_static" class="col-sm-3 control-label">ID：</label>
                        <div class="col-sm-5">
                            <p class="form-control-static" id="uId_static">${sessionScope.userInfo.id}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_uName" class="col-sm-3 control-label">名称：</label>
                        <div class="col-sm-5">
                            <input type="text" name="username" class="form-control" id="edit_uName"
                                   value="${sessionScope.userInfo.name}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_uName" class="col-sm-3 control-label">密码：</label>
                        <div class="col-sm-5">
                            <input type="password" name="password" class="form-control" id="edit_password"
                                   placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">性别：</label>
                        <div class="col-sm-5">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="edit_gender1" value="M" checked>男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="edit_gender2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_tel" class="col-sm-3 control-label">手机号：</label>
                        <div class="col-sm-6">
                            <input type="number" name="tel" class="form-control" id="edit_tel"
                                   value="${sessionScope.userInfo.tel}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_birth" class="col-sm-3 control-label">生日：</label>
                        <div class="col-sm-6">
                            <input type="date" name="birth" class="form-control" id="edit_birth">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_address" class="col-sm-3 control-label">地址：</label>
                        <div class="col-sm-6">
                            <input type="text" name="address" class="form-control" id="edit_address"
                                   value="${sessionScope.userInfo.address}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">头像：</label>
                        <div class="col-sm-6">
                            <input type="file" name="headImg" class="form-control" id="edit_headImg">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="btn_update">更新</button>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    const nav_li = document.getElementsByClassName("nav_li");
    $(function () {
        // 导入header.jsp
        $("#header1").load("${webapp}/pages/header.jsp");
        $(".li_myInfo").addClass("active");
    });

    //打开修改个人信息
    function openEdit() {
        //弹出模态框
        $('#userEditModal').modal({
            backdrop: 'static'
        })
    }

    //点击更新
    $("#btn_update").click(function () {
        if (!checking_form()) {
            return false;
        }
        const uid = $("#uId_static").text();
        const form = document.querySelector("#form_editUser");
        const formData = new FormData(form);

        const uName = $("#edit_uName").val();
        const password = $("#edit_password").val();
        const gender = $("input[name='gender']:checked").val();
        const tel = $("#edit_tel").val();
        const birth = $("#edit_birth").val();
        const address = $("#edit_address").val();
        const headImg = $("#edit_headImg").val();//用户文件内容(文件)
        // var headImg = $("input[name='headImg']").val();//用户文件内容(文件),此处值为数组，因为可能有多个控件name值为headImg

        //将文本放入formData
        formData.append("name", uName);
        formData.append("password", password);
        formData.append("gender", gender);
        formData.append("tel", tel);
        formData.append("birth", birth);
        formData.append("address", address);
        //将文件放入formData
        formData.append("headImg", headImg);

        $.ajax({
            url: '${webapp}/user/updateUser?uid=' + uid,
            type: 'POST',   //必须
            enctype: 'multipart/form-data', //必须
            contentType: false,  //必须
            processData: false,  //必须
            // dataType: 'json',    //必须
            data: formData,
            success: function (res) {
                if (res === "success") {
                    layer.msg(
                        '更新成功，请重新登录', {icon: 1, time: 1000},
                        function () {
                            window.location.href = "/pages/login.jsp";
                        }
                    );
                }
                if (data === "fail") {
                    layer.msg('更新失败', {icon: 2, time: 1000});
                }
            }
        });

    });


    //点击左边导航
    $(".nav_li").click(function () {
        $(".nav_li").removeClass("active");
        $(this).addClass("active");
    });

    // 表单数据验证
    function checking_form() {
        //验证用户名
        const uName = $("#edit_uName").val();
        const reg = /(^[a-zA-Z0-9]{5,15}$)|(^[\u2E80-\u9FFF]{2,6})/;
        if (!reg.test(uName)) {    //如果验证不通过
            showCheckMsg("#edit_uName", "error", "用户名为5-15位字母数字或2-6位汉字");
            $("#edit_uName").focus();
            return false;   //校验不成功直接返回
        } else {
            showCheckMsg("#edit_uName", "success", "");
        }
        //完成以上再再校验密码
        const password = $("#edit_password").val();
        const reg_password = /^[a-z0-9_-]{6,15}$/;
        if (!reg_password.test(password)) {
            showCheckMsg("#edit_password", "error", "密码为6-15位字母数字减号下划线");
            $("#edit_password").focus();
            return false;
        } else {
            showCheckMsg("#edit_password", "success", "");
        }

        //完成以上再再校验手机号
        const tel = $("#edit_tel").val();
        const reg_tel = /^1(3[0-9]|4[01456879]|5[0-35-9]|6[2567]|7[0-8]|8[0-9]|9[0-35-9])\d{8}$/;
        if (!reg_tel.test(tel)) {
            showCheckMsg("#edit_tel", "error", "手机号格式不正确，请重新输入");
            $("#edit_tel").focus();
            return false;
        } else {
            showCheckMsg("#edit_tel", "success", "");
        }

        //完成以上再验证生日
        const birthday = $("#edit_birth").val();
        if (birthday === "" || birthday === undefined) {
            showCheckMsg("#edit_birth", "error", "请选择生日");
            $("#edit_birth").focus();
            return false;
        }
        //完成以上再校验地址
        const address = $("#edit_address").val();
        const reg_address = /(^[a-zA-Z0-9-]{5,30}$)|(^[\u2E80-\u9FFF]{3,20})/;
        if (!reg_address.test(address)) {
            showCheckMsg("#edit_address", "error", "请输入正确地址");
            $("#edit_address").focus();
            return false;
        } else {
            showCheckMsg("#edit_address", "success", "");
        }
        //校验头像
        const headImg = $("#edit_headImg").val();
        if (headImg === undefined || headImg === "") {
            showCheckMsg("#edit_headImg", "error", "请选择头像");
            $("#edit_headImg").focus();
            return false;
        } else {
            showCheckMsg("#edit_headImg", "success", "");
        }

        return true;
    }

    //显示校验结果
    function showCheckMsg(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error");    //清空表单样式

        if ("success" === status) {      //如果校验状态为成功
            $(ele).parent().addClass("has-success");
        } else if ("error" === status) {
            $(ele).addClass("has-error");
            layer.msg(msg, {
                offset: 't',    //位置，弹出在顶部
                // icon: 2,    //图标
                anim: 6     //动画
            });
        }
    }
</script>
</html>
