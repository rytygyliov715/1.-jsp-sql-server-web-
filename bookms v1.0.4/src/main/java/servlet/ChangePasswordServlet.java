package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bean.ConnDB;
import java.sql.*;

public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 获取表单参数
        String username = request.getParameter("username");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        // 检查参数是否正确
        ConnDB connDB = new ConnDB();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {

            // 获取数据库连接
            conn = ConnDB.getConnection();

            // 查询用户是否存在
            String query = "SELECT password FROM User_tb WHERE username = ?";

            // 创建 PreparedStatement 对象
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, username);

            // 执行 SQL 语句
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 用户存在，检查当前密码是否正确
                String storedPassword = rs.getString("password");

                // 如果当前密码正确，则更新密码
                if (storedPassword.equals(currentPassword)) {

                    // 更新密码
                    String update = "UPDATE User_tb SET password = ? WHERE username = ?";
                    // 创建 PreparedStatement 对象
                    pstmt = conn.prepareStatement(update);

                    // 设置参数
                    pstmt.setString(1, newPassword);
                    pstmt.setString(2, username);
                    // 执行 SQL 语句
                    int result = pstmt.executeUpdate();

                    if (result > 0) {
                        // 修改密码成功后，重定向到 changePasswordSuccess.jsp 页面
                        response.sendRedirect("user/changePasswordSuccess.jsp");
                    } else {
                        // 修改密码失败后，向客户端输出错误信息
                        response.getWriter().write("Failed to update password.");
                    }
                } else {
                    // 当前密码错误
                    response.getWriter().write("Current password is incorrect.");
                }
            } else {
                // 用户不存在
                response.getWriter().write("User not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 关闭数据库连接
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
