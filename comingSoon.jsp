<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Coming Soon</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: linear-gradient(to bottom, #e6ffe6, #ffffff);
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .popup-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 450px;
        }

        .popup-title {
            font-size: 26px;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .popup-message {
            font-size: 18px;
            color: #444;
            margin-bottom: 20px;
        }

        .popup-button {
            background-color: #28a745;
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .popup-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="popup-container">
        <div class="popup-title">Coming Soon 🚧</div>
        <div class="popup-message">This feature is under development. Stay tuned!</div>
        <a href="dashboard.jsp" class="popup-button">Back to Login</a>
    </div>
</body>
</html>
