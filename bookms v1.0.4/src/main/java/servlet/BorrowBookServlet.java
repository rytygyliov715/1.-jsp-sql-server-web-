package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bean.ConnDB;
import java.sql.*;

public class BorrowBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取页面传来的参数
        int bookId = Integer.parseInt(request.getParameter("book"));
        String username = request.getParameter("username");

        ConnDB connDB = new ConnDB();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 获取数据库连接
            conn = ConnDB.getConnection();

            // 查询用户ID
            String getUserQuery = "SELECT user_id FROM User_tb WHERE username = ?";
            pstmt = conn.prepareStatement(getUserQuery);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");

                // 更新书籍借阅状态和借阅者信息
                String borrowQuery = "UPDATE Book_tb SET borrow_status = 'borrowed', borrower = ? WHERE book_id = ?";
                pstmt = conn.prepareStatement(borrowQuery);
                pstmt.setInt(1, userId);
                pstmt.setInt(2, bookId);
                int result = pstmt.executeUpdate();

                if (result > 0) {
                    response.getWriter().write("Book borrowed successfully.");
                    // 返回用户主页
                    response.setHeader("refresh", "3;url=user/user_home.jsp");
                } else {
                    response.getWriter().write("Failed to borrow the book.");
                }
            } else {
                response.getWriter().write("User not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 关闭结果集、语句和连接
            if (rs != null)
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            if (pstmt != null)
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            if (conn != null)
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
        }
    }
}
