<%@ page import="org.lut.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: 11094
  Date: 2023/7/24
  Time: 20:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) request.getAttribute("userInfo");
%>
<!DOCTYPE html>
<html lang="">
<head>
    <meta charset="UTF-8">
    <title>个人信息</title>
    <style>
        .register-box {
            background-color: rgba(255, 255, 255, 0.84);
            border-radius: 13px;
            text-align: center;
            /* 设置边框距离 */
            margin: 10% auto;
            width: 30%;
            height: 500px;
        }

        .register-form {
            display: grid;
            grid-template-columns: auto;
            grid-template-rows: auto;
            /* 与父容器的距离 */
            padding-top: 1%;
            padding-bottom: 10px;
            gap: 14px;
        }

        .register-code {
            display: grid;
            grid-template-columns: 2fr;
            grid-template-rows: 1fr;
            padding-top: 10px;
        }

        .register-text {
            border: rgba(255, 255, 255, 0.18);
            width: 55%;
            height: 35px;
        }

        .button {
            text-align: center;
            padding: 10px;
            width: 55%;
            margin-top: 10px;
            background-color: #056de8;
            color: white;
            border: transparent;
        }

        .button:hover {
            background-color: #0461cf;
        }
    </style>
</head>
<body onLoad="creatCode()">
<div class="register-box">
    <div style="padding-top: 10px"><h1>个人信息</h1></div>
    <div class="register-form">
        <div>
            <label>
                姓名：<%=user.getUserName()%>
            </label>
        </div>
        <div>
            <label>
                手机号：<%=user.getPhoneNum()%>
            </label>
        </div>
        <div>
            <label>
                邮箱：<%=user.getEmail()%>
            </label>
        </div>
        <div>
            性别：<%=user.getGender()%>
        </div>
    </div>
    <div>
        余额：<%=user.getMoney()%>
    </div>
    <div>
        <input type="button" name="back" value="返回" onclick="history.back();" class="button">
    </div>
    <div>
        <input type="button" name="back" value="退出登录" onclick="window.location.href='main.jsp'" class="button">
    </div>
</div>
<div style="position: fixed;top: 0;left:0;bottom: 0;right: 0;z-index: -1">
    <canvas id="canvas" style="background-color: rgb(59,134,182);"></canvas>
