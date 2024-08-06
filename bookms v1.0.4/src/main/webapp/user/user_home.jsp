<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>User Home</title>
    <style>
        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }

        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        h2 {
            color: #1a73e8;
            margin-bottom: 20px;
        }

        p {
            margin-bottom: 20px;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 4px;
            background-color: #1a73e8;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #0c5bd3;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h2 {
                font-size: 20px;
            }

            .btn {
                padding: 8px;
                font-size: 14px;
            }
        }

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

        .dark-mode {
            background-color: #333;
            color: #fff;
        }

        .dark-mode .container {
            background: #444;
        }

        .dark-mode h2 {
            color: #ff4d4d;
        }

        .dark-mode p {
            color: #ccc;
        }

        .dark-mode .btn {
            background-color: #444;
            color: #fff;
        }

        .dark-mode .btn:hover {
            background-color: #555;
        }

        .dark-mode .game-container {
            border-color: #555;
        }

        .dark-mode .game-container h3 {
            color: #ccc;
        }

        .dark-mode .game-container input {
            background-color: #555;
            border-color: #666;
            color: #fff;
        }

        .dark-mode .game-container button {
            background-color: #007bff;
        }

        .toggle-switch {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .toggle-switch input {
            display: none;
        }

        .toggle-switch label {
            cursor: pointer;
            background-color: #ccc;
            border-radius: 34px;
            display: inline-block;
            height: 20px;
            position: relative;
            width: 40px;
        }

        .toggle-switch label:after {
            background-color: #fff;
            border-radius: 50%;
            content: "";
            height: 14px;
            left: 3px;
            position: absolute;
            top: 3px;
            transition: 0.3s;
            width: 14px;
        }

        .toggle-switch input:checked + label {
            background-color: #1a73e8;
        }

        .toggle-switch input:checked + label:after {
            transform: translateX(20px);
        }

    </style>
</head>

<body>
    <div class="toggle-switch">
        <input type="checkbox" id="dark-mode-toggle">
        <label for="dark-mode-toggle"></label>
    </div>
    <div class="container">
        <h2>欢迎, ${user}!</h2>
        <p>这是用户主页.</p>
        <p>选择你要执行的操作</p>
        <form action="changePassword.jsp" method="get">
            <button type="submit" class="btn">更改密码</button>
        </form>
        <form action="viewBooks.jsp" method="get">
            <button type="submit" class="btn">查看图书</button>
        </form>
        <form action="returnBooks.jsp" method="get">
            <button type="submit" class="btn">归还书籍</button>
        </form>

        <%--      退出登录到首页      --%>
        <form action="../index.jsp" method="get">
            <button type="submit">退出登录</button>

        <div class="game-container">
            <h3>猜数字游戏</h3>
            <input type="number" id="guess-input" placeholder="输入一个1-100的数字">
            <button onclick="checkGuess()">猜</button>
            <p id="game-message"></p>
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

            document.addEventListener('DOMContentLoaded', function() {
                const toggleSwitch = document.getElementById('dark-mode-toggle');
                const body = document.body;

                // Check for saved user preference, if any, on load of the website
                const currentTheme = localStorage.getItem('theme') ? localStorage.getItem('theme') : null;

                if (currentTheme) {
                    body.classList.add(currentTheme);

                    if (currentTheme === 'dark-mode') {
                        toggleSwitch.checked = true;
                    }
                }

                toggleSwitch.addEventListener('change', function() {
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
