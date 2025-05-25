<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String currentDate = new SimpleDateFormat("EEEE, MMMM dd, yyyy").format(new Date());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: linear-gradient(to bottom, #e6ffe6, #ffffff);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            text-align: center;
            max-width: 1000px;
            padding: 20px;
        }

        h1 {
            font-size: 36px;
            color: #007bff;
            margin-bottom: 10px;
        }

        .date {
            font-size: 18px;
            color: #333;
            margin-bottom: 10px;
        }

        .quote {
            font-size: 16px;
            color: #555;
            margin-bottom: 40px;
        }

        .sections {
            display: flex;
            gap: 30px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .card {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            width: 280px;
            text-align: left;
        }

        .card h3 {
            font-size: 20px;
            color: #007bff;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card p {
            font-size: 14px;
            color: #444;
            margin-bottom: 15px;
        }

        .card a {
            display: inline-block;
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .card a:hover {
            background-color: #218838;
        }

        /* Popup styles */
        #comingSoonPopup {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }

        #comingSoonPopup .popup-content {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.3);
            text-align: center;
            width: 400px;
        }

        #comingSoonPopup h2 {
            color: #007bff;
            margin-bottom: 20px;
        }

        #comingSoonPopup p {
            font-size: 16px;
            color: #444;
        }

        #comingSoonPopup button {
            margin-top: 20px;
            background: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>

    <script>
        function showComingSoonPopup() {
            document.getElementById('comingSoonPopup').style.display = 'flex';
        }

        function closePopup() {
            document.getElementById('comingSoonPopup').style.display = 'none';
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Welcome, <%= username %>! 👋</h1>
        <div class="date"><%= currentDate %></div>
        <div class="quote">"The only way to do great work is to love what you do."</div>

        <div class="sections">
            <div class="card">
                <h3>📁 Profile</h3>
                <p>View or edit your profile information.</p>
                <a href="javascript:void(0);" onclick="showComingSoonPopup()">Go to Profile</a>
            </div>

            <div class="card">
                <h3>📊 Statistics</h3>
                <p>View your account usage statistics.</p>
                <a href="javascript:void(0);" onclick="showComingSoonPopup()">View Stats</a>
            </div>

            <div class="card">
                <h3>🔒 Logout</h3>
                <p>Sign out of your account securely.</p>
                <a href="logout.jsp">Log Out</a>
            </div>
        </div>
    </div>

    <!-- Coming Soon Popup -->
    <div id="comingSoonPopup">
        <div class="popup-content">
            <h2>Coming Soon 🚧</h2>
            <p>This feature is under development. Stay tuned!</p>
            <button onclick="closePopup()">OK</button>
        </div>
    </div>
</body>
</html>
