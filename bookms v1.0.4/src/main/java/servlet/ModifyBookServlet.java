package servlet;

import bean.ConnDB;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ModifyBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("bookId");
        String bookName = request.getParameter("bookName");
        String author = request.getParameter("author");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = ConnDB.getConnection();
            String sql = "UPDATE Book_tb SET book_name = ?, author = ? WHERE book_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, bookName);
            stmt.setString(2, author);
            stmt.setString(3, bookId);
            stmt.executeUpdate();
            response.sendRedirect("ViewBooksServlet");
        } catch (SQLException e) {
            //假设错误是由同名的书籍引起的
            request.setAttribute("errorMessage", "A book with the same name already exists.");
            RequestDispatcher rd = request.getRequestDispatcher("root/root_error_page.jsp");
            rd.forward(request, response);
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}