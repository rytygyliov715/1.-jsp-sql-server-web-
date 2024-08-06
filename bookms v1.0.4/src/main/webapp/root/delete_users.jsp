<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="bean.ConnDB"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>删除用户</title>

        <style>
            <style>
        /* 全局样式 */
        body {
            font-family: 'Open Sans', 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* 容器样式 */
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
            margin: 20px;
        }

        /* 标题样式 */
        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #1a73e8;
        }

        /* 表格样式 */
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            text-align: left;
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
            color: #333;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h2 {
                font-size: 20px;
            }

            th, td {
                padding: 10px;
            }
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
    <h2>删除用户</h2>
    <form action="../ConfirmDeleteUsersServlet" method="post">
        <table>
            <tr>
                <th>选择</th>
                <th>用户 ID</th>
                <th>用户名</th>
                <th>电话号码</th>
                <th>电子邮箱</th>
                <th>是否存在借阅</th>
            </tr>
            <%
                ConnDB connDB = new ConnDB();
                ResultSet rsUsers = (ResultSet) request.getAttribute("users");
                while (rsUsers.next()) {
                    String userId = rsUsers.getString("user_id");
                    ResultSet rsBorrowedBooks = connDB.doQuery("SELECT * FROM Book_tb WHERE borrower = " + userId);
                    boolean hasBorrowedBooks = rsBorrowedBooks.next();
            %>
                <tr>
                    <td><input type="checkbox" name="selectedUsers" value="<%= userId %>" <%= hasBorrowedBooks ? "disabled" : "" %>></td>
                    <td><%= userId %></td>
                    <td><%= rsUsers.getString("username") %></td>
                    <td><%= rsUsers.getString("phone_number") %></td>
                    <td><%= rsUsers.getString("email") %></td>
                    <td><%= hasBorrowedBooks ? "Yes" : "No" %></td>
                </tr>
            <%
                }
            %>
        </table>
        <input type="submit" value="Delete Selected Users">
    </form>
    <button type="button" class="secondary" onclick="window.location.href='admin_home.jsp'">
                    返回
                </button>
</div>
</body>
</html>