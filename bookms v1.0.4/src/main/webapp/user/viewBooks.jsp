<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, bean.ConnDB" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>View Books</title>
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
            transition: background-color 0.3s, color 0.3s;
        }

        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            width: 100%;
            margin: 20px;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #1a73e8;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
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

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h2 {
                font-size: 20px;
            }

            th, td {
                padding: 8px;
            }

            button {
                padding: 8px 16px;
                font-size: 14px;
            }
        }

        /* Dark Mode */
        body.dark-mode {
            background-color: #333;
            color: #ddd;
        }

        .container.dark-mode {
            background: #555;
            color: #ddd;
        }

        h2.dark-mode {
            color: #1a73e8;
        }

        th.dark-mode {
            background-color: #444;
            color: #ddd;
        }

        td.dark-mode {
            background-color: #555;
            color: #ddd;
        }

        tr.dark-mode:hover {
            background-color: #444;
        }

        button.dark-mode {
            background-color: #1a73e8;
        }

        button.dark-mode:hover {
            background-color: #0c5bd3;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>Available Books</h2>

        <table>
            <tr>
                <th>Book Name</th>
                <th>Author</th>
            </tr>
            <%
                ConnDB connDB = new ConnDB();
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    conn = ConnDB.getConnection();
                    String query = "SELECT book_name, author FROM Book_tb WHERE borrow_status = 'available'";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        String bookName = rs.getString("book_name");
                        String author = rs.getString("author");
            %>
            <tr>
                <td><%= bookName %></td>
                <td><%= author %></td>
            </tr>
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
        </table>

        <form action="user_home.jsp" method="get">
            <button type="submit">Return to Home</button>
        </form>

        <form action="borrowBook.jsp" method="get">
            <button type="submit">Borrow Book</button>
        </form>
          <form action="user_home.jsp" method="get" class="form">
            <button type="submit" class="secondary">返回首页</button>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
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

            toggleSwitch.addEventListener('change', function () {
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
