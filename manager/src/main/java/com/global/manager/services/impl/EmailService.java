package com.global.manager.services.impl;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.io.IOException;
import java.nio.file.Files;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    private String loadTemplate(String templateName) throws IOException {
        ClassPathResource resource = new ClassPathResource("templates/email/" + templateName + ".html");
        return Files.readString(resource.getFile().toPath(), StandardCharsets.UTF_8);
    }

    public void sendPasswordResetEmail(String to, String token, String username) throws MessagingException, IOException {
        String resetUrl = "http://localhost:5050/auth/reset-password?token=" + token;

        String emailContent = loadTemplate("password-reset-email");
        emailContent = emailContent
                .replace("${username}", username)
                .replace("${token}", token)
                .replace("${resetUrl}", resetUrl);

        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        helper.setFrom("noreply@globalmanager.com");
        helper.setTo(to);
        helper.setSubject("Réinitialisation de votre mot de passe");
        helper.setText(emailContent, true);

        mailSender.send(message);
    }

    public void sendWelcomeEmail(String to, String username) throws MessagingException, IOException {
        String emailContent = loadTemplate("welcome-email");
        emailContent = emailContent.replace("${username}", username);

        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        helper.setFrom("noreply@globalmanager.com");
        helper.setTo(to);
        helper.setSubject("Bienvenue sur Global Manager");
        helper.setText(emailContent, true);

        mailSender.send(message);
    }
}
