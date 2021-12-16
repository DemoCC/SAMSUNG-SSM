<%--
  Created by IntelliJ IDEA.
  User: KLX
  Date: 21-12-13
  Time: 下午 2:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<html>
<head>
    <title>Title</title>
    <script src="${webapp}/static/js/jquery.js" type="text/javascript"></script>
    <script src="${webapp}/static/bootstrap-3.4.1/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${webapp}/static/layui/layui.js" type="text/javascript"></script>
    <link href="${webapp}/static/layui/css/layui.css" rel="stylesheet">
    <link href="${webapp}/static/bootstrap-3.4.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<c:choose>
    <c:when test="${pageInfo.list.size() == 0}">
        <div class="jumbotron">
            <h3>暂无商品</h3>
        </div>
    </c:when>
    <c:otherwise>
        <blockquote class="layui-elem-quote">${pageInfo.list[0].type}</blockquote>
        <table class="layui-table" lay-even lay-skin="nob">
            <colgroup>
            </colgroup>
            <thead>
            <tr>
                <th>ID</th>
                <th>产品名称</th>
                <th>价格</th>
                <th>类型</th>
                <th>颜色</th>
                <th>网络类型</th>
                <th>库存</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="product" items="${pageInfo.list}" varStatus="status">
                <tr>
                    <td>${product.id}</td>
                    <td>${product.name}</td>
                    <td>${product.price}</td>
                    <td id="td_type">${product.type}</td>
                    <td>${product.color}</td>
                    <td>${product.network}</td>
                    <td>${product.stock}</td>
                    <td>
                        <a type="button" id="a_lookProduct" class="layui-btn layui-btn-sm layui-btn-normal"
                           onclick="openLookDiv(${product.id});">
                            查看
                        </a>
                        <a type="button" id="a_update" class="layui-btn layui-btn-sm layui-btn-warm"
                           onclick="openUpdateDiv(${product.id});">
                            修改
                        </a>
                        <a id="btn_delProduct" class="layui-btn layui-btn-sm layui-btn-danger"
                           onclick="deleteProduct(${product.id})">
                            删除
                        </a>
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
                            <li><a href="${webapp}/productManager/${pageInfo.list[0].type}?pageNumber=1">首页</a></li>
                            <li>
                                <a href="${webapp}/productManager/${pageInfo.list[0].type}?pageNumber=${pageInfo.pageNum-1}"
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
                                    <a href="${webapp}/productManager/${pageInfo.list[0].type}?pageNumber=${currentPage}">${currentPage}
                                        <span class="sr-only"></span>
                                    </a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li>
                                    <a href="${webapp}/productManager/${pageInfo.list[0].type}?pageNumber=${currentPage}">${currentPage}
                                        <span class="sr-only"></span></a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                        <%--下一页、末页--%>
                    <c:choose>
                        <c:when test="${pageInfo.hasNextPage == true}">
                            <li>
                                <a href="${webapp}/productManager/${pageInfo.list[0].type}?pageNumber=${pageInfo.pageNum+1}"
                                   aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                            <li>
                                <a href="${webapp}/productManager/${pageInfo.list[0].type}?pageNumber=${pageInfo.pages}">末页</a>
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
        <input type="hidden" id="pageNumber" value="${pageInfo.pageNum}">
    </c:otherwise>
</c:choose>
</body>
</html>
