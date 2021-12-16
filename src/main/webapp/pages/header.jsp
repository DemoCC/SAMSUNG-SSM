<%--
  Created by IntelliJ IDEA.
  User: KLX
  Date: 2021-5-29
  Time: 下午 9:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<head>
    <title></title>
    <script src="${webapp}/static/js/jquery.js"></script>
    <script src="${webapp}/static/bootstrap-3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${webapp}/static/bootstrap-3.4.1/css/bootstrap.min.css">
</head>
<!-- 头部导航栏 -->
<header class="headerBox">
    <%-- logo--%>
    <a href="${webapp}/">
        <img src="${webapp}/static/img/navhead/samsung-logo.svg" class="logo" alt="图片加载失败">
    </a>

    <ul id="ul_nav" class="ul_nav">
        <li><a href="${webapp}/product/mobile" class="navtips">手机/平板 </a></li>
        <li><a href="${webapp}/product/wear" class="navtips">穿戴/音乐 </a></li>
        <li><a href="${webapp}/product/houseHoldElect" class="navtips">家电/智家 </a></li>
        <li><a href="${webapp}/product/office" class="navtips">办公/电脑 </a></li>

        <li class="li_galaxy5G"><a href="${webapp}/product/network/5G" class="navtips">Galaxy&nbsp;5G </a></li>
        <c:if test="${sessionScope.userInfo != null}">
            <li><a href="${webapp}/myCart/${sessionScope.userInfo.id}" class="navtips">购物车 </a></li>
        </c:if>
        <c:choose>
            <c:when test="${sessionScope.userInfo == null}">
                <li id="li_login"><a href="${webapp}/pages/login.jsp" class="navtips">登录/注册</a></li>
            </c:when>
            <c:otherwise>
                <li id="li_login">
                    <a href="${webapp}/user/personalCenter" class="navtips">${sessionScope.userInfo.name}</a>
                </li>
                <li>
                    <a href="${webapp}/user/logout" class="a_logout">
                        <img src="${webapp}/static/img/other/logout.svg" alt="图片加载失败">
                    </a>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>
</header>
<script type="text/javascript">

</script>
