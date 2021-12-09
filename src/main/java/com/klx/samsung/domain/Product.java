package com.klx.samsung.domain;

import java.math.BigDecimal;
import java.util.List;

public class Product {
    private Integer id;
    private String name;
    private BigDecimal price;
    private String color;
    private String type;
    private String network;
    private Integer stock;
    private String url;
    private List<Integer> ids;

    public Product() {
    }

    public Product(Integer id, String name, BigDecimal price, String color, String type, String network, Integer stock, String url) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.color = color;
        this.type = type;
        this.network = network;
        this.stock = stock;
        this.url = url;
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public void setIds(List<Integer> ids) {
        this.ids = ids;
    }

    public List<Integer> getIds() {
        return ids;
    }

    public String getNetwork() {
        return network;
    }

    public void setNetwork(String network) {
        this.network = network;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", color='" + color + '\'' +
                ", type='" + type + '\'' +
                ", network='" + network + '\'' +
                ", stock=" + stock +
                ", url='" + url + '\'' +
                '}';
    }

}
