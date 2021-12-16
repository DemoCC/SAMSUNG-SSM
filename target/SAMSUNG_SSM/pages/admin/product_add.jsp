<%--
  Created by IntelliJ IDEA.
  User: 阚理想
  Date: 2021-6-7
  Time: 下午 3:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("webapp", request.getContextPath());
%>
<html>
<head>
    <title>添加商品</title>
    <script src="${webapp}/static/js/jquery.js" type="text/javascript"></script>
    <script src="${webapp}/static/layui/layui.js" type="text/javascript"></script>
    <script src="${webapp}/static/bootstrap-3.4.1/js/bootstrap.min.js" type="text/javascript"></script>
    <link href="${webapp}/static/bootstrap-3.4.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webapp}/static/css/product_add.css" rel="stylesheet">
    <link rel="stylesheet" href="${webapp}/static/layui/css/layui.css" type="text/css"/>
</head>
<body>
<form id="form_addProduct" class="form-horizontal col-sm-offset-4" enctype="multipart/form-data">
    <div class="form-group">
        <label for="input_pName" class="col-sm-2 control-label">名称：</label>
        <div class="col-sm-5">
            <input type="text" name="pName" class="form-control" id="input_pName" placeholder="请输入商品名称">
            <span class="help-block"></span>
        </div>
    </div>
    <div class="form-group">
        <label for="input_price" class="col-sm-2 control-label">价格：</label>
        <div class="col-sm-5">
            <input type="number" name="price" class="form-control" id="input_price" placeholder="请输入商品价格">
            <span class="help-block"></span>
        </div>
    </div>
    <div class="form-group">
        <label for="input_color" class="col-sm-2 control-label">颜色：</label>
        <div class="col-sm-5">
            <input type="text" name="color" class="form-control" id="input_color" placeholder="请输入商品颜色">
            <span class="help-block"></span>
        </div>
    </div>
    <div class="form-group">
        <label for="select_type" class="col-sm-2 control-label">类型：</label>
        <div class="col-sm-5">
            <select id="select_type" name="type" class="form-control">
                <option value="mobile">手机</option>
                <option value="wear">穿戴</option>
                <option value="home">家电</option>
                <option value="office">办公</option>
                <option value="other" selected="selected">其他</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="select_network" class="col-sm-2 control-label">网络：</label>
        <div class="col-sm-5">
            <select id="select_network" name="network" class="form-control">
                <option value="4G">4G</option>
                <option value="5G">5G</option>
                <option value="WIFI6">WIFI6</option>
                <option value="/" selected="selected">/</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="input_stock" class="col-sm-2 control-label">库存：</label>
        <div class="col-sm-5">
            <input type="number" name="stock" class="form-control" id="input_stock" placeholder="请输入商品库存">
            <span class="help-block"></span>
        </div>
    </div>
    <div class="form-group">
        <label for="input_img" class="col-sm-2 control-label">图片：</label>
        <span class="help-block"></span>
        <div class="col-sm-5">
            <input type="file" name="input_img" class="form-control" id="input_img">
        </div>
    </div>
</form>
<button type="button" id="btn_add" value="添加" class="btn btn-primary">添加</button>
<script type="text/javascript">

    $("#btn_add").click(function () {
        //点击添加后先进行校验
        if (!checking_form()) {
            return false;
        }

        //创建DataForm传输数据
        const form = document.querySelector("#form_addProduct");
        const formData = new FormData(form);

        const pName = $("#input_pName").val();
        const price = $("#input_price").val();
        const color = $("#input_color").val();
        let type = $("#select_type").val();
        const network = $("#select_network").val();
        const stock = $("#input_stock").val();
        const productImg = $("#input_img").val();

        formData.append("pName", pName);
        formData.append("price", price);
        formData.append("color", color);
        formData.append("type", type);
        formData.append("network", network);
        formData.append("stock", stock);
        formData.append("productImg", productImg);

        //发送添加请求
        $.ajax({
            url: '${webapp}/productManager/addProduct',
            type: 'POST',
            enctype: 'multipart/form-data',
            contentType: false,
            processData: false,
            data: formData,
            success: function (res) {
                if (res === "success") {
                    layer.msg(
                        '添加成功', {icon: 1, time: 1000},
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
                            window.location.replace("${webapp}/productManager/" + type);
                        }
                    );
                } else {
                    layer.msg('添加失败', {icon: 2, time: 1000});
                }
            }
        });

    });

    // 表单数据验证
    function checking_form() {
        //验证产品名
        const productName = $("#input_pName").val();
        const reg = /(^[a-zA-Z0-9]{5,18}$)|(^[\u2E80-\u9FFF]{2,8})/;
        if (!reg.test(productName)) {    //如果验证不通过
            showCheckMsg("#input_pName", "error", "商品名为5-18位字母数字或2-8位汉字");
            $("#input_pName").focus();
            return false;   //校验不成功直接返回
        } else {
            showCheckMsg("#input_pName", "success", "");
        }
        //校验价格
        const price = $("#input_price").val();
        if (price === "" || price === undefined) {
            showCheckMsg("#input_price", "error", "请输入价格");
            $("#input_price").focus();
            return false;
        }
        if (price.toString().substring(0, 1) === "0" || price.toString().substring(0, 1) === "-" || price.length > 5) {
            showCheckMsg("#input_price", "error", "价格不能以为负或以0开头，不能超过5位数");
            $("#input_price").focus();
            return false;
        } else {
            showCheckMsg("#input_price", "success", "");
        }
        //再校验颜色
        const color = $("#input_color").val();
        const reg_tel = /(^[a-zA-Z]{5,10}$)|(^[\u2E80-\u9FFF]{2,8})/;
        if (!reg_tel.test(color)) {
            showCheckMsg("#input_color", "error", "5-10位英文或者2-8位汉字");
            $("#input_color").focus();
            return false;
        } else {
            showCheckMsg("#input_color", "success", "");
        }

        //校验库存
        const stock = $("#input_stock").val();
        const reg_stock = /^[0-9]{1,8}$/;
        if (stock === "" || stock === undefined) {
            showCheckMsg("#input_stock", "error", "请输入库存");
            $("#input_stock").focus();
            return false;
        }
        if (stock.toString().substring(0, 1) === "0" || price.toString().substring(0, 1) === "-") {
            showCheckMsg("#input_stock", "error", "不能以0开头");
            $("#input_stock").focus();
            return false;
        }
        if (stock.length > 8) {
            showCheckMsg("#input_stock", "error", "不能超过8位数");
            $("#input_stock").focus();
            return false;
        }
        if (!reg_stock.test(stock)) {
            showCheckMsg("#input_stock", "error", "不能包含小数点");
            $("#input_stock").focus();
            return false;
        } else {
            showCheckMsg("#input_stock", "success", "");
        }
        //校验图片
        const productImg = $("#input_img").val();
        if (productImg == null || productImg === "") {
            showCheckMsg("#input_img", "error", "请选择图片");
            $("#input_img").focus();
            return false;
        } else {
            showCheckMsg("#input_img", "success", "");
        }
        return true;
    }

    //显示校验结果
    function showCheckMsg(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error");    //清空表单样式
        $(ele).next("span").text("")    //设置相邻span标签的提示文字为空

        if ("success" === status) {      //如果校验状态为成功
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" === status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

</script>
</body>
</html>
