package com.ovr.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {
    // Fetching credentials from Environment Variables for security
    private static final String FROM_EMAIL = System.getenv("EMAIL_USER");
    private static final String APP_PASSWORD = System.getenv("EMAIL_PASS");

    public static void sendOTP(String toEmail, String otp) {
        if (FROM_EMAIL == null || APP_PASSWORD == null) {
            System.err.println("Error: Environment variables EMAIL_USER or EMAIL_PASS not set!");
            return;
        }

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("OVR System - Password Reset OTP");
            
            message.setText("Dear User,\n\n" +
                            "Your OTP Code is: " + otp + "\n" +
                            "This code is valid for 5 minutes only.\n\n" +
                            "If you did not request this, please ignore this email.\n\n" +
                            "Ocean View Resort System");

            Transport.send(message);
            System.out.println("OTP Email sent successfully to: " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}