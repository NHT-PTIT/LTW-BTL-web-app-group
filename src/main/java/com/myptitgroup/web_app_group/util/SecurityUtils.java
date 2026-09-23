package com.myptitgroup.web_app_group.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Tiện ích bảo mật: Mã hóa và kiểm tra mật khẩu bằng thuật toán SHA-256 an toàn.
 */
public class SecurityUtils {

    /**
     * Băm mật khẩu thô bằng thuật toán SHA-256
     * @param rawPassword Mật khẩu người dùng nhập
     * @return Chuỗi Hex đại diện cho mã băm (64 ký tự)
     */
    public static String hashPassword(String rawPassword) {
        if (rawPassword == null) {
            return null;
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedhash = digest.digest(rawPassword.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : encodedhash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Lỗi thuật toán mã hóa SHA-256", e);
        }
    }

    /**
     * Xác thực mật khẩu nhập vào với mã băm trong cơ sở dữ liệu
     * @param rawPassword Mật khẩu người dùng nhập
     * @param hashedPassword Mật khẩu đã băm trong CSDL
     * @return true nếu khớp, false nếu sai
     */
    public static boolean verifyPassword(String rawPassword, String hashedPassword) {
        if (rawPassword == null || hashedPassword == null) {
            return false;
        }
        String hashedInput = hashPassword(rawPassword);
        return hashedInput.equalsIgnoreCase(hashedPassword);
    }
}
