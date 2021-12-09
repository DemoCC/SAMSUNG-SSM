package com.klx.samsung.domain;

import java.math.BigDecimal;

public class CartItem {
    private Integer id;
    private Integer uid;
    private Integer pid;
    private Integer quantity;   //购买数量
    private BigDecimal totalMoney;  //购买总价
    private Product product;

    public CartItem() {
    }

    public CartItem(Integer id, Integer uid, Integer pid, Integer quantity, BigDecimal totalMoney, Product product) {
        this.id = id;
        this.uid = uid;
        this.pid = pid;
        this.quantity = quantity;
        this.totalMoney = totalMoney;
        this.product = product;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(BigDecimal totalMoney) {
        this.totalMoney = totalMoney;
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "id=" + id +
                ", uid=" + uid +
                ", pid=" + pid +
                ", quantity=" + quantity +
                ", totalMoney=" + totalMoney +
                ", product=" + product +
                '}';
    }
}
