<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="bean.ConnDB" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改书籍</title>

        
    <script>
        function validateForm() {
            var bookName = document.getElementById("book_name").value;
            var author = document.getElementById("author").value;

            if (bookName === "" || author === "") {
                alert("Please fill in all fields");
                return false;
            }

            return true;
        }
    </script>
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

        .center-card {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        
            .game-container {
                text-align: center;
                padding: 20px;
                border-top: 1px solid #ddd;
                margin-top: 20px;
                width: 100%;
            }

            .game-container h3 {
                color: #6c757d;
                font-size: 18px;
            }

            .game-container input {
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-right: 10px;
                font-size: 16px;
            }

            .game-container button {
                padding: 10px 20px;
                background-color: #28a745;
                border: none;
                border-radius: 4px;
                color: white;
                cursor: pointer;
                font-size: 16px;
            }
    </style>

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

        .toggle-button {
            margin-top: 20px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background-color: #333;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }

        .dark-mode {
            background-color: #333;
            color: #fff;
        }

        .dark-mode .container {
            background: #444;
            color: #fff;
        }

        .dark-mode input,
        .dark-mode select {
            background-color: #555;
            border: 1px solid #666;
            color: #fff;
        }

        .dark-mode button {
            background-color: #1a73e8;
        }

        .dark-mode button.secondary {
            background-color: #666;
        }

        .dark-mode button:hover {
            background-color: #0c5bd3;
        }

        .dark-mode button.secondary:hover {
            background-color: #888;
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
    <script>
        function validateForm() {
            // 获取表单元素
            var username = document.getElementById("username").value;
            var currentPassword = document.getElementById("currentPassword").value;
            var newPassword = document.getElementById("newPassword").value;

            // 验证是否全部填写
            if (username === "" || currentPassword === "" || newPassword === "") {
                alert("请完整填写所有字段");
                return false;
            }

            return true;
        }

        function validatePasswords() {
            // 获取密码字段
            var currentPassword = document.getElementById("currentPassword").value;
            var newPassword = document.getElementById("newPassword").value;

            // 验证新旧密码是否一致
            if (currentPassword === newPassword) {
                alert("新密码不能与当前密码相同");
                return false;
            }

            return true;
        }

        function handleSubmit(event) {
            // 验证表单输入是否完整
            if (!validateForm()) {
                event.preventDefault();
                return false;
            }

            // 验证新旧密码是否一致
            if (!validatePasswords()) {
                event.preventDefault();
                return false;
            }

            return true;
        }

        function toggleDarkMode() {
            document.body.classList.toggle('dark-mode');
        }
    </script>
</head>
<body>
    <div class="container">
        <table>
            <tr>
                <td>
                    <div class="container">
                        <h2>书籍数据参考</h2>
                        <table>
                            <tr>
                                <th>书籍 ID</th>
                                <th>书籍名字</th>
                                <th>作者</th>
                            </tr>
                            <% 
                                Connection conn = null;
                                Statement stmt = null;
                                ResultSet rs = null;
                                try {
                                    conn = ConnDB.getConnection(); // 使用ConnDB类获取数据库连接
                                    stmt = conn.createStatement();
                                    String query = "SELECT book_id, book_name, author FROM Book_tb"; // SQL查询，不包括借阅状态
                                    rs = stmt.executeQuery(query);
                                    while(rs.next()) {
                                        out.println("<tr>");
                                        out.println("<td>" + rs.getInt("book_id") + "</td>");
                                        out.println("<td>" + rs.getString("book_name") + "</td>");
                                        out.println("<td>" + rs.getString("author") + "</td>");
                                        out.println("</tr>");
                                    }
                                } catch(SQLException e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace(); }
                                    if (stmt != null) try { stmt.close(); } catch(SQLException e) { e.printStackTrace(); }
                                    if (conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace(); }
                                }
                            %>
                        </table>
                    </div>
                </td>

                <td>
                    <div class="container">
                        <h2>修改书籍</h2>
                        <!-- 表单代码保持不变 -->
                        <form action="../ModifyBookServlet" method="post">
                            <label for="bookId">Book ID:</label><br>
                            <input type="text" id="bookId" name="bookId"><br>
                            <label for="bookName">New Book Name:</label><br>
                            <input type="text" id="bookName" name="bookName"><br>
                            <label for="author">New Author:</label><br>
                            <input type="text" id="author" name="author"><br>
                            <input type="submit" value="Submit">
                        </form>
                    </div>
                </td>

            </tr>

        </table>
<button type="button" class="secondary" onclick="window.location.href='admin_home.jsp'">
                    返回
                </button>
    </div>

</body>

</html>
