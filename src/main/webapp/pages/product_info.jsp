<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
    <title>商品信息</title>
    <script src="${webapp}/static/js/jquery.js" type="text/javascript"></script>
    <script src="${webapp}/static/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${webapp}/static/layui/css/layui.css">
    <link rel="stylesheet" href="${webapp}/static/css/product_info.css">
    <link rel="stylesheet" href="${webapp}/static/css/header.css">
</head>
<body>
<div id="header1"><!--导入头部jsp--></div>
<%--中部--%>
<div class="body_center">
    <div class="layui-row">
        <%--产品大图--%>
        <div class="layui-col-xs6">
            <div class="grid-demo grid-demo-bg1">
                <img src="${webapp}/static/img/products/${product[0].url}" alt="图片加载失败">
            </div>
        </div>
        <%--右边信息--%>
        <div class="layui-col-xs6">
            <div class="grid-demo grid-demo-bg2">
                <h1>${product[0].name}</h1><%--商品名--%>
                <h4>颜色</h4>
                <p>${product[0].color}</p>
                <c:choose>
                    <c:when test="${product[0].network!=null}">
                        <h4>网络类型</h4>
                        <p>${product[0].network}</p>
                    </c:when>
                </c:choose>
                <h4>配送地址</h4>
                <span class="span_address">${sessionScope.userInfo.address}</span>
                <div class="buyNumBox">
                    <div id="span_add" class="span_add" onclick="addNum();">+</div>
                    <div id="quantity" class="quantity">1</div>
                    <div id="span_reduce" class="span_reduce" onclick="reduceNum();">-</div>
                </div>
                <h4>总价：</h4>
                <div id="totalMoney" class="totalMoney">${product[0].price}</div>
                <%--隐藏数据--%>
                <input id="input_uid" type="hidden" value="${sessionScope.userInfo.id}">
                <input id="input_pid" type="hidden" value="${product[0].id}">
                <c:choose>
                    <c:when test="${sessionScope.userInfo == null}">
                        <a href="${webapp}/pages/login.jsp">您还没有登录，请登录</a>
                    </c:when>
                    <c:otherwise>
                        <button id="btn_addCart" onclick="addToCart();">加入购物车</button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<%-------------------------------------------------------------------------------------------%>
</body>
<script type="text/javascript">
    $(function () {
        $("#header1").load("${webapp}/pages/header.jsp");
    });

    //点击添加购物车
    function addToCart() {
        const uid = $("#input_uid").val();
        const pid = $("#input_pid").val();
        const quantity = $("#quantity").text();
        const totalMoney = $("#totalMoney").text();
        $.ajax({
            url: '${webapp}/myCart/addToCart',
            type: 'POST',
            data: {
                "uid": uid,
                "pid": pid,
                "quantity": quantity, //购买数量
                "totalMoney": totalMoney
            },
            success: function (res) {
                if (res === 'success') {
                    layer.msg(
                        '添加成功', {icon: 1, time: 1000}
                    )
                }
                if (res === 'fail') {
                    layer.msg(
                        "添加失败", {icon: 2, time: 1000}
                    );
                }
            }
        });
    }

    const obj = $("#quantity");
    const obj2 = $("#totalMoney");
    let quantity = parseInt(obj.text());
    let totalMoney = parseInt(obj2.text());

    //增加购买数量
    function addNum() {
        if (quantity === 5) {
            layer.msg("最多只能添加5台", {icon: 2}, {time: 500});
            return false;
        }
        quantity = quantity + 1;
        const totalMoney1 = quantity * totalMoney;
        obj.text(quantity);
        obj2.text(totalMoney1);

    }

    //减少购买数量
    function reduceNum() {
        if (quantity > 1) {
            quantity = quantity - 1;
            const totalMoney2 = quantity * totalMoney;
            obj.text(quantity);
            obj2.text(totalMoney2);
        }
    }

</script>
</html>
