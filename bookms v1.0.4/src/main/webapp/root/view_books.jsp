<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--使用ConnDB--%>
<%@ page import="bean.ConnDB"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>查看所有书籍</title>
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

<%

// utf8编码
        request.setCharacterEncoding("utf-8");
    // 初始化变量
    int totalBooks = 0;
    int borrowedBooks = 0;

    // 创建数据库连接对象
    ConnDB connDB = new ConnDB();
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // 获取数据库连接
        conn = ConnDB.getConnection();
        stmt = conn.createStatement();

        // 查询图书总数
        String totalBooksQuery = "SELECT COUNT(*) AS total FROM Book_tb";
        rs = stmt.executeQuery(totalBooksQuery);
        if (rs.next()) {
            totalBooks = rs.getInt("total");
        }

        // 关闭结果集
        rs.close();

        // 查询借阅中的图书总数
        String borrowedBooksQuery = "SELECT COUNT(*) AS borrowed FROM Book_tb WHERE borrow_status = 'borrowed'";
        rs = stmt.executeQuery(borrowedBooksQuery);
        if (rs.next()) {
            borrowedBooks = rs.getInt("borrowed");
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // 关闭数据库连接
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<div class="container">
    <h2>All Books</h2>

    <%--显示现在数据库有多少图书数据--%>
    <p>图书总数: <%= totalBooks %></p>

    <%--显示现在有多少本图书在借--%>
    <p>目前借阅的图书数量: <%= borrowedBooks %></p>
    
        
    <table >
        <tr>
            <th>书名</th>
            <th>作者</th>
            <th>借阅状态</th>
        </tr>
        <%
            try {
            ResultSet rs1 = (ResultSet) request.getAttribute("books");
            while (rs1.next()) {
        %>
        <tr>
            <td><%= rs1.getString("book_name") %></td>
            <td><%= rs1.getString("author") %></td>
            <td><%= rs1.getString("borrow_status") %></td>
        </tr>
        <% }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        %>
    </table>
    <button type="button" class="secondary" onclick="window.location.href='root/admin_home.jsp'">
                    返回
                </button>
    </div>
</body>
</html>
