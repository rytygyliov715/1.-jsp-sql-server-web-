package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.sql.*;
import bean.ConnDB;

public class ModifyPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        if (!newPassword.equals(confirmNewPassword)) {
            response.sendRedirect("error.jsp?message=New password and confirmation do not match.");
            return;
        }

        ConnDB connDB = new ConnDB();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnDB.getConnection();
            String query = "SELECT * FROM Root_tb WHERE username = ? AND password = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, currentPassword);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String updateQuery = "UPDATE Root_tb SET password = ? WHERE username = ?";
                stmt = conn.prepareStatement(updateQuery);
                stmt.setString(1, newPassword);
                stmt.setString(2, username);
                stmt.executeUpdate();
                response.sendRedirect("root/admin_login.html");
            } else {
                response.sendRedirect("error.jsp?message=Incorrect username or current password.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("root/error.jsp?message=Database error.");
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (stmt != null)
                    stmt.close();
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
