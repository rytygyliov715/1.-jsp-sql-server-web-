<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--使用ConnDB--%>
<%@ page import="bean.ConnDB"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>管理员主页</title>

    </head>
    <body>
        <%
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
            <h2>Welcome, ${admin}!</h2>

            <%-- 显示现在数据库有多少图书数据 --%>
            <p>图书总数: <%= totalBooks %></p>

            <%-- 显示现在有多少本图书在借 --%>
            <p>目前借阅的图书数量: <%= borrowedBooks %></p>

            <p>选择你要执行的操作</p>
            <form action="../ViewBooksServlet" method="get">
                <button type="submit">查看所有书籍</button>
            </form>

            <form action="add_book.html" method="get">
                <button type="submit">添加新书</button>
            </form>

            <form action="delete_book.jsp" method="get">
                <button type="submit">删除图书</button>
            </form>

            <form action="modify_book.jsp" method="get">
                <button type="submit">修改图书数据</button>
            </form>

            <form action="../ViewUsersServlet" method="get">
                <button type="submit">查看所有用户</button>
            </form>

            <form action="../DeleteUsersServlet" method="get">
                <button type="submit">删除用户</button>
            </form>

            <form action="modify_password.jsp" method="get">
                <button type="submit">修改密码</button>
            </form>

            <form action="admin_register.jsp" method="get">
    <button type="submit">添加管理员</button>
</form>

<%--      退出登录到首页      --%>
<form action="../index.jsp" method="get">
    <button type="submit">退出登录</button>
    <button class="toggle-button" onclick="toggleDarkMode()">切换黑夜模式</button>

        </div>
    </body>
</html>