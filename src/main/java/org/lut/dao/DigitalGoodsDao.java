package org.lut.dao;

import org.lut.entity.DigitalGoods;
import org.lut.util.JDBCUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

public class DigitalGoodsDao {
    // 单例模式
    private static DigitalGoodsDao dao;

    private DigitalGoodsDao() {
        // TODO Auto-generated constructor stub
    }

    public static DigitalGoodsDao getDao() {

        if (dao == null) {
            dao = new DigitalGoodsDao();
        }
        return dao;
    }

    // 检索商品封面信息
    public ArrayList<DigitalGoods> getGoodsList() throws SQLException {
        Connection con = JDBCUtil.connect();
        String sql = "select id, name, price, number, description, type, brand, logo, adv from goods";
        ResultSet rs = con.createStatement().executeQuery(sql);

        ArrayList<String> imgList = new ArrayList<>();
        ArrayList<DigitalGoods> allGoods = new ArrayList<>();

        while (rs.next()) {
            String id = rs.getString("id");
            String name = rs.getString("name");
            BigDecimal price = rs.getBigDecimal("price");
            int number = rs.getInt("number");
            String description = rs.getString("description");
            String type = rs.getString("type");
            String brand = rs.getString("brand");
            String logo = rs.getString("logo");
            String[] str = rs.getString("adv").split(",");
            ArrayList<String> adv = new ArrayList<>(Arrays.asList(str));// 将分割后的广告路径插入集合中
            imgList.add(rs.getString("logo"));

            DigitalGoods goods = new DigitalGoods();
            goods.setId(id);
            goods.setName(name);
            goods.setPrice(price);
            goods.setNumber(number);
            goods.setDescription(description);
            goods.setType(type);
            goods.setBrand(brand);
            goods.setLogo(logo);
            goods.setAdv(adv);

            allGoods.add(goods);
        }
        JDBCUtil.close();
        return allGoods;
    }
    /* 获取商品信息 */
    public DigitalGoods getGoodsInfo(int id) throws SQLException {
        DigitalGoods goods = new DigitalGoods();
        ArrayList<String> adv;

        Connection con = JDBCUtil.connect();
        // 根据商品id获取商品信息
        String sql = "select * from goods where id = '" + id + "'";
        ResultSet rs = con.createStatement().executeQuery(sql);

        while (rs.next()) {
            goods.setId(rs.getString("id"));
            goods.setName(rs.getString("name"));
            goods.setPrice(rs.getBigDecimal("price"));
            goods.setNumber(rs.getInt("number"));
            goods.setDescription(rs.getString("description"));
            goods.setType(rs.getString("type"));
            goods.setBrand(rs.getString("brand"));
            goods.setLogo(rs.getString("logo"));

            String[] str = rs.getString("adv").split(",");
            adv = new ArrayList<>(Arrays.asList(str));// 将分割后的广告路径插入集合中
            goods.setAdv(adv);
        }

        JDBCUtil.close();

        return goods;
    }
}
