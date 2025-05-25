<%@ page import="java.sql.*, javax.servlet.http.*, java.util.*, javax.crypto.Cipher, javax.crypto.spec.SecretKeySpec, java.util.Properties, javax.mail.*, javax.mail.internet.*" %>
<%@ include file="EncryptionUtil.jsp" %>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String enteredCaptcha = request.getParameter("captcha");

    String sessionCaptcha = (String) session.getAttribute("captcha");

    if (enteredCaptcha == null || !enteredCaptcha.equals(sessionCaptcha)) {
        response.sendRedirect("invalid.jsp");
        return;
    }

    String dbUrl = "jdbc:oracle:thin:@localhost:1521:XE";
    String dbUser = "system";
    String dbPassword = "oracle";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    boolean userExists = false;
    boolean passwordCorrect = false;
    String decryptedPassword = "";

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        String sql = "SELECT u.NAME, u.PASSWORD FROM USERS u " +
                     "JOIN USER_EMAIL ue ON u.ID = ue.USER_ID " +
                     "WHERE ue.EMAIL = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        rs = stmt.executeQuery();

        if (rs.next()) {
            userExists = true;
            String encryptedPassword = rs.getString("password");
            decryptedPassword = decrypt(encryptedPassword);

            if (decryptedPassword.equals(password)) {
                passwordCorrect = true;
                session.setAttribute("username", rs.getString("name"));
                session.setAttribute("email", email);

                Random rand = new Random();
                int otp = 100000 + rand.nextInt(900000);
                session.setAttribute("otp", otp);

                String senderEmail = "authentication.system.otp@gmail.com";
                String senderPassword = "jfcs qoxn ndwa oghk";

                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");

                Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(senderEmail, senderPassword);
                    }
                });

                try {
                    Message message = new MimeMessage(mailSession);
                    message.setFrom(new InternetAddress(senderEmail, "Authentication System"));
                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                    message.setSubject("Your OTP Code");
                    message.setText("Your OTP for login is: " + otp + "\n\nDo not share this code with anyone. \n\nThis is system generated mail do not reply!");

                    Transport.send(message);
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("error.jsp");
                    return;
                }

                response.sendRedirect("verifyOtp.jsp");
                return;
            }
            else {
                response.sendRedirect("invalid.jsp"); // Redirect back to login page
                return;
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
        return;
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }

%>
<!DOCTYPE html>
<html>
<head>
    <title>Validation Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .popup-container {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            width: 400px;
            padding: 30px;
            box-shadow: 0px 0px 10px #ccc;
            border-radius: 10px;
            text-align: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .popup-container h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .popup-container p {
            color: #666;
            font-size: 16px;
            margin-bottom: 25px;
        }
        .popup-container button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 5px;
            font-size: 15px;
            cursor: pointer;
            font-family: 'Segoe UI', sans-serif;
        }
        .popup-container button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="popup-container">
        <h2>User does not exist!</h2>
        <p>Please register to continue.</p>
        <button onclick="window.location.href='register.jsp'">Register</button>
    </div>
</body>
</html>
