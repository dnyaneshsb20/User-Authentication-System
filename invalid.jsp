<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Invalid Login</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }
        .container {
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
            color: #dc3545; /* Red for Error */
            text-transform: uppercase;
            margin-bottom: 15px;
            letter-spacing: 1.5px;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
        }
        .message {
            font-size: 18px;
            color: #333;
            margin-bottom: 20px;
        }
        .back-btn {
            background: #28a745; /* Same Green as Login */
            color: white;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            width: 100px;
        }
        .back-btn:hover {
            background: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="title">Invalid Login</h1>
        <p class="message">The email or password you entered is incorrect, or CAPTCHA verification failed.</p>
        <a href="login.jsp" class="back-btn">Try Again</a>
    </div>
</body>
</html>
