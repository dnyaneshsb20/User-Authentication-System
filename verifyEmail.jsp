<%@ page import="java.sql.*, javax.servlet.http.*, javax.mail.*, javax.mail.internet.*, java.util.Properties, java.util.Random" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String email = request.getParameter("email");
    String dbUrl = "jdbc:oracle:thin:@localhost:1521:XE";
    String dbUser = "system";
    String dbPassword = "oracle";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Database connection
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // Check if email exists
        String sql = "SELECT u.ID, u.NAME FROM USERS u " +
                     "JOIN USER_EMAIL ue ON u.ID = ue.USER_ID " +
                     "WHERE ue.EMAIL = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        rs = stmt.executeQuery();

        if (rs.next()) {
            // Email found, generate OTP
            Random rand = new Random();
            int otp = 100000 + rand.nextInt(900000);

            // Store OTP in session
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);

            // Send OTP via email
            String senderEmail = "authentication.system.otp@gmail.com";
            String senderPassword = "jfcs qoxn ndwa oghk";  // Use your actual credentials

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
                message.setSubject("Your OTP for Password Reset");
                message.setText("Your OTP to reset your password is: " + otp);

                Transport.send(message);

                // Redirect to OTP verification page
                response.sendRedirect("verifyOTP2.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }

        } else {
            out.println("<script>window.onload = function() { passwordUpdated(); }</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <style>
        #passwordUpdated {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.6);
        z-index: 9999;
        justify-content: center;
        align-items: center;
      }

      #passwordUpdated .popup-content {
        background: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
        text-align: center;
        width: 400px;
      }

      #passwordUpdated h2 {
        margin-bottom: 20px;
        color: #2c3e50;
        margin-bottom: 15px;
      }

      #passwordUpdated p {
        font-size: 16px;
        font-size: 16px;
        color: red;
        margin-bottom: 25px;
      }

      #passwordUpdated button {
        margin-top: 20px;
        background: #28a745;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
      }
    </style>
    <script>
        function passwordUpdated() {
            document.getElementById('passwordUpdated').style.display = 'flex';
        }
        function closePopup() {
            document.getElementById('passwordUpdated').style.display = 'none';
        }
    </script>
</head>
<body>
     <div id="passwordUpdated">
      <div class="popup-content">
        <h2>Email Not Registered</h2>
        <p>You are not Registered With this Email!</p>
        <form action="register.jsp" method="post">
            <button onclick="closePopup()">Register Now</button>
        </form>
      </div>
    </div>
</body>
</html>