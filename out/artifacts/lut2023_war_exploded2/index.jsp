<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户登录</title>
</head>
<body onLoad="creatCode()">
<hr>
<h1 align="center">登录</h1>
<div align="center">
    <form id="form1" name="form1" method="post" action="login">
        <table width="35%" height="35%" border="0">
            <tr>
                <td width="42%" height="49">
                    <label>
                        <div align="right">
                            <img src="屏幕截图 2023-07-17 095400.png" width="40" height="40">
                        </div>
                    </label>
                </td>
                <td width="58%">
                    <div align="left">
                        <input name="phoneNum" type="text" placeholder="输入手机号">
                    </div>
                </td>
            </tr>
            <tr>
                <td height="42">
                    <div align="right">
                        <img src="屏幕截图 2023-07-17 095420.png" width="40" height="40">
                    </div>
                </td>
                <td>
                    <div align="left">
                        <input type="password" name="password" placeholder="输入密码">
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <label>
                        <div align="right">
                            <input name="刷新验证码" type="button" id="code" style="width:60px" title="看不清？换一张"
                                   onclick="creatCode()">
                        </div>
                    </label>
                    <div align="center"></div>
                </td>
                <td>
                    <div align="left">
                        <input type="text" name="textfield3" placeholder="输入验证码">
                    </div>
                </td>
            </tr>
            <tr>
                <td><label>
                    <div align="right">
                        <input type="button" name="toRegister" value="还没有账户？点我注册" onclick="shiftToRegister()"/>
                    </div>
                </label></td>
                <td>
                    <label>
                        <input type="submit" name="Submit2" value="登录" onclick="shiftToMain()"/>
                    </label>
                </td>
            </tr>
        </table>
    </form>
</div>
<script>
    function shiftToRegister() {
        window.open("https://q7699m8055.yicp.fun/lut2023/register.html");
    }

    function shiftToMain() {
        window.open("https://q7699m8055.yicp.fun/lut2023/main.html");
    }

    function showWaite() {
        alert("网络异常，请稍后尝试");
    }

    function creatCode() {
        var code = "";
        var random = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];

        for (var i = 0; i < 4; i++) {
            var index = Math.floor(Math.random() * 58);
            code += random[index]
        }
        document.getElementById("code").value = code;
    }
</script>


<div style="position: fixed;top: 0;left:0;bottom: 0;right: 0;z-index: -1">
    <canvas id="canvas" style="background-color: rgb(50,64,87);"></canvas>
</div>
<script type="text/javascript">

    const canvas = document.getElementById('canvas')
    const ctx = canvas.getContext('2d')
    let width = window.innerWidth
    let height = window.innerHeight

    let dotsNum = 120 // 点的数量
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

    function mouseClick() {
        for (const dot of dots) dot.elastic()
    }

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