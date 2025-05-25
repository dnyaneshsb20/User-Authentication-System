<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<html>
<head>
    <title>Verify OTP</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .container {
            width: 350px;
            margin: 100px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            text-align: center;
        }
    </style>
    <script>
        function validateOTP(event, input) {
            const key = event.key;
        
            if (!/^[0-9]$/.test(key) && key !== 'Backspace' && key !== 'Delete' && key !== 'Enter'){
                event.preventDefault(); 
            }

            if (input.value.length >= 6 && key !== 'Backspace' && key !== 'Delete' && key !== 'Enter'){
                event.preventDefault(); 
            }
          
            input.value = input.value.replace(/[^0-9]/g, '');
        }

        window.onload = function() {
            const otpField = document.getElementById("otp"); 
            if (otpField) {
                otpField.addEventListener("keydown", function(event) {
                    validateOTP(event, otpField);
                });
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Verify OTP</h2>

        <form action="newPass.jsp" method="post">
            <p style="color: #ff0000; font-size: 14px; margin-bottom: 5px;">
                Kindly <strong>type the OTP manually</strong>. Do not copy-paste.
            </p>
            <label>Enter the OTP sent to your email:</label>
            <input type="text" name="otp" id="otp" maxlength="6" oninput="allowOnlyNumbers(this)" required>
            <input type="submit" value="Verify OTP">
        </form>
    </div>
</body>
</html>
