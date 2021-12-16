<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-4
  Time: 下午 9:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<html>
<head>
    <title></title>
    <script src="${webapp}/static/layui/layui.js" type="text/javascript"></script>
    <script src="${webapp}/static/js/jquery.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${webapp}/static/layui/css/layui.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/bootstrap-3.4.1/css/bootstrap.min.css" type="text/css"/>
</head>
<style>
    #div_upData {
        padding: 5px 30px;
    }

    .layui-input-inline input {
        width: 130px;
        height: 35px;
    }
</style>
<body>
<c:choose>
    <c:when test="${pageInfo.list.size() == 0}">
        <div class="alert alert-warning" role="alert">暂无用户信息</div>
    </c:when>
    <c:otherwise>
        <div>
            <table class="layui-table" lay-even lay-skin="nob">
                <colgroup>
                </colgroup>
                <thead>
                <tr>
                    <th>用户ID</th>
                    <th>用户名</th>
                    <th>性别</th>
                    <th>电话</th>
                    <th>生日</th>
                    <th>地址</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${pageInfo.list}" varStatus="status">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.sex}</td>
                        <td>${user.tel}</td>
                        <td><fmt:formatDate value="${user.birth}" pattern="yyyy年MM月dd日"/></td>
                        <td>${user.address}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.role == 1}">
                                    <button id="removeRole" class="layui-btn layui-btn-sm layui-btn-normal"
                                            onclick="removeRole(${user.id});">移除管理员
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button id="setRole" class="layui-btn layui-btn-sm layui-btn-normal"
                                            onclick="setRole(${user.id});">设为管理员
                                    </button>
                                    <button onclick="delUser(${user.id});"
                                            class="layui-btn layui-btn-sm layui-btn-danger">
                                        删除
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
                <%--分页--%>
            <div style="text-align: center">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                            <%-- 首页、上一页--%>
                        <c:choose>
                            <c:when test="${pageInfo.hasPreviousPage == true}">
                                <li><a href="${webapp}/userManager/role/${pageInfo.list[0].role}?pageNumber=1">首页</a>
                                </li>
                                <li>
                                    <a href="${webapp}/userManager/role/${pageInfo.list[0].role}?pageNumber=${pageInfo.pageNum-1}"
                                       aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="disabled"><a>首页</a></li>
                                <li class="disabled"><a aria-label="Previous"><span
                                        aria-hidden="true">&laquo;</span></a></li>
                            </c:otherwise>
                        </c:choose>
                            <%-- 分页导航遍历 --%>
                        <c:forEach var="currentPage" items="${pageInfo.navigatepageNums}" varStatus="status">
                            <c:choose>
                                <c:when test="${currentPage == pageInfo.pageNum}">
                                    <li class="active">
                                        <a href="${webapp}/userManager/role/${pageInfo.list[0].role}?pageNumber=${currentPage}">${currentPage}
                                            <span class="sr-only"></span></a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li>
                                        <a href="${webapp}/userManager/role/${pageInfo.list[0].role}?pageNumber=${currentPage}">${currentPage}
                                            <span class="sr-only"></span></a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                            <%--下一页、末页--%>
                        <c:choose>
                            <c:when test="${pageInfo.hasNextPage == true}">
                                <li>
                                    <a href="${webapp}/userManager/role/${pageInfo.list[0].role}?pageNumber=${pageInfo.pageNum+1}"
                                       aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                                <li>
                                    <a href="${webapp}/userManager/role/${pageInfo.list[0].role}?pageNumber=${pageInfo.pages}">末页</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="disabled">
                                    <a aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
                                </li>
                                <li class="disabled"><a>末页</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </nav>
            </div>
        </div>
        <%-- 隐藏表单--%>
        <input type="hidden" id="span_uid" value="${sessionScope.userInfo.id}">
    </c:otherwise>
</c:choose>
<script>
    //删除用户
    function delUser(uid) {
        layer.confirm(
            '确定要删除用户吗？', {icon: 3},
            function () {
                const loginUId = $("#span_uid").val();
                if (uid === loginUId) {
                    layer.alert('不能删除当前登录的用户', {icon: 7});
                } else {
                    $.ajax({
                        url: '${webapp}/userManager/deleteUser?uid=' + uid,
                        type: 'post',
                        success: function (res) {
                            if (res === "success") {
                                layer.msg('删除成功', {icon: 1, time: 700},
                                    function () {
                                        window.location.replace('${webapp}/userManager/role/0?pageNumber=${pageInfo.pageNum}');
                                    }
                                );
                            }
                            if (res === "fail") {
                                layer.msg('删除失败', {icon: 2, time: 700});
                            }
                        }
                    });
                }
            },
            layer.close()
        );
    }

    //设置管理员
    function setRole(uid) {
        layer.confirm(
            '确定要设为管理员吗？', {icon: 3},
            function () {
                $.ajax({
                    url: '${webapp}/userManager/setRole',
                    type: 'post',
                    data: {
                        "uid": uid,
                        "role": 1
                    },
                    success: function (res) {
                        if (res === "success") {
                            layer.msg(
                                '设置成功',
                                {icon: 1, time: 500},
                                function () {
                                    //跳转到管理员列表的最后一页
                                    window.location.replace('${webapp}/userManager/role/1');
                                }
                            );
                        }
                        if (res === "fail") {
                            layer.msg('设置失败', {icon: 2, time: 500});
                        }
                    }
                });
            },
            layer.close()
        );
    }

    //移除管理员
    function removeRole(uid) {
        layer.confirm(
            '确定要移除吗？',
            {icon: 3, title: '移除管理员'},
            function () {
                $.ajax({
                    url: '${webapp}/userManager/setRole',
                    async: true,
                    data: {
                        "uid": uid,
                        "role": 0
                    },
                    success: function (res) {
                        if (res === 'success') {
                            layer.msg('移除成功',
                                {icon: 1, time: 500}
                                , function () {
                                    window.location.replace('${webapp}/userManager/role/0');
                                }
                            );
                        }
                        if (res === 'fail') {
                            layer.msg('移除失败', {icon: 2, time: 500});
                        }
                    }
                });
            }
        );
        layer.close()
    }

</script>
</body>
</html>
