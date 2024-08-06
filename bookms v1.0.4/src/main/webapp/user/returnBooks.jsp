<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>归还书籍</title>
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
            max-width: 600px;
            width: 100%;
            margin: 20px;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #1a73e8;
            text-align: center;
        }

        .form {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            margin-bottom: 5px;
            font-weight: bold;
        }

        input, select, table {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }

        table {
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        th {
            background-color: #f4f4f9;
            color: #333;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f1f1f1;
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

        button:hover {
            background-color: #0c5bd3;
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

        .dark-mode th {
            background-color: #555;
            color: #fff;
        }

        .dark-mode tr:hover {
            background-color: #666;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h2 {
                font-size: 20px;
            }

            input, select, table, th, td {
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
        <h2>归还书籍</h2>
        <form action="../ReturnBooksServlet" method="post">
            <%
                HttpSession httpSession = request.getSession();
                String username = (String) httpSession.getAttribute("user");

                bean.ConnDB connDB = new bean.ConnDB();
                ResultSet rs = null;
                int userId = 0;

                // 获取当前用户ID
                String sql = "SELECT user_id FROM User_tb WHERE username='" + username + "'";
                rs = connDB.doQuery(sql);
                if (rs.next()) {
                    userId = rs.getInt("user_id");
                }

                // 获取用户借阅的书籍
                sql = "SELECT book_id, book_name FROM Book_tb WHERE borrower=" + userId;
                rs = connDB.doQuery(sql);
            %>
            <table>
                <tr>
                    <th>选择</th>
                    <th>书名</th>
                </tr>
                <%
                    while (rs.next()) {
                %>
                <tr>
                    <td><input type="checkbox" name="bookIds" value="<%= rs.getInt("book_id") %>"></td>
                    <td><%= rs.getString("book_name") %></td>
                </tr>
                <%
                    }
                    connDB.closeConnection();
                %>
            </table>
            <button type="submit">归还所选书籍</button>
        </form>
        <form action="user_home.jsp" method="get">
            <button type="submit" class="secondary">返回主页</button>
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
