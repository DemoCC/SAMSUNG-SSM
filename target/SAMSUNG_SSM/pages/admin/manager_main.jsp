<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<html>
<head>
    <title>后台管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script src="${webapp}/static/js/jquery.js" type="text/javascript"></script>
    <script src="${webapp}/static/layui/layui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${webapp}/static/layui/css/layui.css" type="text/css"/>
    <link rel="stylesheet" href="${webapp}/static/css/manager_main.css" type="text/css"/>
    <link rel="shortcut icon" href="${webapp}/static/img/navhead/samsung_logo2.png" type="text/css"/>
</head>
<body>
<c:choose>
    <c:when test="${sessionScope.userInfo == null}">
        <%response.sendRedirect("/pages/login.jsp"); %>
    </c:when>
    <c:otherwise>
        <div class="layui-layout layui-layout-admin">
            <div class="layui-header">
                <div class="layui-logo layui-hide-xs layui-bg-black">后台管理</div>
                <ul class="layui-nav layui-layout-left">
                    <!-- 移动端显示 -->
                    <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                        <i class="layui-icon layui-icon-spread-left"></i>
                    </li>
                        <%--顶部导航栏--%>
                    <li class="layui-nav-item layui-hide-xs" id="nav_queryInfo">
                        <a onclick="getNormalUser();">信息查询 </a>
                    </li>
                    <li class="layui-nav-item layui-hide-xs">
                        <a href="${webapp}/">首页 </a>
                    </li>
                </ul>
                    <%--顶部导航栏右部--%>
                <ul class="layui-nav layui-layout-right">
                    <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                        <a href="#">
                            <c:choose>
                                <c:when test="${sessionScope.userInfo.headImgUrl == null || sessionScope.userInfo.headImgUrl == ''}">
                                    <img src="${webapp}/static/img/headImg/sex1.png" class="layui-nav-img" alt="图片加载失败">
                                </c:when>
                                <c:otherwise>
                                    <img src="${webapp}/static/img/headImg/${sessionScope.userInfo.headImgUrl}"
                                         class="layui-nav-img" alt="图片加载失败">
                                </c:otherwise>
                            </c:choose>
                                ${sessionScope.userInfo.name}
                        </a>
                        <dl class="layui-nav-child">
                            <dd><a href="${webapp}/user/personalCenter">个人信息</a></dd>
                            <dd><a href="${webapp}/user/logout">退出</a></dd>
                        </dl>
                    </li>
                </ul>
            </div>
                <%-- 侧边栏 --%>
            <div class="layui-side layui-bg-black">
                <div class="layui-side-scroll">
                    <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
                    <ul class="layui-nav layui-nav-tree" lay-filter="test">
                        <li class="layui-nav-item layui-nav-itemed">
                            <a>用户管理</a>
                            <dl class="layui-nav-child">
                                <dd id="dd_normal"><a onclick="getNormalUser();">普通用户</a></dd>
                                <dd id="dd_admin"><a onclick="getAdmins()">管理员</a></dd>
                                <dd id="dd_dev"><a onclick="getDeveloped()">开发者</a></dd>
                            </dl>
                        </li>
                        <li class="layui-nav-item">
                            <a href="#">产品管理</a>
                            <dl class="layui-nav-child">
                                <dd><a onclick="addProduct();">添加产品</a></dd>
                                <dd id="dd_mobile"><a onclick="getPhone();">手机</a></dd>
                                <dd id="dd_wear"><a onclick="getWear();">穿戴</a></dd>
                                <dd id="dd_home"><a onclick="getHomeEle();">家电</a></dd>
                                <dd id="dd_office"><a onclick="getOffice();">办公</a></dd>
                                <dd id="dd_other"><a onclick="getOther();">其他</a></dd>
                            </dl>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="layui-body">
                <div id="queryInfo">
                    <form method="get">
                        <div class="layui-input-inline">
                            <input type="text" name="type" id="input_network" placeholder="请输入网络类型" class="layui-input">
                        </div>
                        <div class="layui-input-inline">
                            <input type="number" name="price" id="input_price" placeholder="请输入价格" class="layui-input">
                        </div>
                        <input type="button" class="layui-btn" id="btn_query" onclick="getProductByMore();" value="查询"/>
                    </form>
                </div>
                <iframe name="iframe" id="iframe" src="${webapp}/userManager/role/0"></iframe>
            </div>
            <div class="layui-footer">
                <!-- 底部固定区域 -->
                Copyright© 1995-2021 三星（中国）投资有限公司 版权所有
            </div>
        </div>
    </c:otherwise>
