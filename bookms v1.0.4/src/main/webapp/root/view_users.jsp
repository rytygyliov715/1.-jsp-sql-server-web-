<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="bean.ConnDB"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>查看所有用户</title>
        
    <script>
        function validateForm() {
            var bookName = document.getElementById("book_name").value;
            var author = document.getElementById("author").value;

            if (bookName === "" || author === "") {
                alert("Please fill in all fields");
                return false;
            }

            return true;
        }
    </script>
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
        }

        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            margin: 20px;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #1a73e8;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            margin-bottom: 5px;
            font-weight: bold;
            display: block;
        }

        input,
        select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
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

        button.secondary {
            background-color: #ccc;
        }

        button:hover {
            background-color: #0c5bd3;
        }

        button.secondary:hover {
            background-color: #aaa;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h2 {
                font-size: 20px;
            }

            input,
            select {
                padding: 8px;
            }

            button {
                padding: 8px 16px;
                font-size: 14px;
            }
        }

        .center-card {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
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
    </style>

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
        }

        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            margin: 20px;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #1a73e8;
        }

        .form {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            margin-bottom: 5px;
            font-weight: bold;
        }

        input,
        select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
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

        button.secondary {
            background-color: #ccc;
        }

        button:hover {
            background-color: #0c5bd3;
        }

        button.secondary:hover {
            background-color: #aaa;
        }

        .toggle-button {
            margin-top: 20px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background-color: #333;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }

        .dark-mode {
            background-color: #333;
            color: #fff;
        }

        .dark-mode .container {
            background: #444;
            color: #fff;
        }

        .dark-mode input,
        .dark-mode select {
            background-color: #555;
            border: 1px solid #666;
            color: #fff;
        }

        .dark-mode button {
            background-color: #1a73e8;
        }

        .dark-mode button.secondary {
            background-color: #666;
        }

        .dark-mode button:hover {
            background-color: #0c5bd3;
        }

        .dark-mode button.secondary:hover {
            background-color: #888;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h2 {
                font-size: 20px;
            }

            input,
            select {
                padding: 8px;
            }

            button {
                padding: 8px 16px;
                font-size: 14px;
            }
        }
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
            transition: background-color 0.3s, color 0.3s;
        }

        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            width: 100%;
            margin: 20px;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #1a73e8;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        th {
            background-color: #f4f4f9;
            color: #333;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f1f1f1;
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

        button:hover {
            background-color: #0c5bd3;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h2 {
                font-size: 20px;
            }

            th, td {
                padding: 8px;
            }

            button {
                padding: 8px 16px;
                font-size: 14px;
            }
        }

        /* Dark Mode */
        body.dark-mode {
            background-color: #333;
            color: #ddd;
        }

        .container.dark-mode {
            background: #555;
            color: #ddd;
        }

        h2.dark-mode {
            color: #1a73e8;
        }

        th.dark-mode {
            background-color: #444;
            color: #ddd;
        }

        td.dark-mode {
            background-color: #555;
            color: #ddd;
        }

        tr.dark-mode:hover {
            background-color: #444;
        }

        button.dark-mode {
            background-color: #1a73e8;
        }

        button.dark-mode:hover {
            background-color: #0c5bd3;
        }
    </style>
    <script>
        function validateForm() {
            // 获取表单元素
            var username = document.getElementById("username").value;
            var currentPassword = document.getElementById("currentPassword").value;
            var newPassword = document.getElementById("newPassword").value;

            // 验证是否全部填写
            if (username === "" || currentPassword === "" || newPassword === "") {
                alert("请完整填写所有字段");
                return false;
            }

            return true;
        }

        function validatePasswords() {
            // 获取密码字段
            var currentPassword = document.getElementById("currentPassword").value;
            var newPassword = document.getElementById("newPassword").value;

            // 验证新旧密码是否一致
            if (currentPassword === newPassword) {
                alert("新密码不能与当前密码相同");
                return false;
            }

            return true;
        }

        function handleSubmit(event) {
            // 验证表单输入是否完整
            if (!validateForm()) {
                event.preventDefault();
                return false;
            }

            // 验证新旧密码是否一致
            if (!validatePasswords()) {
                event.preventDefault();
                return false;
            }

            return true;
        }

        function toggleDarkMode() {
            document.body.classList.toggle('dark-mode');
        }
    </script>
</head>
<body>
<div class="container">
    <h2>借阅图书的用户</h2>
    <table>
        <tr>
            <th>用户 ID</th>
            <th>用户名</th>
            <th>图书名</th>
        </tr>
        <%
            ResultSet rsBorrowedBooks = (ResultSet) request.getAttribute("borrowedBooks");
            while (rsBorrowedBooks.next()) {
        %>
            <tr>
                <td><%= rsBorrowedBooks.getString("user_id") %></td>
                <td><%= rsBorrowedBooks.getString("username") %></td>
                <td><%= rsBorrowedBooks.getString("book_name") %></td>
            </tr>
        <%
            }
        %>
    </table>

    <h2>所有用户</h2>
    <table>
        <tr>
            <th>用户 ID</th>
            <th>用户名</th>
            <th>电话号码</th>
            <th>电子邮箱</th>
        </tr>
        <%
            ResultSet rsUsers = (ResultSet) request.getAttribute("users");
            while (rsUsers.next()) {
        %>
            <tr>
                <td><%= rsUsers.getString("user_id") %></td>
                <td><%= rsUsers.getString("username") %></td>
                <td><%= rsUsers.getString("phone_number") %></td>
                <td><%= rsUsers.getString("email") %></td>
            </tr>
        <%
            }
        %>
    </table>
    <button type="button" class="secondary" onclick="window.location.href='root/admin_home.jsp'">
                    返回
                </button>
    </div>
</body>
</html>