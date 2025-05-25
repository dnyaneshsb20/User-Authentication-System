<%@ page import="javax.servlet.http.*, java.io.*" %>
<%
    // Retrieve the OTP entered by the user
    String enteredOTP = request.getParameter("otp");

    // Retrieve the OTP stored in session
    String sessionOTP = String.valueOf(session.getAttribute("otp"));

    if (sessionOTP != null && enteredOTP.equals(sessionOTP)) {
        // OTP is correct, redirect to the dashboard
        session.removeAttribute("otp"); // Remove OTP from session for security
        response.sendRedirect("dashboard.jsp");
    } else {
%>
        <script>
            alert("Invalid OTP! Please try again.");
            window.location.href = "verifyOTP.jsp";
        </script>
<%
    }
%>