</c:choose>
</body>
<script type="text/javascript">

    const iframe = document.getElementById("iframe");

    $(function () {
        $("#dd_normal").addClass("layui-this");    //进入页面把普通用户列和信息查询导航设置为选中状态
        $("#nav_queryInfo").addClass("layui-this")
    });

    // ----------------------用户--------------------------------- //
    //显示普通用户
    function getNormalUser() {
        iframe.src = "${webapp}/userManager/role/0";
    }

    //点击管理员将iframe改为显示管理员
    function getAdmins() {
        iframe.src = "${webapp}/userManager/role/1";
    }

    //显示开发者:
    function getDeveloped() {
        iframe.src = "${webapp}/userManager/role/3";
    }

    //所有用户
    function getAllUsers() {
        iframe.src = "${webapp}/userManager/allUser";
    }

    // ----------------------产品---------------------------- //
    //查询手机
    function getPhone() {
        iframe.src = "${webapp}/productManager/手机";
    }

    //查询穿戴产品
    function getWear() {
        iframe.src = "${webapp}/productManager/穿戴";
    }

    //查询家电
    function getHomeEle() {
        iframe.src = "${webapp}/productManager/家电";
    }

    //查询办公产品
    function getOffice() {
        iframe.src = "${webapp}/productManager/办公";
    }

    //查询其他产品
    function getOther() {
        iframe.src = "${webapp}/productManager/其他";
    }

    //去添加产品
    function addProduct() {
        iframe.src = "${webapp}/pages/admin/product_add.jsp";
    }

    //点击多条件查询的查询按钮
    function getProductByMore() {
        if (!checking_form()) {
            return false;
        }
        const network = $("#input_network").val();
        const price = $("#input_price").val();
        iframe.src = "${webapp}/productManager/getProductByMore?network=" + network + "&price=" + price;
    }

    //表单数据校验
    function checking_form() {
        const type = $("#input_network").val();
        const price = $("#input_price").val();
        if ((type === "" || type === null) || (price === "" || price === null)) {
            showCheckMsg("#input_network", "error", "请输入查询条件");
            return false;
        }
        return true;
    }

    //显示校验结果
    function showCheckMsg(ele, status, msg) {
        $(ele).parent().removeClass("layui-form-danger layui-form-checked");    //清空表单样式
        if ("success" === status) {      //如果校验状态为成功
            $(ele).parent().addClass("layui-form-checked");
        } else if ("error" === status) {
            $(ele).addClass("layui-form-danger");
            layer.msg(msg, {
                offset: 't',    //位置，弹出在顶部
                // icon: 2,    //图标
                anim: 6     //动画
            });
        }
    }

    layui.use(['element', 'layer', 'util'], function () {
        var element = layui.element
            , layer = layui.layer
            , util = layui.util
            , $ = layui.$;

        //头部事件
        util.event('lay-header-event', {
            //左侧菜单事件
            menuLeft: function (othis) {
                layer.msg('展开左侧菜单的操作', {icon: 0});
            }
            , menuRight: function () {
                layer.open({
                    type: 1
                    , content: '<div style="padding: 15px;">处理右侧面板的操作</div>'
                    , area: ['260px', '100%']
                    , offset: 'rt' //右上角
                    , anim: 5
                    , shadeClose: true
                });
            }
        });
    });

</script>
</html>
