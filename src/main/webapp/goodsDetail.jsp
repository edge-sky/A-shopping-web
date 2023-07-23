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
        .info-box {
            width: calc(65vw);
            margin: auto;
        }
        .adv-box {
            width: calc(65vw);
            margin: auto;
        }
        .img-box {
            /* flex布局，纵向排布 */
            display: flex;
            flex-direction: column;
            justify-content: center;
            width: 100%;
        }
        .img {

        }
    </style>
</head>

<body>
<div>
    <table class="info-box">
        <tr>
            <td colspan="2" rowspan="4"><img src=<%=imgPath%>  alt="" style="max-height: 100%; max-width: 100%; height: auto; width: auto"/></td>
            <td height="138" colspan="2">
                <div align="center">
                    <h1><%=digitalGoods.getName()%>
                    </h1>
                </div>
            </td>
        </tr>
        <tr>
            <td height="126" colspan="2"><%=digitalGoods.getDescription()%>
            </td>
        </tr>
        <tr>
            <td width="324" height="127">品牌</td>
            <td width="291"><%=digitalGoods.getBrand()%>
            </td>
        </tr>
        <tr>
            <td>价格</td>
            <td><%=digitalGoods.getPrice()%>
            </td>
        </tr>
    </table>
    <table width="974" height="173" border="0">
        <tr>
            <td width="141">参数介绍</td>
            <td width="823">&nbsp;</td>
        </tr>
        <tr>
            <td>品牌介绍</td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <p>&nbsp;</p>
</div>
<div class="adv-box" >
    <%for (int i = 0; i < digitalGoods.getAdv().size(); i++) {
        String str = "img/advises/" + digitalGoods.getAdv().get(i);
    %>
    <div class="img-box">
        <img src=<%=str%> alt="商品详情" class="img" >
    </div>
    <%}%>
</div>
</body>
</html>