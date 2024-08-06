package servlet;

import bean.ConnDB;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        ConnDB connDB = new ConnDB();
        String sql = "SELECT * FROM User_tb WHERE username = '" + username + "' AND password = '" + password + "'";
        ResultSet rs = connDB.doQuery(sql);

        try {
            if (rs != null && rs.next()) {
                // 登录成功，将用户信息存入session
                HttpSession session = request.getSession();
                session.setAttribute("user", username);
                response.sendRedirect("user/user_home.jsp");  // 重定向到用户主页
            } else {
                // 登录失败，将错误信息存储在session中，并重定向到user_error.jsp页面
                request.getSession().setAttribute("error", "用户名或密码错误");
                response.sendRedirect("user/user_error.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // 将错误信息存储在session中，并重定向到user_error.jsp页面
            request.getSession().setAttribute("error", "发生错误，请重试");
            response.sendRedirect("user/user_error.jsp");
        } finally {
            connDB.closeConnection();  // 关闭数据库连接
        }
    }
}