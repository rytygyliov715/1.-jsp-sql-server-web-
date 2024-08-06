package servlet;

import bean.ConnDB;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "ViewBooksServlet", value = "ViewBooksServlet")
public class ViewBooksServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ConnDB connDB = new ConnDB();
        String sql = "SELECT book_name, author, borrow_status FROM Book_tb";
        ResultSet rs = connDB.doQuery(sql);

        try {
            request.setAttribute("books", rs);
            RequestDispatcher dispatcher = request.getRequestDispatcher("root/view_books.jsp");
            dispatcher.forward(request, response);
        } finally {
            connDB.closeConnection(); // 关闭数据库连接
        }
    }
}