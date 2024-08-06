<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, bean.ConnDB" %>
<!DOCTYPE html>
<html>
<head>
    <title>借书</title>
    <style>
        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            margin: 20px;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #1a73e8;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            margin-bottom: 5px;
            font-weight: bold;
            display: block;
        }

        input,
        select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }

        button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background-color: #1a73e8;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }

        button.secondary {
            background-color: #ccc;
        }

        button:hover {
            background-color: #0c5bd3;
        }

        button.secondary:hover {
            background-color: #aaa;
        }

        .dark-mode {
            background-color: #333;
            color: #fff;
        }

        .dark-mode .container {
            background: #444;
        }

        .dark-mode h2 {
            color: #a0c4ff;
        }

        .dark-mode button {
            background-color: #0c5bd3;
        }

        .dark-mode button.secondary {
            background-color: #555;
        }

        .dark-mode button:hover {
            background-color: #0656a3;
        }

        .dark-mode button.secondary:hover {
            background-color: #666;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h2 {
                font-size: 20px;
            }

            input,
            select {
                padding: 8px;
            }

            button {
                padding: 8px 16px;
                font-size: 14px;
            }
        }

        .toggle-switch {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .toggle-switch input {
            display: none;
        }

        .toggle-switch label {
            cursor: pointer;
            background-color: #ccc;
            border-radius: 34px;
            display: inline-block;
            height: 20px;
            position: relative;
            width: 40px;
        }

        .toggle-switch label:after {
            background-color: #fff;
            border-radius: 50%;
            content: "";
            height: 14px;
            left: 3px;
            position: absolute;
            top: 3px;
            transition: 0.3s;
            width: 14px;
        }

        .toggle-switch input:checked + label {
            background-color: #1a73e8;
        }

        .toggle-switch input:checked + label:after {
            transform: translateX(20px);
        }
    </style>
</head>
<body>
    <div class="toggle-switch">
        <input type="checkbox" id="dark-mode-toggle">
        <label for="dark-mode-toggle"></label>
    </div>
    <div class="container">
        <h2>借书</h2>
        <form action="../BorrowBookServlet" method="post" class="form">
            <div class="form-group">
                <label for="username">输入你的用户名:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="book">选择你要借阅的书籍:</label>
                <select id="book" name="book" required>
                    <%
                        ConnDB connDB = new ConnDB();
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            conn = ConnDB.getConnection();
                            String query = "SELECT book_id, book_name FROM Book_tb WHERE borrow_status = 'available'";
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(query);

                            while (rs.next()) {
                                int bookId = rs.getInt("book_id");
                                String bookName = rs.getString("book_name");
                    %>
                    <option value="<%= bookId %>"><%= bookName %></option>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </select>
            </div>
            <button type="submit">借阅</button>
        </form>
        <form action="user_home.jsp" method="get" class="form">
            <button type="submit" class="secondary">返回首页</button>
        </form>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const toggleSwitch = document.getElementById('dark-mode-toggle');
            const body = document.body;

            // Check for saved user preference, if any, on load of the website
            const currentTheme = localStorage.getItem('theme') ? localStorage.getItem('theme') : null;

            if (currentTheme) {
                body.classList.add(currentTheme);

                if (currentTheme === 'dark-mode') {
                    toggleSwitch.checked = true;
                }
            }

            toggleSwitch.addEventListener('change', function() {
                if (toggleSwitch.checked) {
                    body.classList.add('dark-mode');
                    localStorage.setItem('theme', 'dark-mode');
                } else {
                    body.classList.remove('dark-mode');
                    localStorage.setItem('theme', 'light-mode');
                }
            });
        });
    </script>
</body>
</html>
