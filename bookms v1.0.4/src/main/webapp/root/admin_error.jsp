
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>error</title>

</head>
<body>
    <div class="container">
        <div class="center-card">
            <h2>Error</h2>
            <!-- Display error message -->
            <p style="color:red">${sessionScope.error}</p> 
            <!-- 返回 -->
            <button type="button" class="secondary" onclick="window.location.href='admin_home.jsp'">
                返回
            </button>
        </div>
    
    </div>
</body>
</html>
