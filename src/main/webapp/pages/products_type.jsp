<%@ page import="com.github.pagehelper.PageInfo" %>
<%@ page import="com.klx.samsung.domain.Product" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: KLX
  Date: 2021-6-8
  Time: 下午 3:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<html>
<head>
    <title>
        <c:if test="${pListWithPage.list.size() == 0}">
            暂无商品
        </c:if>
        ${pListWithPage.list[0].type}
    </title>
    <script src="${webapp}/static/js/jquery.js" type="text/javascript"></script>
    <script src="${webapp}/static/layui/layui.js" type="text/javascript"></script>
    <script src="${webapp}/static/bootstrap-3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${webapp}/static/layui/css/layui.css">
    <link rel="stylesheet" href="${webapp}/static/bootstrap-3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="${webapp}/static/css/header.css">
    <link rel="stylesheet" href="${webapp}/static/css/link_list.css">
    <link rel="stylesheet" href="${webapp}/static/css/product_type.css">
</head>
<body>
<div id="header1"><!--导入头部jsp--></div>
<div class="product_content">
    <c:choose>
        <c:when test="${pListWithPage.list.size() == 0}">
            <%-- 巨幕--%>
            <div class="jumbotron">
                <h1>暂无商品</h1>
                <p>新品即将上架</p>
                <p><a class="btn btn-primary btn-lg" href="${webapp}/" role="button">看看其他</a></p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="product" items="${pListWithPage.list}" varStatus="status">
                <a href="${webapp}/product/productInfo/${product.id}">
                    <div class="itemBox">
                        <div><img src="${webapp}/static/img/products/${product.url}" alt="图片加载失败"></div>
                        <p class="p_pName">${product.name}</p>
                        <p class="p_color">${product.color}</p>
                        <p class="p_price">￥${product.price}</p>
                    </div>
                </a>
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
                                            href="${webapp}/product/${pListWithPage.list[0].type}?pageNumber=1">首页</a>
                                    </li>
                                    <li id="pre_page">
                                        <a href="${webapp}/product/${pListWithPage.list[0].type}?pageNumber=${pListWithPage.pageNum-1}"
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
                                            <a href="${webapp}/product/${pListWithPage.list[0].type}?pageNumber=${currentPage}">
                                                    ${currentPage}
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li>
                                            <a href="${webapp}/product/${pListWithPage.list[0].type}?pageNumber=${currentPage}">
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
                                        <a href="${webapp}/product/${pListWithPage.list[0].type}?pageNumber=${pListWithPage.pageNum+1}"
                                           aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="${webapp}/product/${pListWithPage.list[0].type}?pageNumber=${pListWithPage.pages}">末页</a>
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
<!-- 底部链接 -->
<div id="all_link">
    <!-- 导入link_list.jsp -->
</div>
</body>
<script type="text/javascript">
    $(function () {
        $("#header1").load("${webapp}/pages/header.jsp");
        $("#all_link").load("${webapp}/pages/link_list.jsp");
    });

</script>
</html>
