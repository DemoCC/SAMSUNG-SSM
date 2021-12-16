<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-17
  Time: 下午 5:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<style>
    body {
        overflow: hidden;
    }

    .jumbotron {
        margin: 20px;
        padding: 20px;
    }

    .layui-input {
        width: 200px !important;
    }

    .layui-form select {
        width: 200px;
    }

    .span_look {
        line-height: 2.6;
        background: #f1f1f1;
        padding: 5px;
        border-radius: 5px;
    }

    #look_img {
        width: 200px;
        margin: 50px;
    }

</style>
<html>
<head>
    <title></title>
    <script src="${webapp}/static/js/jquery.js" type="text/javascript"></script>
    <script src="${webapp}/static/bootstrap-3.4.1/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${webapp}/static/layui/layui.js" type="text/javascript"></script>
    <link href="${webapp}/static/layui/css/layui.css" rel="stylesheet">
    <link href="${webapp}/static/bootstrap-3.4.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<c:choose>
    <c:when test="${pageInfo.list.size() == 0}">
        <%-- 巨幕--%>
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
<%--查看产品模态框--%>
<div id="div_look" style="display: none">
    <div class="layui-row">
        <div class="layui-col-xs6">
            <div class="grid-demo grid-demo-bg1">
                <div class="layui-form-item">
                    <img id="look_img" alt="图片加载失败">
                </div>
            </div>
        </div>
        <div class="layui-col-xs6">
            <div class="grid-demo">
                <div class="layui-form-item">
                    <label class="layui-form-label">ID：</label>
                    <div class="layui-input-inline">
                        <span class="span_look" id="look_pid"></span>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">名称：</label>
                    <div class="layui-input-inline">
                        <span class="span_look" id="look_name"></span>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">价格：</label>
                    <div class="layui-input-inline">
                        <span class="span_look" id="look_price"></span>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">颜色：</label>
                    <span class="span_look" id="look_color"></span>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">类型：</label>
                    <span class="span_look" id="look_type"></span>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">网络：</label>
                    <span class="span_look" id="look_network"></span>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">库存：</label>
                <span class="span_look" id="look_stock"></span>
            </div>
        </div>
    </div>
</div>
<%--修改产品模态框--%>
<div id="div_update" style="display: none">
    <form class="layui-form" id="form_update" enctype="multipart/form-data">
        <span id="pid" class="hidden"></span>
        <div class="layui-form-item">
            <label class="layui-form-label">名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" id="edit_name" required lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">价格</label>
            <div class="layui-input-inline">
                <input type="number" name="price" id="edit_price" required lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">颜色</label>
            <div class="layui-input-inline">
                <input type="text" name="color" id="edit_color" required lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">类型</label>
            <div class="layui-input-inline">
                <select name="productType" id="select_type" lay-verify="required">
                    <option value="other">其他</option>
                    <option value="mobile">手机</option>
                    <option value="wear">穿戴</option>
                    <option value="home">家电</option>
                    <option value="office">办公</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">网络</label>
            <div class="layui-input-inline">
                <select name="network" lay-verify="required" id="select_network">
                    <option value="/">/</option>
                    <option value="4G">4G</option>
                    <option value="5G">5G</option>
                    <option value="WIFI6">WIFI6</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">库存</label>
            <div class="layui-input-inline">
                <input type="number" name="stock" id="edit_stock" required lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">图片</label>
            <div class="layui-input-inline">
                <input type="file" name="productImg" id="edit_img" required lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
    </form>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" id="btn_update">更新</button>
            <input type="hidden" id="val_pageNum" value="${pageInfo.pageNum}">
        </div>
    </div>
