<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(to bottom, #e6ffe6, #ffffff);
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        .login-container {
            background: white;
            padding: 20px 30px;
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
        }

        label {
            font-weight: bold;
            display: block;
            text-align: left;
            margin-bottom: 5px;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
            font-size: 16px;
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

        .back-link {
            margin-top: 10px;
            display: block;
            font-size: 14px;
        }

        .back-link a {
            color: #007bff;
            text-decoration: none;
        }

        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function validateEmail(input) {
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (!emailRegex.test(input.value)) {
              input.setCustomValidity("Please enter a valid email address.");
            } else {
              input.setCustomValidity("");
            }
      }
    </script>
</head>
<body>
    <div class="login-container">
        <h2 class="title">Forgot Password</h2>
        <form action="verifyEmail.jsp" method="post">
            <label for="email">Enter Registered Email ID:</label>
            <input type="text" name="email" id="email" oninput="validateEmail(this)" required>

            <input type="submit" value="Send OTP">

            <div class="back-link">
                <a href="login.jsp">← Back to Login</a>
            </div>
        </form>
    </div>
</body>
</html>
