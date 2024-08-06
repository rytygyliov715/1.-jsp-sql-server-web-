package servlet;

import bean.ConnDB;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;

public class RegisterAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 创建数据库连接对象
        ConnDB connDB = new ConnDB();

        // 检查用户名是否已存在
        String checkUsernameSql = "SELECT * FROM Root_tb WHERE username = '" + username + "'";
        ResultSet rs = connDB.doQuery(checkUsernameSql);
        try {
            if (rs != null && rs.next()) {
                request.setAttribute("error", "用户名已存在，请更换");
                request.getRequestDispatcher("admin_register.jsp").forward(request, response);
            } else {
                // 将新的管理员信息写入数据库
                String addAdminSql = "INSERT INTO Root_tb(username, password) VALUES('" + username + "', '" + password + "')";
                connDB.doUpdate(addAdminSql);

                // 重定向到管理员登录页面
                response.sendRedirect("root/admin_login.html");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            connDB.closeConnection();
        }
    }
}