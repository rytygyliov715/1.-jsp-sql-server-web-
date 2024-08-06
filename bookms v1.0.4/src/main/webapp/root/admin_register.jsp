<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员注册</title>

</head>
<body>

    <h1>管理员注册</h1>
    <form action="../RegisterAdminServlet" method="post">
        <label for="username">用户名:</label><br>
        <input type="text" id="username" name="username"><br>
        <label for="password">密码:</label><br>
        <input type="password" id="password" name="password"><br>
        <input type="submit" value="注册">
        <button type="button" class="secondary" onclick="window.location.href='admin_home.jsp'">
                    返回
                </button>
    </form>

</body>
</html>