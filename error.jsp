<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffe6e6;
            color: #990000;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .error-box {
            text-align: center;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
    <div class="error-box">
        <h1>⚠️ Oops! Something went wrong.</h1>
        <p>Please try again later.</p>
        <a href="login.jsp">Back to Login</a>
    </div>
</body>
</html>
