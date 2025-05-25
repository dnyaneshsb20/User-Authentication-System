<%@ page import="javax.crypto.Cipher, javax.crypto.spec.SecretKeySpec, java.util.Base64" %>
<%! 
    private static final String SECRET_KEY = "1234567890123456"; // Must be 16 chars for AES

    // Encrypt the plain text password
    public static String encrypt(String strToEncrypt) throws Exception {
        SecretKeySpec secretKey = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encryptedBytes = cipher.doFinal(strToEncrypt.getBytes("UTF-8"));
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    // Decrypt the encrypted password
    public static String decrypt(String strToDecrypt) throws Exception {
        SecretKeySpec secretKey = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(strToDecrypt));
        return new String(decryptedBytes);
    }
%>