</div>
<script type="text/javascript">

    const canvas = document.getElementById('canvas')
    const ctx = canvas.getContext('2d')
    let width = window.innerWidth
    let height = window.innerHeight

    let dotsNum = 50 // 点的数量
    let radius = 1 // 圆的半径，连接线宽度的一半
    let fillStyle = 'rgba(255,255,255,0.5)' // 点的颜色
    let lineWidth = radius * 2
    let connection = 150// 连线最大距离
    // let followLength = 80 // 鼠标跟随距离

    let dots = []
    let animationFrame = null
    let mouseX = null
    let mouseY = null

    function addCanvasSize() { // 改变画布尺寸
        width = window.innerWidth
        height = window.innerHeight
        canvas.width = width
        canvas.height = height
        ctx.clearRect(0, 0, width, height)
        dots = []
        if (animationFrame) window.cancelAnimationFrame(animationFrame)
        initDots(dotsNum)
        moveDots()
    }

    function mouseMove(e) {
        mouseX = e.clientX
        mouseY = e.clientY
    }

    function mouseOut() {
        mouseX = null
        mouseY = null
    }

    // function mouseClick() {
    //     for (const dot of dots) dot.elastic()
    // }

    class Dot {
        constructor(x, y) {
            // 随机粒子速度
            this.x = x
            this.y = y
            this.speedX = Math.random() / 9
            this.speedY = Math.random() / 9
            this.angle = Math.random() * 1000// 运动角度
            // this.follow = false
        }

        draw() {
            ctx.beginPath()
            ctx.arc(this.x, this.y, radius, 0, 2 * Math.PI)
            ctx.fill()
            ctx.closePath()
        }

        move() {
            if (this.x >= width || this.x <= 0) {
                this.speedX = -this.speedX
            }
            if (this.y >= height || this.y <= 0) {
                this.speedY = -this.speedY
            }
            this.x += Math.cos(this.angle) * this.speedX
            this.y += Math.sin(this.angle) * this.speedY
            if (this.speedX >= 1) {
                this.speedX--
            }
            if (this.speedX <= -1) {
                this.speedX++
            }
            if (this.speedY >= 1) {
                this.speedY--
            }
            if (this.speedY <= -1) {
                this.speedY++
            }
            // this.correct()
            this.connectMouse()
            this.draw()
        }

        // correct() { // 根据鼠标的位置修正
        //     if (!mouseX || !mouseY) return
        //     let lengthX = mouseX - this.x
        //     let lengthY = mouseY - this.y
        //     const distance = Math.sqrt(lengthX ** 2 + lengthY ** 2)
        //     if (distance <= followLength) this.follow = true
        //     else if (this.follow === true && distance > followLength && distance <= followLength + 8) {
        //         let proportion = followLength / distance
        //         lengthX *= proportion
        //         lengthY *= proportion
        //         this.x = mouseX - lengthX
        //         this.y = mouseY - lengthY
        //     } else this.follow = false
        // }

        connectMouse() { // 点与鼠标连线
            if (mouseX && mouseY) {
                let lengthX = mouseX - this.x
                let lengthY = mouseY - this.y
                const distance = Math.sqrt(lengthX ** 2 + lengthY ** 2)
                if (distance <= connection) {
                    opacity = (1 - distance / connection) * 0.5
                    ctx.strokeStyle = `rgba(255,255,255,${opacity})`
                    ctx.beginPath()
                    ctx.moveTo(this.x, this.y)
                    ctx.lineTo(mouseX, mouseY);
                    ctx.stroke();
                    ctx.closePath()
                }
            }
        }

        // elastic () { // 鼠标点击后的弹射
        //     let lengthX = mouseX - this.x
        //     let lengthY = mouseY - this.y
        //     const distance = Math.sqrt(lengthX ** 2 + lengthY ** 2)
        //     if (distance >= connection) return
        //     const rate = 1 - distance / connection // 距离越小此值约接近1
        //     this.speedX = 40 * rate * -lengthX / distance
        //     this.speedY = 40 * rate * -lengthY / distance
        // }
    }

    function initDots(num) { // 初始化粒子
        ctx.fillStyle = fillStyle
        ctx.lineWidth = lineWidth
        for (let i = 0; i < num; i++) {
            const x = Math.floor(Math.random() * width)
            const y = Math.floor(Math.random() * height)
            const dot = new Dot(x, y)
            dot.draw()
            dots.push(dot)
        }
    }

    function moveDots() { // 移动并建立点与点之间的连接线
        ctx.clearRect(0, 0, width, height)
        for (const dot of dots) {
            dot.move()
        }
        for (let i = 0; i < dots.length; i++) {
            for (let j = i; j < dots.length; j++) {
                const distance = Math.sqrt((dots[i].x - dots[j].x) ** 2 + (dots[i].y - dots[j].y) ** 2)
                if (distance <= connection) {
                    opacity = (1 - distance / connection) * 0.5
                    ctx.strokeStyle = `rgba(255,255,255,${opacity})`
                    ctx.beginPath()
                    ctx.moveTo(dots[i].x, dots[i].y)
                    ctx.lineTo(dots[j].x, dots[j].y);
                    ctx.stroke();
                    ctx.closePath()
                }
            }
        }
        animationFrame = window.requestAnimationFrame(moveDots)
    }

    addCanvasSize()

    initDots(dotsNum)
    moveDots()

    document.onmousemove = mouseMove
    document.onmouseout = mouseOut
    document.onclick = mouseClick
    window.onresize = addCanvasSize
</script>
</body>
</html>
