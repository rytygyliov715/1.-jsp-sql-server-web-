package servlet;

import bean.ConnDB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;

//@WebServlet(name = "DeleteUsersServlet", value = "/DeleteUsersServlet")
public class DeleteUsersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ConnDB connDB = new ConnDB();
        ResultSet rsUsers = connDB.doQuery("SELECT * FROM User_tb");
        request.setAttribute("users", rsUsers);
        RequestDispatcher rd = request.getRequestDispatcher("root/delete_users.jsp");
        rd.forward(request, response);
    }
}