<%@ page import="java.sql.*, java.util.*, javax.crypto.Cipher, javax.crypto.spec.SecretKeySpec, java.util.Base64" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%!
    private static final String SECRET_KEY = "1234567890123456";  // AES Secret Key

    public String encrypt(String strToEncrypt) throws Exception {
        SecretKeySpec secretKey = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encryptedBytes = cipher.doFinal(strToEncrypt.getBytes("UTF-8"));
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }
%>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String mobile = request.getParameter("mobile");
    String encryptedPassword = "";
    String message = "";

    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        encryptedPassword = encrypt(password);

        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "oracle");

        // Step 1: Check if email exists
        String checkEmailQuery = "SELECT USER_ID FROM USER_EMAIL WHERE EMAIL = ?";
        stmt = con.prepareStatement(checkEmailQuery);
        stmt.setString(1, email);
        rs = stmt.executeQuery();

        boolean emailExists = false;
        int emailUserId = -1;

        if (rs.next()) {
            emailExists = true;
            emailUserId = rs.getInt("USER_ID");
        }
        rs.close();
        stmt.close();

        // Step 2: Check if mobile number exists
        String checkMobileQuery = "SELECT USER_ID FROM USER_MOBILE WHERE MOBILE_NUMBER = ?";
        stmt = con.prepareStatement(checkMobileQuery);
        stmt.setString(1, mobile);
        rs = stmt.executeQuery();

        boolean mobileExists = false;
        int mobileUserId = -1;

        if (rs.next()) {
            mobileExists = true;
            mobileUserId = rs.getInt("USER_ID");
        }
        rs.close();
        stmt.close();

        // Step 3: Handle 4 possible combinations
        if (emailExists && mobileExists) {
            if (emailUserId == mobileUserId) {
%>
<html>
    <head>
        <title>User already registered with this email and mobile number.</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f0f0f0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .popup {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                text-align: center;
                width: 450px;
            }
            .popup h2 {
                color: #2c3e50;
                margin-bottom: 15px;
            }
            .popup p {
                font-size: 16px;
                color: #555;
                margin-bottom: 25px;
            }
            .popup button {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px 25px;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .popup button:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <div class="popup">
            <h2>Already Registered With this E-Mail and Mobile Number🎉</h2>
            <p>Looks like you're already registered with us.</p>
            <form action="login.jsp" method="get">
                <button type="submit">Login Now</button>
            </form>
        </div>
    </body>
</html>
<%
            } else {
                message = "Error: Email and Mobile belong to different users!";
            }

        } else if (emailExists) {
            // Case: Email exists, mobile is new – insert new mobile for existing user
            stmt = con.prepareStatement("INSERT INTO USER_MOBILE (USER_ID, MOBILE_NUMBER) VALUES (?, ?)");
            stmt.setInt(1, emailUserId);
            stmt.setString(2, mobile);
            stmt.executeUpdate();
            stmt.close();
%>
    <html>
        <head>
            <title>Already Registeredwith this E-Mail</title>
            <style>
                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background-color: #f0f0f0;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                }
                .popup {
                    background-color: #ffffff;
                    padding: 30px;
                    border-radius: 12px;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                    text-align: center;
                    width: 450px;
                }
                .popup h2 {
                    color: #2c3e50;
                    margin-bottom: 15px;
                }
                .popup p {
                    font-size: 16px;
                    color: #555;
                    margin-bottom: 25px;
                }
                .popup button {
                    background-color: #28a745;
                    color: white;
                    border: none;
                    padding: 10px 25px;
                    font-size: 16px;
                    border-radius: 5px;
                    cursor: pointer;
                    transition: background-color 0.3s;
                }
                .popup button:hover {
                    background-color: #218838;
                }
            </style>
        </head>
        <body>
            <div class="popup">
                <h2>Already Registered 🎉</h2>
                <p>Looks like you're already registered with this E-Mail.</p>
                <form action="login.jsp" method="get">
                    <button type="submit">Login Now</button>
                </form>
            </div>
        </body>
    </html>
<%
        } else if (mobileExists) {
            // Case: Mobile exists, email is new – insert new email for existing user
            stmt = con.prepareStatement("INSERT INTO USER_EMAIL (ID, USER_ID, EMAIL) VALUES (USER_EMAIL_SEQ.NEXTVAL, ?, ?)");
            stmt.setInt(1, mobileUserId);
            stmt.setString(2, email);
            stmt.executeUpdate();
            stmt.close();
%>
    <html>
        <head>
            <title>Already Registeredwith this Mobile Number</title>
            <style>
                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background-color: #f0f0f0;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                }
                .popup {
                    background-color: #ffffff;
                    padding: 30px;
                    border-radius: 12px;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                    text-align: center;
                    width: 450px;
                }
                .popup h2 {
                    color: #2c3e50;
                    margin-bottom: 15px;
                }
                .popup p {
                    font-size: 16px;
                    color: #555;
                    margin-bottom: 25px;
                }
                .popup button {
                    background-color: #28a745;
                    color: white;
                    border: none;
                    padding: 10px 25px;
                    font-size: 16px;
                    border-radius: 5px;
                    cursor: pointer;
                    transition: background-color 0.3s;
                }
                .popup button:hover {
                    background-color: #218838;
                }
            </style>
        </head>
        <body>
            <div class="popup">
                <h2>Already Registered 🎉</h2>
                <p>Looks like you're already registered with this Mobile Number.</p>
                <form action="login.jsp" method="get">
                    <button type="submit">Login Now</button>
                </form>
            </div>
        </body>
    </html>
<%
        } else {
            // Case: Both are new – insert into USERS, USER_EMAIL, USER_MOBILE
            stmt = con.prepareStatement("INSERT INTO USERS (ID, NAME, PASSWORD) VALUES (USERS_SEQ.NEXTVAL, ?, ?)", new String[]{"ID"});
            stmt.setString(1, name);
            stmt.setString(2, encryptedPassword);
            stmt.executeUpdate();

            ResultSet generatedKeys = stmt.getGeneratedKeys();
            int userId = 0;
            if (generatedKeys.next()) {
                userId = generatedKeys.getInt(1);
            } else {
                throw new SQLException("User ID not generated.");
            }
            stmt.close();

            stmt = con.prepareStatement("INSERT INTO USER_EMAIL (ID, USER_ID, EMAIL) VALUES (USER_EMAIL_SEQ.NEXTVAL, ?, ?)");
            stmt.setInt(1, userId);
            stmt.setString(2, email);
            stmt.executeUpdate();
            stmt.close();

            stmt = con.prepareStatement("INSERT INTO USER_MOBILE (USER_ID, MOBILE_NUMBER) VALUES (?, ?)");
            stmt.setInt(1, userId);
            stmt.setString(2, mobile);
            stmt.executeUpdate();
            stmt.close();
%>
    <html>
        <head>
            <title>Registration Successful!</title>
            <style>
                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background-color: #f0f0f0;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                }
                .popup {
                    background-color: #ffffff;
                    padding: 30px;
                    border-radius: 12px;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                    text-align: center;
                    width: 450px;
                }
                .popup h2 {
                    color: #2c3e50;
                    margin-bottom: 15px;
                }
                .popup p {
                    font-size: 16px;
                    color: #555;
                    margin-bottom: 25px;
                }
                .popup button {
                    background-color: #28a745;
                    color: white;
                    border: none;
                    padding: 10px 25px;
                    font-size: 16px;
                    border-radius: 5px;
                    cursor: pointer;
                    transition: background-color 0.3s;
                }
                .popup button:hover {
                    background-color: #218838;
                }
            </style>
        </head>
        <body>
            <div class="popup">
                <h2>Registration Successful! 🎉</h2>
                <p>You have registered sucessfully. You can Login Now!</p>
                <form action="login.jsp" method="get">
                    <button type="submit">Login Now</button>
                </form>
            </div>
        </body>
    </html>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
        message = "Error: " + e.getMessage();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>