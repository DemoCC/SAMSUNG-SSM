<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-5-30
  Time: 下午 5:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>5G</title>
    <link rel="stylesheet" type="text/css" href="${webapp}/static/css/header.css"/>
    <link rel="stylesheet" type="text/css" href="${webapp}/static/css/product_fiveG.css"/>
    <link rel="stylesheet" type="text/css" href="${webapp}/static/css/bottom.css"/>
    <link rel="stylesheet" type="text/css" href="${webapp}/static/css/link_list.css"/>
    <link rel="stylesheet" type="text/css" href="${webapp}/static/bootstrap-3.4.1/css/bootstrap.min.css">
    <link rel="shortcut icon" type="text/css" href="${webapp}/static/img/head/samsung_logo2.png"/>
    <script src="${webapp}/static/js/jquery.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div id="header1">  <!-- 导入头部jsp --> </div>

<p class="p1">
    与4G相比，5G上行速度要快得多，其拥有双向大带宽、低时延等特点，可以充分提升用户的体验。
    依靠未来完善的5G网络，我们不仅可以在全球范围实时现场直播大型活动和演出，
    还可以满足您对商业化、生活化的娱乐、游戏、购物等小型4K直播需求，
    让您在享受高清流畅画面的同时，体验视频、连麦等精彩的即时互动。
</p>

<div class="big_img_box">
    <img src="${webapp}/static/img/5G/5GKV2_021.webp" alt="图片加载失败">
</div>

<!-- 5G设备推荐 -->
<div class="phone_box">
    <h1 align="center">5G设备</h1>
    <c:choose>
        <c:when test="${pListWithPage.list.size() == 0}">
            <div class="jumbotron">
                <h2>暂无商品</h2>
                <p>新品即将上线</p>
                <p><a class="btn btn-primary btn-lg" href="#" role="button">看看其他</a></p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="product" items="${pListWithPage.list}" varStatus="status">
                <div class="phoneListItem">
                    <a href="${webapp}/product/productInfo/${product.id}">
                        <img src="${webapp}/static/img/products/${product.url}" alt="图片加载失败">
                        <p>${product.name}</p>
                        <h4>￥${product.price}</h4>
                    </a>
                </div>
            </c:forEach>
            <%--分页--%>
            <div class="row">
                    <%--分页信息 --%>
                <div class="col-md-4 col-md-offset-2" id="page_info">
                    <p> 当前页码：<span class="pageInfo">${pListWithPage.pageNum}</span></p>
                    <p>
                        一共<span class="pageInfo">${pListWithPage.pages}</span>页，
                        <span class="pageInfo">${pListWithPage.total}</span>条数据。
                    </p>
                </div>
                    <%-- 分页导航 --%>
                <div class="col-md-5" id="page_nav">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                                <%--首页上一页--%>
                            <c:choose>
                                <c:when test="${pListWithPage.hasPreviousPage == true}">
                                    <li id="first_page"><a
                                            href="${webapp}/product/network/${pListWithPage.list[0].network}?pageNumber=1">首页</a>
                                    </li>
                                    <li id="pre_page">
                                        <a href="${webapp}/product/network/${pListWithPage.list[0].network}?pageNumber=${pListWithPage.pageNum-1}"
                                           aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li id="first_page" class="disabled"><a>首页</a></li>
                                    <li id="pre_page" class="disabled">
                                        <a aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                                <%--分页导航--%>
                            <c:forEach var="currentPage" items="${pListWithPage.navigatepageNums}" varStatus="status">
                                <c:choose>
                                    <c:when test="${currentPage == pListWithPage.pageNum}">
                                        <li class="active">
                                            <a href="${webapp}/product/network/${pListWithPage.list[0].network}?pageNumber=${currentPage}">
                                                    ${currentPage}
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li>
                                            <a href="${webapp}/product/network/${pListWithPage.list[0].network}?pageNumber=${currentPage}">
                                                    ${currentPage}
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                                <%--末页下一页--%>
                            <c:choose>
                                <c:when test="${pListWithPage.hasNextPage == true}">
                                    <li>
                                        <a href="${webapp}/product/network/${pListWithPage.list[0].network}?pageNumber=${pListWithPage.pageNum+1}"
                                           aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="${webapp}/product/network/${pListWithPage.list[0].network}?pageNumber=${pListWithPage.pages}">末页</a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="disabled">
                                        <a aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                    <li class="disabled"><a>末页</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </nav>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- 底部各种链接 -->
<div id="link_list">
    <!-- link_list.html -->
</div>

</body>

<script type="text/javascript">
    $(function () {
        // 导入header.html
        $("#header1").load("${webapp}/pages/header.jsp");
        // 导入link_list.html
        $("#link_list").load("${webapp}/pages/link_list.jsp");
    });
</script>
</html>
