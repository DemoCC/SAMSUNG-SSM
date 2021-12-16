<%@ page import="com.klx.samsung.domain.User" %>
<%--
  Created by IntelliJ IDEA.
  User: KLX
  Date: 2021-5-29
  Time: 下午 10:42
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
    <title>购物车</title>
    <script src="${webapp}/static/js/jquery.js" type="text/javascript"></script>
    <script src="${webapp}/static/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${webapp}/static/css/header.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/css/cart.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/layui/css/layui.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/css/link_list.css" type="text/css"/>
    <link rel="shortcut icon" href="${webapp}/static/img/navhead/samsung_logo2.png"/>
</head>
<body>
<div id="header1">  <!--导入头部jsp--> </div>
<c:choose>
    <c:when test="${sessionScope.userInfo == null}">
        <div class="content_logout">
            <h1>你还未登录</h1>
            <a href="${webapp}/pages/login.jsp">去登陆></a>
        </div>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${cartItemList.size() == 0}">
                <div class="content">
                    <img src="${webapp}/static/img/cart/cart.svg" alt="图片加载失败">
                    <p>您的购物车还没有商品</p>
                    <a href="${webapp}/">立即选购</a>
                </div>
            </c:when>
            <c:otherwise>
                <%--显示未完成的订单--%>
                <div class="contentBox">
                    <h2>您的购物车信息</h2>
                    <div class="cart_itemHead">
                        <ul class="ul_head">
                            <li>商品信息</li>
                            <li>购买数量</li>
                            <li>总价</li>
                            <li>操作</li>
                        </ul>
                    </div>
                    <c:forEach var="cartItem" items="${cartItemList}" varStatus="status">
                        <div class="cart_item">
                            <div class="layui-row layui-col-space1">
                                <div class="layui-col-md3">
                                    <div class="grid-demo grid-demo-bg1">
                                        <a href="${webapp}/product/productInfo/${cartItem.pid}" class="a_productName">
                                            <img src="${webapp}/static/img/products/${cartItem.product.url}"
                                                 alt="图片加载失败">
                                            <span>${cartItem.product.name}</span>
                                        </a>
                                    </div>
                                </div>
                                <div class="layui-col-md3">
                                    <div class="grid-demo grid-demo-bg">
                                        <span class="span_quantity">×${cartItem.quantity}</span>
                                    </div>
                                </div>
                                <div class="layui-col-md3">
                                    <div class="grid-demo grid-demo-bg">
                                        <span class="span_totalMoney">￥${cartItem.totalMoney}</span>
                                    </div>
                                </div>
                                <div class="layui-col-md3">
                                    <div class="grid-demo grid-demo-bg">
                                        <span onclick="deleteItem(${cartItem.id});" class="a_delete">删除</span>
                                    </div>
                                </div>
                                    <%--隐藏的id--%>
                                <span style="display: none" id="val_uid">${sessionScope.userInfo.id}</span>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="settlementFoot">
                        <span id="clearAll" onclick="clearCart(${sessionScope.userInfo.id});">清空购物车</span>
                        <span>
                        商品总数量：<span id="productTotal">${productTotal}</span>
                    </span>
                        <span>
                        总价：￥<span id="totalMoney">${totalMoney}</span>
                    </span>
                        <span id="settlement">结算</span>
                    </div>
                </div>
                <div id="payDiv" style="display: none; padding: 10px 10px">
                    <h1 align="center">支持微信支付宝付款</h1>
                    <div class="aliPay">
                        <img src="${webapp}/static/img/pay/aliPay.jpg" alt="图片加载失败">
                    </div>
                    <div class="weChatPay">
                        <img src="${webapp}/static/img/pay/weChatPay.png" alt="图片加载失败">
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
<div id="link_list"> <!-- 导入link_list.html --></div>
</body>
<script type="text/javascript">
    $(function () {
        // 导入header.html
        $("#header1").load("${webapp}/pages/header.jsp");
        // 导入header.html
        $("#link_list").load("${webapp}/pages/link_list.jsp");

        //获取商品总数量
        const productTotal = $("#productTotal").text();
        //获取用户id
        const uid = $("#uid_span").text();
    });

    //删除购物车商品
    function deleteItem(itemId) {
        layer.confirm(
            '确定要删除吗？',
            {icon: 3, title: "删除商品"},
            function () {
                $.ajax({
                    url: '${webapp}/myCart/deleteCartItem?id=' + itemId,
                    type: 'post',
                    async: true,
                    success: function (res) {
                        if (res === "success") {
                            layer.msg('删除成功', {icon: 1, time: 400},
                                function () {
                                    window.location.replace("${webapp}/myCart/${sessionScope.userInfo.id}");
                                });
                        }
                        if (res === "fail") {
                            layer.msg('删除失败', {icon: 2, time: 400});
                        }
                    }
                });
            });
    }

    //清空购物车
    function clearCart(uid) {
        layer.confirm(
            '确定要清空吗？',
            {icon: 3, title: '清空购物车'},
            function () {
                $.ajax({
                    url: '${webapp}/myCart/clearCart?uid=' + uid,
                    type: 'post',
                    success: function (res) {
                        if (res === "success") {
                            layer.msg(
                                '清空成功', {icon: 1, time: 500},
                                function () {
                                    window.location.replace("${webapp}/myCart/" + uid);
                                }
                            );
                        } else {
                            layer.msg("清空失败", {icon: 2, time: 500});
                        }
                    }
                });
                layer.closeAll()
            });
    }

    //结算
    const totalMoney = $("#totalMoney").text();
    $("#settlement").click(function () {
        layer.open({
            type: 1,
            area: ['1000px', '550px'],
            offset: 'auto',
            title: '请支付',
            content: $("#payDiv"),
            end: function () {
                $('#payDiv').css({'display': 'none'});
                return false;
            }
        });
        // $.ajax({
        //     url: '/SAMSUNG_WEB/orderServlet?action=createOrder',
        //     type: 'get',
        //     data: {
        //         uid: uid,
        //         productTotal: productTotal,
        //         orderMoney: totalMoney
        //     },
        //     dataType: 'json',
        //     success: function (data) {
        //         if (data === "SUCCESS"){
        //             layer.msg( "结算成功", {icon: 1},
        //                 function () {
        //                     $.ajax({
        //                         url: '/SAMSUNG_WEB/cartServlet?action=clearCart',
        //                         type: 'post',
        //                         data: {
        //                             uid: uid
        //                         }
        //                     })
        //                 }
        //             )
        //         }
        //         if(data === "FAILED"){
        //             layer.msg( "结算失败", {icon: 2})
        //         }
        //     }
        // })
    });

</script>
</html>