</div>
<script type="text/javascript">
    function deleteProduct(pid) {
        layer.confirm(
            "确定要删除吗？", {icon: 3},
            function () {
                const productType = $("#td_type").text();
                const pageNumber = $("#pageNumber").val();
                $.ajax({
                    url: '${webapp}/productManager/deleteProduct?id=' + pid,
                    type: 'POST',
                    success: function (res) {
                        if (res === "success") {
                            layer.msg("删除成功", {icon: 1, time: 500},
                                function () {
                                    window.location.replace("${webapp}/productManager/" + productType + '?pageNumber=' + pageNumber);
                                }
                            );
                        } else if (res === "fail") {
                            layer.msg("删除失败", {icon: 2, time: 500});
                        }
                    }
                });
            }
        );
    }

    //弹出修改信息框
    function openUpdateDiv(pid) {
        //查询一下需要回显的产品
        reviewProduct(pid);
        layer.open({
            type: 1,
            title: '修改商品',
            area: ['350px', '400px'], //宽、高
            shadeClose: true, //点击遮罩关闭
            content: $("#div_update")
        });
    }

    //根据id查询产品然后回显
    function reviewProduct(pid) {
        $.ajax({
            url: '${webapp}/productManager/getProductById?pid=' + pid,
            type: 'GET',
            success: function (res) {
                $("#pid").text(pid);
                $("#edit_name").attr("placeholder", res.name);
                $("#edit_price").attr("placeholder", res.price);
                $("#edit_color").attr("placeholder", res.color);
                $("select[name='productType']").val(res.type);
                $("select[name='network']").val(res.network);
                $("#edit_stock").attr("placeholder", res.stock);
            }
        });
    }

    //点击确定更新按钮
    $("#btn_update").click(function () {
        //点击添加后先进行校验
        if (!checking_form()) {
            return false;
        }

        //创建DataForm传输数据
        const form = document.querySelector("#form_update");
        const formData = new FormData(form);

        const pid = $("#pid").text();
        const pName = $("#edit_name").val();
        const price = $("#edit_price").val();
        const color = $("#edit_color").val();
        let type = $("#select_type").val();
        const network = $("#select_network").val();
        const stock = $("#edit_stock").val();
        const productImg = $("#edit_img").val();

        formData.append("pid", pid);
        formData.append("pName", pName);
        formData.append("price", price);
        formData.append("color", color);
        formData.append("type", type);
        formData.append("network", network);
        formData.append("stock", stock);
        formData.append("productImg", productImg);

        //发送更新请求
        $.ajax({
            url: '${webapp}/productManager/updateProduct',
            type: 'POST',
            enctype: 'multipart/form-data',
            contentType: false,
            processData: false,
            data: formData,
            success: function (res) {
                const pageNumber = $("#val_pageNum").val();
                if (res === "success") {
                    layer.msg(
                        '更新成功', {icon: 1, time: 1000},
                        function () {
                            if (type === "mobile") {
                                type = "手机"
                            } else if (type === "wear") {
                                type = "穿戴"
                            } else if (type === "home") {
                                type = "家电"
                            } else if (type === "office") {
                                type = "办公"
                            } else if (type === "other") {
                                type = "其他"
                            }
                            window.location.replace("${webapp}/productManager/" + type + "?pageNumber=" + pageNumber);
                        }
                    );
                } else {
                    layer.msg('更新失败', {icon: 2, time: 1000});
                }
            }
        });

    });

    // 查看产品模态框
    function openLookDiv(pid) {
        //先获取产品信息
        lookProduct(pid);
        layer.open({
            type: 1,
            title: '商品详情',
            area: ['650px', '400px'], //宽、高
            shadeClose: true, //点击遮罩关闭
            content: $("#div_look")
        });
    }

    //查看产品
    function lookProduct(pid) {
        $.ajax({
            url: '${webapp}/productManager/getProductById?pid=' + pid,
            type: 'GET',
            success: function (res) {
                $("#look_pid").text(pid);
                $("#look_name").text(res.name);
                $("#look_price").text(res.price);
                $("#look_color").text(res.color);
                $("#look_type").text(res.type);
                $("#look_network").text(res.network);
                $("#look_stock").text(res.stock);
                $("#look_img").attr("src", "${webapp}/static/img/products/" + res.url);
            }
        });
    }

    // 表单数据验证
    function checking_form() {
        //验证产品名
        const productName = $("#edit_name").val();
        const reg = /(^[a-zA-Z0-9]{5,18}$)|(^[\u2E80-\u9FFF]{2,8})/;
        if (!reg.test(productName)) {    //如果验证不通过
            showCheckMsg("#edit_name", "error", "商品名为5-18位字母数字或2-8位汉字");
            $("#edit_name").focus();
            return false;   //校验不成功直接返回
        } else {
            showCheckMsg("#edit_name", "success", "");
        }
        //校验价格
        const price = $("#edit_price").val();
        if (price === "" || price === undefined) {
            showCheckMsg("#edit_price", "error", "请输入价格");
            $("#edit_price").focus();
            return false;
        }
        if (price.toString().substring(0, 1) === "0" || price.length > 5) {
            showCheckMsg("#edit_price", "error", "价格不能超过5位数,不能以0开头");
            $("#edit_price").focus();
            return false;
        } else {
            showCheckMsg("#edit_price", "success", "");
        }
        //再校验颜色
        const color = $("#edit_color").val();
        const reg_tel = /(^[a-zA-Z]{5,10}$)|(^[\u2E80-\u9FFF]{2,8})/;
        if (!reg_tel.test(color)) {
            showCheckMsg("#edit_color", "error", "5-10位英文或者2-8位汉字");
            $("#edit_color").focus();
            return false;
        } else {
            showCheckMsg("#edit_color", "success", "");
        }

        //校验库存
        const stock = $("#edit_stock").val();
        const reg_stock = /^[0-9]{1,8}$/;
        if (stock === "" || stock === undefined) {
            showCheckMsg("#edit_stock", "error", "请输入库存");
            $("#edit_stock").focus();
            return false;
        }
        if (stock.toString().substring(0, 1) === "0") {
            showCheckMsg("#edit_stock", "error", "不能以0开头");
            $("#edit_stock").focus();
            return false;
        }
        if (stock.length > 8) {
            showCheckMsg("#edit_stock", "error", "不能超过8位数");
            $("#edit_stock").focus();
            return false;
        }
        if (!reg_stock.test(stock)) {
            showCheckMsg("#edit_stock", "error", "不能包含小数点");
            $("#edit_stock").focus();
            return false;
        } else {
            showCheckMsg("#edit_stock", "success", "");
        }
        //校验图片
        const productImg = $("#edit_img").val();
        if (productImg == null || productImg === "") {
            showCheckMsg("#edit_img", "error", "请选择图片");
            $("#edit_img").focus();
            return false;
        } else {
            showCheckMsg("#edit_img", "success", "");
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

</script>
</html>
