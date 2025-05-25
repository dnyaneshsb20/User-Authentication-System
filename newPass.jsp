<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Set New Password</title>
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

      .container {
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        text-align: center;
        width: 500px;
      }

      h2 {
        font-size: 28px;
        font-weight: bold;
        color: #007bff;
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

      input[type="text"],
      input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
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

      #securePassword,
      #passwordMatch {
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

      #securePassword .popup-content,
      #passwordMatch .popup-content {
        background: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
        text-align: center;
        width: 400px;
      }

      #securePassword h2,
      #passwordMatch h2 {
        color: #007bff;
        margin-bottom: 20px;
      }

      #securePassword p,
      #passwordMatch p {
        font-size: 16px;
        color: red;
      }

      #securePassword button,
      #passwordMatch button {
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
        function togglePassword(inputId) {
            var passwordField = document.getElementById(inputId);
            passwordField.type = passwordField.type === "password" ? "text" : "password";
        }

        function validatePasswordForm() {
            const password = document.getElementById("newPassword").value;
            const confirmPassword = document.getElementById("confirmPassword").value;

            const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

            if (!pattern.test(password)) {
                securePassword();
                return false;
            }

            if (password !== confirmPassword) {
                passwordMatch();
                return false;
            }

            return true;
        }

      function securePassword() {
        document.getElementById('securePassword').style.display = 'flex';
      }

      function passwordMatch() {
        document.getElementById('passwordMatch').style.display = 'flex';
      }

      function closePopup() {
        document.getElementById('securePassword').style.display = 'none';
        document.getElementById('passwordMatch').style.display = 'none';
      }
    </script>
  </head>
  <body>
    <div class="container">
      <h2>Set New Password</h2>
      <form action="resetPass.jsp" method="post" onsubmit="return validatePasswordForm();">
        <label for="newPassword">New Password:</label>
        <div style="position: relative">
            <input type="text" name="newPassword" id="newPassword" placeholder="Enter New Password" required />
        </div>

        <label for="confirmPassword">Confirm New Password:</label>
        <div style="position: relative">
            <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Re-enter New Password" required />
            <span onclick="togglePassword('confirmPassword')" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;">
                👁️
            </span>
        </div>

        <input type="submit" value="Update Password" />
    </form>
    </div>

    <!-- Popups -->
    <div id="securePassword">
      <div class="popup-content">
        <h2>🔐 Set Up a Secure Password</h2>
        <p>
          Password must be at least 8 characters long and include uppercase, lowercase, number, and special character.
        </p>
        <button onclick="closePopup()">OK</button>
      </div>
    </div>

    <div id="passwordMatch">
      <div class="popup-content">
        <h2>⚠️ Passwords Must Match</h2>
        <p>Passwords do not match.</p>
        <button onclick="closePopup()">OK</button>
      </div>
    </div>
  </body>
</html>
