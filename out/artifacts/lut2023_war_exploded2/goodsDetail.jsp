<%@ page import="org.lut.entity.DigitalGoods" %><%--
  Created by IntelliJ IDEA.
  User: 11094
  Date: 2023/7/23
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DigitalGoods digitalGoods = (DigitalGoods) request.getAttribute("goods");

    String imgPath = digitalGoods.getLogo();
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title><%=digitalGoods.getName()%>
    </title>
    <style>
        .shop-box {
            padding-top: 8%;
            width: calc(65vw);
            height: 35%;
            margin: auto;
            display: flex;
            flex-direction: row;
        }

        .info-box {
            display: flex;
            flex-direction: row;
            width: calc(65vw);
            margin: auto;
            padding-top: 8%;
            padding-bottom: 5%;
        }

        .adv-box {
            width: calc(65vw);
            margin: auto;
        }

        .img-box {
            /* flex布局，纵向排布 */
            display: flex;
            flex-direction: column;
            /* 水平居中 */
            justify-content: center;
            width: 100%;
        }
    </style>
</head>

<body>
<div style="display: flex; flex-direction: column">
    <%-- 标题文字居中 --%>
    <h1 style="width: calc(65vw); margin: auto; text-align: center"><%=digitalGoods.getName()%>
    </h1>
    <div class="shop-box">
        <div style="width: 50%">
            <img src=<%=imgPath%>  alt=""
                 style="max-width: 100%; height: auto; width: auto"/>
        </div>
        <div style="width: 50%; padding-left: 5%;">
            <div style="color: #515151">
                <h2>
                    <%=digitalGoods.getDescription()%>
                </h2>
            </div>
            <table style="width: 50%; margin-top: 26%;">
                <tr>
                    <td style="width: 40%; color: #515151"><h3>品牌：</h3></td>
                    <td style="max-width: 60%;"><h3><%=digitalGoods.getBrand()%>
                    </h3></td>
                </tr>
                <tr>
                    <td style="color: #515151"><h3>价格：</h3></td>
                    <td style="color: #e62928"><h1>￥<%=digitalGoods.getPrice()%>
                    </h1>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="info-box">
        <tr>
            <%String brandLoge = "img/brandLogo/" + digitalGoods.getBrandLogo();%>
            <div style="width: 20%;object-fit: contain;"><img src=<%=brandLoge%> alt="品牌图标";
                                                              style="max-width: 100%"></div>
            <div style="width: 80%"><%=digitalGoods.getBrandSummary()%>
            </div>
        </tr>
        <p>&nbsp;</p>
    </div>
    <div class="adv-box">
        <%
            for (int i = 0; i < digitalGoods.getAdv().size(); i++) {
                String str = "img/advises/" + digitalGoods.getAdv().get(i);
        %>
        <div class="img-box">
            <img src=<%=str%> alt="商品详情" class="img">
        </div>
        <%}%>
    </div>
</body>
</html>