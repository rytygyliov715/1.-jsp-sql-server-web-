<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
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
            flex-direction: column;
        }

        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #d9534f;
        }

        p {
            color: #d9534f;
            font-size: 18px;
            margin-bottom: 20px;
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

        .dark-mode h2, .dark-mode p {
            color: #ff4d4d;
        }

        .dark-mode button {
            background-color: #0c5bd3;
        }

        .dark-mode button:hover {
            background-color: #0656a3;
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

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h2 {
                font-size: 20px;
            }

            p {
                font-size: 16px;
            }

            button {
                padding: 8px 16px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="toggle-switch">
        <input type="checkbox" id="dark-mode-toggle">
        <label for="dark-mode-toggle"></label>
    </div>
    <div class="container">
        <h2>Error</h2>
        <p>${sessionScope.error}</p> <!-- Display error message -->
        <form action="login.jsp" method="get">
            <button type="submit">返回登录页面</button>
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
