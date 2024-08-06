<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, bean.ConnDB, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>删除图书</title>

</head>
</head>
<body>

    <h2>删除图书</h2>
    <form action="../DeleteBookServlet" method="post">
        <table>
            <tr>
                <th>选择</th>
                <th>书名</th>
                <th>作者</th>
            </tr>
            <%
                ConnDB connDB = new ConnDB();
                String sql = "SELECT * FROM Book_tb WHERE borrow_status = 'available'";
                ResultSet rs = connDB.doQuery(sql);
                while (rs.next()) {
            %>
            <tr>
                <td><input type="checkbox" name="book_id" value="<%=rs.getString("book_id")%>"></td>
                <td><%=rs.getString("book_name")%></td>
                <td><%=rs.getString("author")%></td>
            </tr>
            <%
                }
                connDB.closeConnection();
            %>
        </table>
        <input type="submit" value="删除所选图书">
    </form>
    <button type="button" class="secondary" onclick="window.location.href='admin_home.jsp'">
                    返回
                </button>

</body>
</html>
