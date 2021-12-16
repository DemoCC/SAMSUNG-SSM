<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-4
  Time: 下午 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>查询所有管理员</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css">
</head>
<body>
<c:choose>
    <c:when test="${sessionScope.uList_admin.size() == 0}">
        <blockquote class="layui-elem-quote">暂无管理员信息</blockquote>
    </c:when>
    <c:otherwise>
    <blockquote class="layui-elem-quote">所有管理员信息</blockquote>
    <table class="layui-table" lay-even lay-skin="nob">
        <colgroup>
            <col width="70">
            <col width="70">
            <col width="70">
            <col width="100">
            <col width="100">
            <col width="100">
            <col width="120">
        </colgroup>
        <thead>
            <tr>
                <th>ID</th><th>名称</th><th>性别</th><th>电话</th>
                <th>生日</th><th>地址</th><th>操作</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="admin" items="${sessionScope.uList_admin}" varStatus="status">
            <tr>
                <td id="td_adminId">${admin.id}</td>
                <td>${admin.name}</td>
                <td>${admin.sex}</td>
                <td>${admin.tel}</td>
                <td>${admin.birth}</td>
                <td>${admin.address}</td>
                <c:choose>
                    <c:when test="${admin.id == sessionScope.user.id}">
                        <td>
                            <button class="layui-btn layui-btn-sm layui-btn-disabled">超级管理员</button>
                        </td>
                    </c:when>
                    <c:when test="${admin.isAdmin == 1}">
                        <td>
                            <button onclick="removeAdmin(${admin.id});" class="layui-btn layui-btn-sm layui-btn-normal">移除管理员</button>
                        </td>
                    </c:when>
                    <c:otherwise>
                        <td>
                            <button class="layui-btn layui-btn-sm layui-btn-disabled">超级管理员</button>
                        </td>
                    </c:otherwise>
                </c:choose>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    </c:otherwise>
</c:choose>
<script type="text/javascript">
    //移除管理员
    function removeAdmin(uid){
        layer.confirm(
            '确定要移除吗？',
            {icon: 3, title: '移除管理员'},
            function () {
                $.ajax({
                    url: '/SAMSUNG_WEB/userServlet_Admin?action=removeAdmin',
                    async: true,
                    data: {
                        uid: uid
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data === 'OK'){
                            layer.msg('移除成功',
                                {icon: 1, time: 500},
                                function () {
                                    window.location.replace('/SAMSUNG_WEB/userServlet_Admin?action=queryAdmins');
                                }
                            )
                        }
                        if (data === 'ERROR'){
                            layer.msg('移除失败' ,
                                {icon: 2, time: 500},
                                function () {
                                    window.location.replace('/SAMSUNG_WEB/userServlet_Admin?action=queryAdmins');
                                }
                            )
                        }
                    }
                })
            }
        );
        layer.close()
    }

</script>
</body>
</html>
