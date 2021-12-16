<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>三星商城</title>
    <script src="${webapp}/static/js/jquery.js" type="text/javascript"></script>
    <script src="${webapp}/static/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${webapp}/static/layui/css/layui.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/css/index.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/css/header.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/css/link_list.css" type="text/css"/>
    <link rel="shortcut icon" href="${webapp}/static/img/head/samsung_logo2.png" type="text/css"/>
</head>
<body>

<div id="out1">
    <div id="header1"> <!-- 导入header.jsp --></div>
    <!-- 轮播图 -->
    <div class="layui-carousel" id="swiperOut" style="overflow: hidden">
        <div carousel-item>
            <div class="swiper-item">
                <img src="${webapp}/static/img/swiper/lunbo_n10.png" alt="图片加载失败">
            </div>
            <div class="swiper-item">
                <img src="${webapp}/static/img/swiper/lunbo_n10_1.png" alt="图片加载失败">
            </div>
            <div class="swiper-item">
                <img src="${webapp}/static/img/swiper/lunbo_n10_3.png" alt="图片加载失败">
            </div>
            <div class="swiper-item">
                <img src="${webapp}/static/img/swiper/lunbo_n10_4.png" alt="图片加载失败">
            </div>
        </div>
    </div>
</div>
<!-- 移动产品展区 -->
<div class="mobileProBox">
    <div class="productListBox">
        <h1 align="center">移动产品</h1>
        <!-- 手机名称列表 -->
        <ul class="ul_nameList">
            <li>
                <a href="${webapp}/product/productInfo/${productList[3].id}">
                    ${productList[3].name}&nbsp;|&nbsp;${productList[4].name}
                </a>
            </li>
            <li>
                <a href="${webapp}/product/productInfo/${productList[7].id}">
                    ${productList[7].name}
                </a>
            </li>
            <li>
                <a href="${webapp}/product/productInfo/${productList[5].id}">
                    ${productList[5].name}&nbsp;|&nbsp;${productList[6].name}
                </a>
            </li>
        </ul>
    </div>
    <!-- 手机图片 -->
    <div class="PhoneImgBox" align="center">
        <img src="${webapp}/static/img/products/${productList[4].url}" class="pImg" alt="图片加载失败">
        <h1>${productList[4].name}</h1>
        <div class="buyBox">
            <h1>
                <a href="${webapp}/product/productInfo/${productList[4].id}" class="buy">
                    立即购买
                </a>
            </h1>
        </div>
    </div>
</div>
<!-- 家电展区 -->
<div class="TVBox">
    <div class="productListBox">
        <h1 align="center">家电/影音</h1>
        <!-- 家电名称列表 -->
        <ul class="ul_nameList">
            <li>
                <a href="${webapp}/product/productInfo/${productList[0].id}">${productList[0].name}</a>
            </li>
            <li>
                <a href="${webapp}/product/productInfo/${productList[1].id}">${productList[1].name}</a>
            </li>
            <li>
                <a href="${webapp}/product/productInfo/${productList[2].id}">${productList[2].name}</a>
            </li>
        </ul>
    </div>
    <div class="homeImgBox" align="center">
        <h1>${productList[2].name}</h1>
        <div class="buyBox">
            <h1>
                <a href="${webapp}/product/productInfo/${productList[2].id}" class="buy">
                    立即购买
                </a>
            </h1>
        </div>
    </div>
</div>
<%----------------------------------------------------------------------------------------------%>
<div class="statement">
    <p>*本网站提供的屏幕和图像内容，是仅为说明目的而展示的模拟画面。
        产品图片以及型号、数据、功能、性能、规格参数、用户界面和其他产品信息等仅供参考，
        三星有可能对上述内容进行改进，具体信息请参照产品实物、产品说明书。
        除非经特殊说明，本网站中所涉及的数据均为三星内部测试结果，涉及的对比均为与三星产品相比较。
    </p>
</div>
<!-- 底部链接 -->
<div id="link_list"> <!-- 导入link_list.html--> </div>

</body>
<script type="text/javascript">
    $(function () {
        // 导入头部html
        $("#header1").load("${webapp}/pages/header.jsp");

        // 导入底部链接html
        $("#link_list").load("pages/link_list.jsp");

        //轮播
        layui.use('carousel', function () {
            var carousel = layui.carousel;
            //建造实例
            carousel.render({
                elem: '#swiperOut',
                width: '100%', //设置容器宽度,
                height: '500',
                interval: '1500',   //轮播间隔时间
                arrow: 'always'     //始终显示箭头
                // anim: 'updown',       //轮播方式
                //,anim: 'updown'  //切换动画方式
            });
        });
    });
</script>
</html>
