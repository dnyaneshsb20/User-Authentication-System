<%@ page contentType="image/png" %>
<%@ page import="java.awt.*, java.awt.image.BufferedImage, javax.imageio.ImageIO, java.io.OutputStream, java.util.Random" %>

<%
    // CAPTCHA settings
    int width = 150;
    int height = 50;
    int fontSize = 24;

    // Generate random CAPTCHA text
    String captchaChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    Random random = new Random();
    StringBuilder captchaText = new StringBuilder();
    for (int i = 0; i < 6; i++) { // Length of CAPTCHA
        captchaText.append(captchaChars.charAt(random.nextInt(captchaChars.length())));
    }

    String captcha = captchaText.toString();
    
    // Store CAPTCHA in session
    session.setAttribute("captcha", captcha);

    // Create CAPTCHA image
    BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
    Graphics2D g = image.createGraphics();

    // Background color
    g.setColor(Color.WHITE);
    g.fillRect(0, 0, width, height);

    // Draw CAPTCHA text
    g.setFont(new Font("Arial", Font.BOLD, fontSize));
    g.setColor(Color.BLACK);
    g.drawString(captcha, 20, 35);

    // Set response type and send image
    response.setContentType("image/png");
    OutputStream os = response.getOutputStream();
    ImageIO.write(image, "png", os);
    os.close();
%>
