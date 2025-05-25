<%@ page import="java.security.MessageDigest" %>
<%@ page import="javax.crypto.Cipher, javax.crypto.spec.SecretKeySpec" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Password Converter</title>
    <style>
        body {
            background-color: #f2f2f2;
            font-family: Arial, sans-serif;
        }
        .container {
            margin: 100px auto;
            padding: 30px 40px;
            width: 400px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
        }
        .input-wrapper {
            position: relative;
            margin-bottom: 20px;
        }
        .input-wrapper input[type="password"],
        .input-wrapper input[type="text"] {
            width: 100%;
            padding: 10px 40px 10px 15px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            outline: none;
            box-sizing: border-box;
        }
        .input-wrapper i {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 16px;
            color: #555;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #1e90ff;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
        .output {
            margin-top: 20px;
        }
        .output p {
            background-color: #e8f0fe;
            padding: 10px;
            font-family: monospace;
            font-size: 14px;
            border-radius: 5px;
            word-break: break-word;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Password Converter</h2>
        <form method="post">
            <div class="input-wrapper">
                <input type="password" name="password" id="password" placeholder="Enter your password" required />
                <i onclick="togglePassword()">👁️</i>
            </div>
            <input type="submit" value="Convert" />
        </form>

        <%
            String password = request.getParameter("password");
            if (password != null && !password.isEmpty()) {
                // SHA-256 Hashing
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                md.update(password.getBytes());
                byte[] digest = md.digest();
                StringBuilder hashSB = new StringBuilder();
                for (byte b : digest) {
                    hashSB.append(String.format("%02x", b));
                }
                String hashedPassword = hashSB.toString();

                // AES Encryption
                String key = "1234567890123456"; // 16-byte key
                SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "AES");
                Cipher cipher = Cipher.getInstance("AES");
                cipher.init(Cipher.ENCRYPT_MODE, secretKey);
                byte[] encryptedBytes = cipher.doFinal(password.getBytes());
                StringBuilder encryptedSB = new StringBuilder();
                for (byte b : encryptedBytes) {
                    encryptedSB.append(String.format("%02x", b));
                }
                String encryptedPassword = encryptedSB.toString();
        %>

        <div class="output">
            <p><strong>Hashed Password:</strong><br><%= hashedPassword %></p>
            <p><strong>Encrypted Password (AES):</strong><br><%= encryptedPassword %></p>
        </div>

        <% } %>
    </div>

    <script>
        function togglePassword() {
            const input = document.getElementById("password");
            input.type = input.type === "password" ? "text" : "password";
        }
    </script>
</body>
</html>
