<%@ page import="java.sql.*, java.util.Random" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form with CAPTCHA</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(to bottom, #e6ffe6, #ffffff);
        }
        .login-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 500px;
        }
        .title {
            font-size: 28px;
            font-weight: bold;
            color: #007bff;
            text-transform: uppercase;
            margin-bottom: 15px;
            letter-spacing: 1.5px;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
            white-space: nowrap;
        }
        label {
            font-weight: bold;
            display: block; 
            text-align: left;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="password"] {
            width: 100%; 
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box; 
            font-family: Arial, sans-serif;
            font-size: 16px; 
            font-weight: normal;
        }
        input[type="submit"] {
            background: #28a745;
            color: white;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background: #218838;
        }
        body {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
    <script>
        function togglePassword() {
            var passwordField = document.getElementById("password");
            if (passwordField.type === "password") {
                passwordField.type = "text";
            } else {
                passwordField.type = "password";
            }
        }
     
        function validateCaptchaInput(event) {
            const char = String.fromCharCode(event.which);
            const isAlphaNumeric = /^[a-zA-Z0-9]$/.test(char);
            if (!isAlphaNumeric) {
                event.preventDefault(); 
            }
        }

        window.onload = function() {
            const captchaField = document.getElementById("captcha");
            if (captchaField) {
                captchaField.addEventListener("keypress", validateCaptchaInput);
            }
        }
    </script>
</head>
    <body>
        <div class="login-container">
        <h2 class="title">User Authentication System</h2>
        <h2>User Login</h2>
        <form action="validateCaptcha.jsp" method="post">
            <label for="email">Enter Email:</label>
            <input type="text" name="email" id="email" required>

            <label for="password">Enter Password:</label>
            <div style="position: relative; display: flex; align-items: center;">
                <input type="password" name="password" id="password" required 
                    style="width: 100%; padding-right: 40px;">
                <span onclick="togglePassword()" 
                    style="position: absolute; right: 10px; cursor: pointer; font-size: 18px; color: #555;">
                    👁️
                </span>
            </div>
            <div style="text-align: left; margin-bottom: 10px;">
                <a href="forgotPass.jsp" style="text-decoration: none; color: #007bff;">Forgot Password?</a>
            </div>

            <div>
                <img src="captcha.jsp?<%= System.currentTimeMillis() %>" alt="CAPTCHA Image">
            </div>

            <!-- User inputs CAPTCHA -->
            <label for="captcha">Enter CAPTCHA:</label>
            <input type="text" name="captcha" id="captcha" required>

            <input type="submit" value="Login">
            <p>Not registered? <a href="register.jsp">Sign up here</a></p>
        </form>
        </div>
    </body>
</html>