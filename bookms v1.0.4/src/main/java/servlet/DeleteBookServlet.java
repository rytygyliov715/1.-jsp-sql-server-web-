package servlet;

import bean.ConnDB;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "DeleteBookServlet", value = "/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] bookIds = request.getParameterValues("book_id");

        ConnDB connDB = new ConnDB();
        for (String bookId : bookIds) {
            String sql = "DELETE FROM Book_tb WHERE book_id = '" + bookId + "'";
            connDB.doUpdate(sql);
        }
        connDB.closeConnection();

        response.sendRedirect("root/admin_home.jsp");
    }
}