<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register</title>
    <style>
      body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background: linear-gradient(to bottom, #e6ffe6, #ffffff);
      }
      .register-container {
        background: white;
        padding: 20px;
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
        white-space: nowrap;
      }
      label {
        font-weight: bold;
        display: block;
        text-align: left;
        margin-bottom: 5px;
      }
      input[type="text"],
      input[type="password"],
      input[type="email"],
      input[type="tel"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
        font-size: 16px;
        font-weight: normal;
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
      body {
        margin: 0;
        padding: 0;
        overflow: hidden;
      }
      #securePassword {
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

        #securePassword .popup-content {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.3);
            text-align: center;
            width: 400px;
        }

        #securePassword h2 {
            color: #007bff;
            margin-bottom: 20px;
        }

        #securePassword p {
            font-size: 16px;
            color: red;
        }

        #securePassword button {
            margin-top: 20px;
            background: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        #passwordMatch {
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

        #passwordMatch .popup-content {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.3);
            text-align: center;
            width: 400px;
        }

        #passwordMatch h2 {
            color: #007bff;
            margin-bottom: 20px;
        }

        #passwordMatch p {
            font-size: 16px;
            color: red;
        }

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
        function togglePassword(inputId, iconId) {
            var passwordField = document.getElementById(inputId);
            if (passwordField.type === "password") {
              passwordField.type = "text";
            } else {
              passwordField.type = "password";
            }
        }

        function validatePasswordForm() {
            const password = document.getElementById("password").value;
            const confirmPassword =
              document.getElementById("confirm_password").value;
            const errorBox = document.getElementById("password-error");

            const pattern =
              /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#!%*?&])[A-Za-z\d@$#!%*?&]{8,}$/;
            console.log("Password:", password);
            console.log("Pattern match:", pattern.test(password));

            errorBox.innerText = "";
            errorBox.style.display = "none";

            if (!pattern.test(password)) {
              securePassword();
              return false;
            }

            if (password !== confirmPassword) {
              passwordMatch();
              return false;
            }

            errorBox.style.display = "none";
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
    <div class="register-container">
      <h2 class="title">User Authentication System</h2>
      <h2>User Registration</h2>
      <form action="registerUser.jsp" method="post" onsubmit="return validatePasswordForm();">
        <label for="name">Full Name:</label>
        <input type="text" name="name" id="name" oninput="validateName(this)" placeholder="Enter Your Full Name."
          required />

        <label for="email">Email:</label>
        <input type="email" name="email" id="email" oninput="validateEmail(this)" placeholder="Enter Your Email"
          required/>

        <label for="mobile">Mobile Number:</label>
        <input type="tel" name="mobile" id="mobile" maxlength="10" oninput="validateMobile(this)" placeholder="Enter 10-digit Mobile Number" required />
        <span id="mobile-error" style="color: red; display: none">Please enter a valid 10-digit mobile number.</span>

        <label for="password">Password:</label>
        <div style="position: relative">
          <input type="text" name="password" id="password" placeholder="Enter Password" required/>
        </div>

        <label for="confirmPassword">Confirm Password:</label>
        <div style="position: relative">
          <input type="password" name="confirmPassword" id="confirm_password" placeholder="Re-enter the Password"
            required/>
          <span
            onclick="togglePassword('confirm_password', 'eyeIcon2')"
            style="
              position: absolute;
              right: 10px;
              top: 50%;
              transform: translateY(-50%);
              cursor: pointer;
            "
          >
            👁️
          </span>
        </div>

        <input type="submit" value="Register" />
      </form>
      <p>Already registered? <a href="login.jsp">Login here</a></p>
    </div>
    <script>
      function validateMobile(input) {
        input.value = input.value.replace(/[^0-9]/g, "");
        if (input.value.length > 10) {
          input.value = input.value.slice(0, 10);
        }

        const errorMessage = document.getElementById("mobile-error");
        if (input.value.length !== 10) {
          errorMessage.style.display = "inline";
        } else {
          errorMessage.style.display = "none";
        }
      }

      function validateName(input) {
        input.value = input.value.replace(/[^a-zA-Z\s]/g, "");
      }
      function validateEmail(input) {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (!emailRegex.test(input.value)) {
          input.setCustomValidity("Please enter a valid email address.");
        } else {
          input.setCustomValidity("");
        }
      }
    </script>
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
            <p>Passwords do not match. </p>
            <button onclick="closePopup()">OK</button>
        </div>
    </div>
  </body>
</html>
