package com.klx.samsung.domain;


import java.math.BigDecimal;
import java.sql.Date;

public class OrderItem {
    private String id;
    private Integer quantity;
    private BigDecimal orderMoney;  //订单金额
    private Date createTime;
    private String status;      //订单状态
    private String receiver;    //收货人
    private String receiverAddress;  //收货地址

    public OrderItem() {
    }

    public OrderItem(String id, Integer quantity, BigDecimal orderMoney, Date createTime, String status, String receiver, String receiverAddress) {
        this.id = id;
        this.quantity = quantity;
        this.orderMoney = orderMoney;
        this.createTime = createTime;
        this.status = status;
        this.receiver = receiver;
        this.receiverAddress = receiverAddress;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getOrderMoney() {
        return orderMoney;
    }

    public void setOrderMoney(BigDecimal orderMoney) {
        this.orderMoney = orderMoney;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "id='" + id + '\'' +
                ", quantity=" + quantity +
                ", orderMoney=" + orderMoney +
                ", createTime=" + createTime +
                ", status='" + status + '\'' +
                ", receiver='" + receiver + '\'' +
                ", receiverAddress='" + receiverAddress + '\'' +
                '}';
    }
}

