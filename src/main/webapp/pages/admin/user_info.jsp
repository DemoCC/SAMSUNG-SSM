<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<html>
<head>
    <title>${userInfo.name}的个人信息</title>
    <script src="${webapp}/static/js/jquery.js" type="text/javascript"></script>
    <script src="${webapp}/static/layui/layui.js" type="text/javascript" ></script>
    <link rel="stylesheet" href="${webapp}/static/layui/css/layui.css" type="text/css"/>
    <style>
        body{
            margin: 10px 50px;
        }
    </style>
</head>
<body>
<c:choose>
    <c:when test="${userInfo == null}">
        <h2 align="center" style="margin: 50px 0">用户不存在</h2>
        <a href="manager_main.jsp" class="layui-btn layui-btn-normal">返回</a>
    </c:when>
    <c:otherwise>
        <div class="outBox">
            <blockquote class="layui-elem-quote">${sessionScope.user_byId.name}的个人信息</blockquote>
            <table class="layui-table" lay-even lay-skin="nob" lay-size="lg">
                <colgroup>
                    <col width="100">
                    <col width="100">
                    <col width="100">
                    <col width="100">
                    <col width="150">
                    <col>
                </colgroup>
                <tr>
                    <th>用户名</th><td>${sessionScope.user_byId.name}</td>
                </tr>
                <tr>
                    <th>性别</th><td>${sessionScope.user_byId.sex}</td>
                </tr>
                <tr>
                    <th>电话</th><td>${sessionScope.user_byId.tel}</td>
                </tr>
                <tr>
                    <th>生日</th><td>${sessionScope.user_byId.birth}</td>
                </tr>
                <tr>
                    <th>地址</th><td>${sessionScope.user_byId.address}</td>
                </tr>
            </table>
            <a href="manager_main.jsp" class="layui-btn layui-btn-normal">返回</a>
        </div>
    </c:otherwise>
</c:choose>
</body>
</html>
