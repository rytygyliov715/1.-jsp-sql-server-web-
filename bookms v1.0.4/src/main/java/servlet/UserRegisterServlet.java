package servlet;

import bean.ConnDB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "UserRegisterServlet", value = "/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置请求和响应的字符编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 获取表单参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");

        // 检查数据是否完整
        if (username == null || password == null || phone == null || email == null || gender == null) {
            // 数据不完整，将错误信息存储在session中，并重定向到user_error.jsp页面
            request.getSession().setAttribute("error", "Registration failed. Please complete all fields.");
            response.sendRedirect("user/user_error.jsp");
            return;
        }

        // 连接数据库并插入用户数据
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = ConnDB.getConnection();
            String sqlCheck = "SELECT * FROM User_tb WHERE username = ? OR phone_number = ? OR email = ?";
            pstmt = conn.prepareStatement(sqlCheck);
            pstmt.setString(1, username);
            pstmt.setString(2, phone);
            pstmt.setString(3, email);
            rs = pstmt.executeQuery();

            // 检查是否存在相同的用户名、电话号码或电子邮箱
            if (rs.next()) {
                // 注册失败，将错误信息存储在session中，并重定向到user_error.jsp页面
                request.getSession().setAttribute("error", "Registration failed. Username, phone number or email already exists.");
                response.sendRedirect("user/user_error.jsp");
            } else {
                // 插入新的用户记录
                String sqlInsert = "INSERT INTO User_tb (username, password, phone_number, email, gender) VALUES (?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sqlInsert);
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                pstmt.setString(3, phone);
                pstmt.setString(4, email);
                pstmt.setString(5, gender);
                pstmt.executeUpdate();

                // 注册成功，重定向到user_register_success.html页面
                response.sendRedirect("user/user_register_success.html");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // 将错误信息存储在session中，并重定向到user_error.jsp页面
            request.getSession().setAttribute("error", "An error occurred. Please try again.");
            response.sendRedirect("user/user_error.jsp");
        } finally {
            // 关闭数据库连接
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}