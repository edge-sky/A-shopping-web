<%--
  Created by IntelliJ IDEA.
  User: 11094
  Date: 2023/7/22
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" %>
<%@ page import="org.lut.entity.*" %>
<%@ page import="org.lut.dao.DigitalGoodsDao" %>
<%@ page import="java.sql.SQLException" %>
<html>
<head>
    <title>商品页面</title>
    <style>
        .main-box {
            position: fixed;
            margin: auto;
            background-color: white;
            width: 85%;
            height: 100%;
            left: 0;
            right: 0;
            z-index: 10;
        }

        /* 单个商品框 */
        .goods-layout {
            margin: 20px 10px 0 10px;
            left: 10%;
            float: left;
            width: 22%;
            height: 45%;
            /* 锁定横纵比 */
            aspect-ratio: 3 / 4;
            border: 1px solid;
            position: relative;
            /*background-color: white;*/
            overflow: hidden;
            text-overflow: ellipsis;
            z-index: 12;
        }

        .img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            height: 80%;
            width: 100%;
        }

        .font {
            color: #656565;
            text-decoration: none;
            height: 18%;
        }

        .font:hover {
            color: #f50010;
        }
    </style>
</head>
<body style="margin: 0;height: 100%; padding: 0; background-color: #f4f4f4">
<%
    // 写入JAVA代码
    // 获取用户登录信息
    User user;
    if (request.getAttribute("user") == null) {
        user = new User();
        user.setUserName("未登录");
    } else {
        user = (User) request.getAttribute("user");
    }
    List<DigitalGoods> list;
    try {
        list = DigitalGoodsDao.getDao().getGoodsList();
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>
<div class="main-box"></div>
<div style="width: 84%;">
    <%
        for (DigitalGoods digitalGoods : list) {
            String logoSrc = digitalGoods.getLogo();
            String url = "detail?id=" + digitalGoods.getId();
    %>
    <div class="goods-layout">
        <a href="<%=url%>" class="font">
            <img src=<%=logoSrc%> alt=<%=digitalGoods.getLogo()%>
                 class="img"/>
            <p>
                <%=digitalGoods.getDescription()%>
            </p>
        </a>
    </div>
    <%}%>
</div>
</body>
</html>
