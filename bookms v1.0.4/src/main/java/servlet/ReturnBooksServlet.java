package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import bean.ConnDB;


public class ReturnBooksServlet extends HttpServlet {
    // 序列化ID
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取要归还的书籍的ID
        String[] bookIds = request.getParameterValues("bookIds");

        // 更新数据库中的书籍信息
        if (bookIds != null && bookIds.length > 0) {
            ConnDB connDB = new ConnDB();
            for (String bookId : bookIds) {
                // 更新书籍的借阅状态和借阅者信息
                String sql = "UPDATE Book_tb SET borrow_status='available', borrower=NULL WHERE book_id=" + bookId;
                // 执行更新操作
                connDB.doUpdate(sql);
            }
            // 关闭数据库连接
            connDB.closeConnection();
        }

        // 归还书籍后重定向回用户主页
        response.sendRedirect("user/user_home.jsp");
    }
}
