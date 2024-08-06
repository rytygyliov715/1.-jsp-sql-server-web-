package servlet;

import bean.ConnDB;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "AddBookServlet", value = "/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookName = request.getParameter("book_name");
        String author = request.getParameter("author");

        // 页面使用UTF-8编码
        response.setContentType("text/html;charset=UTF-8");

        ConnDB connDB = new ConnDB();
        String checkSql = "SELECT * FROM Book_tb WHERE book_name = '" + bookName + "'";
        ResultSet rs = connDB.doQuery(checkSql);

        try {
            if (rs.next()) {
                // 如果已存在同名图书，请重定向到错误页面
                response.sendRedirect("root/add_book_error.html");
            } else {
                // 如果不存在同名图书，请插入新图书
                String insertSql = "INSERT INTO Book_tb (book_name, author, borrow_status) VALUES ('" + bookName
                        + "', '" + author + "', 'available')";
                connDB.doUpdate(insertSql);
                response.sendRedirect("root/admin_home.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 关闭数据库连接
            connDB.closeConnection();
        }
    }
}