package servlet;

import bean.ConnDB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ViewUsersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ConnDB connDB = new ConnDB();
        ResultSet rsUsers = connDB.doQuery("SELECT * FROM User_tb");
        ResultSet rsBorrowedBooks = connDB.doQuery("SELECT User_tb.user_id, User_tb.username, Book_tb.book_name FROM User_tb INNER JOIN Book_tb ON User_tb.user_id = Book_tb.borrower WHERE Book_tb.borrow_status = 'borrowed'");

        request.setAttribute("users", rsUsers);
        request.setAttribute("borrowedBooks", rsBorrowedBooks);
        RequestDispatcher rd = request.getRequestDispatcher("root/view_users.jsp");
        rd.forward(request, response);
    }
}