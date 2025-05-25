<%@ page import="java.sql.*" %>
<%@ include file="EncryptionUtil.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // Retrieve email from session
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        out.println("<script>alert('User not logged in.'); window.location='login.jsp';</script>");
        return;
    }

    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    String encryptedPassword = encrypt(newPassword);

    String dbUrl = "jdbc:oracle:thin:@localhost:1521:XE";
    String dbUser = "system";
    String dbPassword = "oracle";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Debugging: Print out user email and encrypted password
        out.println("<script>console.log('Email: " + userEmail + "');</script>");
        out.println("<script>console.log('Encrypted Password: " + encryptedPassword + "');</script>");

        // Connect to database
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // SQL query to update the password
        String sql = "UPDATE USERS SET PASSWORD = ? WHERE ID = (SELECT USER_ID FROM USER_EMAIL WHERE EMAIL = ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, encryptedPassword);
        stmt.setString(2, userEmail);

        int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated > 0) {
            out.println("<script>window.onload = function() { passwordUpdated(); }</script>");

        } else {
            response.sendRedirect("error.jsp");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
        return;
    } finally {
        try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
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
        color: #555;
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
        <h2>Password Updated 🎉</h2>
        <p>Password Changed Sucessfully</p>
        <form action="login.jsp" method="post">
            <button onclick="closePopup()">Login Now</button>
        </form>
      </div>
    </div>
</body>
</html>