package com.klx.samsung.domain;

import javax.validation.constraints.Pattern;
import java.util.Date;
import java.util.List;

public class User {
    private Integer id;
    //自定义JSR校验
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{5,15}$)|(^[\\u2E80-\\u9FFF]{2,5})",
            message = "用户名为5-15位字母数字下划线减号或2-5位中文")
    private String name;

    @Pattern(regexp = "[a-z0-9_-]{6,15}",
            message = "密码为6-15位字母数字减号下划线")
    private String password;
    private String sex;

    @Pattern(regexp = "^1(3[0-9]|4[01456879]|5[0-35-9]|6[2567]|7[0-8]|8[0-9]|9[0-35-9])\\d{8}",
            message = "手机号格式不正确")
    private String tel;
    private Date birth;

    @Pattern(regexp = "(^[a-zA-Z0-9-]{5,30}$)|(^[\\u2E80-\\u9FFF]{3,20})",
            message = "请输入正确的地址")
    private String address;
    private String headImgUrl;
    private Integer role;
    private List<CartItem> cartItemList;
    private List<OrderItem> orderItemList;
    private List<Integer> ids;

    public User() {
    }

    public User(Integer uid, String username, String password, String sex, String tel, Date birth, String address, String iUrl, List<CartItem> cartItemList, List<OrderItem> orderItemList, List<Integer> ids) {
        this.id = uid;
        this.name = username;
        this.password = password;
        this.sex = sex;
        this.tel = tel;
        this.birth = birth;
        this.address = address;
        this.headImgUrl = iUrl;
        this.cartItemList = cartItemList;
        this.orderItemList = orderItemList;
        this.ids = ids;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getHeadImgUrl() {
        return headImgUrl;
    }

    public void setHeadImgUrl(String headImgUrl) {
        this.headImgUrl = headImgUrl;
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    public List<CartItem> getCartItemList() {
        return cartItemList;
    }

    public void setCartItemList(List<CartItem> cartItemList) {
        this.cartItemList = cartItemList;
    }

    public List<OrderItem> getOrderItemList() {
        return orderItemList;
    }

    public void setOrderItemList(List<OrderItem> orderItemList) {
        this.orderItemList = orderItemList;
    }

    public List<Integer> getIds() {
        return ids;
    }

    public void setIds(List<Integer> ids) {
        this.ids = ids;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", sex='" + sex + '\'' +
                ", tel='" + tel + '\'' +
                ", birth='" + birth + '\'' +
                ", address='" + address + '\'' +
                ", headImgUrl='" + headImgUrl + '\'' +
                ", role=" + role +
                ", cartItemList=" + cartItemList +
                ", orderItemList=" + orderItemList +
                '}';
    }

}

