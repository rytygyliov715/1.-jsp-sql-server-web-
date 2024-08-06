<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>卡丘图书馆</title>
    <style>
        /* 字体排印学 */
        body {
            font-family: Arial, sans-serif;
            color: #333; /* Default font color */
        }
        h2 {
            color: #6c757d;
            margin-top: 20px;
            font-size: 20px;
        }
        button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background-color: #1a73e8;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }

        /* 布局 */
        .center-card {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
            justify-content: space-between;
        }

        .game-container {
            text-align: center;
            padding: 20px;
            border-top: 1px solid #ddd;
            margin-top: 20px;
            width: 100%;
        }

        .game-container h3 {
            color: #6c757d;
            font-size: 18px;
        }

        .game-container input {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 10px;
            font-size: 16px;
        }

        .game-container button {
            padding: 10px 20px;
            background-color: #28a745;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
            font-size: 16px;
        }

        /*颜色和动画 */
        body {
            animation: gradient 5s ease-in-out infinite;
            background: linear-gradient(270deg, #f8f9fa, #0373c7);
            background-size: 200% 200%;
        }
        @keyframes gradient {
            0% {background-position: 0% 50%;}
            50% {background-position: 100% 50%;}
            100% {background-position: 0% 50%;}
        }

        /* Dark Mode */
        body.dark-mode {
            color: #ddd; /* Change font color to white */
            background: #0373c7; /* Change background color to dark */
        }

        h2.dark-mode {
            color: #ddd; /* Change h2 color to white */
        }

        .game-container.dark-mode {
            background: #2863a7; /* Change game container background color to dark */
        }

        .game-container.dark-mode h3 {
            color: #ddd; /* Change game container h3 color to white */
        }

        .game-container.dark-mode input,
        .game-container.dark-mode button {
            background-color: #2863a7; /* Adjust input and button background color */
            border-color: #2872a7; /* Adjust input and button border color */
        }

        .game-container.dark-mode input::placeholder {
            color: #ddd; /* Adjust input placeholder color */
        }

        .game-container.dark-mode button {
            color: #fff; /* Adjust button text color to white */
        }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<div class="container">
<div class="center-card">
        <h2 class="text-center" style="color: #ffffff;">Hello 卡丘图书馆!</h2>
        <table class="table table-borderless">
            <tr>
                <%--管理员--%>
                <td >
                    <button class="btn btn-primary" onclick="window.location.href='root/admin_login.html'">管理员登录</button>
                </td>
                <%--普通用户--%>
                <td >
                    <button class="btn btn-secondary" onclick="window.location.href='user/user_login.html'">用户登录</button>
                </td>
            </tr>
            <tr>
            <td>
                <div class="game-container">
                <h3>猜数字游戏</h3>
                <p id="game-message">我已经想好了一个1到100之间的数字。你能猜出来吗？</p>
                    <label for="guess-input">

                    </label><input type="number" id="guess-input" min="1" max="100" placeholder="输入你的猜测" />
                <button onclick="checkGuess()">猜一下</button>
                <p>此为开发中版本，不代表最终品质 -2024.6.14</p>
                </div>
            </td>
        </table>
    </div>

</div>

<script>
    let randomNumber = Math.floor(Math.random() * 100) + 1;

    function checkGuess() {
        let guess = parseInt(document.getElementById('guess-input').value);
        let message = document.getElementById('game-message');
        
        if (guess > randomNumber) {
            message.textContent = '太大了，再试一次!';
        } else if (guess < randomNumber) {
            message.textContent = '太小了，再试一次!';
        } else {
            message.textContent = '恭喜你，猜对了!';
        }
    }
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const toggleSwitch = document.createElement('input');
        toggleSwitch.setAttribute('type', 'checkbox');
        toggleSwitch.setAttribute('id', 'dark-mode-toggle');
        toggleSwitch.classList.add('dark-mode-toggle');
        document.body.insertBefore(toggleSwitch, document.body.firstChild);

        const body = document.body;

        // Check for saved user preference, if any, on load of the website
        const currentTheme = localStorage.getItem('theme') ? localStorage.getItem('theme') : null;

        if (currentTheme) {
            body.classList.add(currentTheme);

            if (currentTheme === 'dark-mode') {
                toggleSwitch.checked = true;
            }
        }

        toggleSwitch.addEventListener('change', function () {
            if (toggleSwitch.checked) {
                body.classList.add('dark-mode');
                localStorage.setItem('theme', 'dark-mode');
            } else {
                body.classList.remove('dark-mode');
                localStorage.setItem('theme', 'light-mode');
            }
        });
    });
</script>
</body>
</html>
