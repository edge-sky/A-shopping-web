package org.lut.entity;

import java.math.BigDecimal;
import java.util.ArrayList;

public class DigitalGoods {
    private String id;
    private String name;
    private String description;// 介绍
    private BigDecimal price;// 商品价格
    private int number;// 商品库存
    private String type;// 商品分类
    private String brand;// 品牌
    private String logo;// 商品图片路径
    private ArrayList<String> adv;// 广告图片路径
    private String brandLogo;// 品牌Logo
    private String brandSummary;

    public String getBrandLogo() {
        return brandLogo;
    }

    public void setBrandLogo(String brandLogo) {
        this.brandLogo = brandLogo;
    }

    public String getBrandSummary() {
        return brandSummary;
    }

    public void setBrandSummary(String brandSummary) {
        this.brandSummary = brandSummary;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public ArrayList<String> getAdv() {
        return adv;
    }

    public void setAdv(ArrayList<String> adv) {
        this.adv = adv;
    }

    public DigitalGoods() {
    }

    @Override
    public String toString() {
        return "digitalGoods{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", number=" + number +
                ", type='" + type + '\'' +
                ", brand='" + brand + '\'' +
                ", image='" + logo + '\'' +
                ", adv='" + adv + '\'' +
                '}';
    }
}
