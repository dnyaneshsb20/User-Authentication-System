<%@ page session="true" %>
<%
    session.invalidate(); // Destroy session
    response.sendRedirect("login.jsp"); // Redirect to login page
%>
