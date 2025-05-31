package com.global.manager.services.impl;


import com.global.manager.entity.SupplierOrder;
import com.global.manager.repository.SupplierOrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

@Service
public class SupplierOrderService {

    @Autowired
    private SupplierOrderRepository supplierOrderRepository;

    @Autowired
    private JavaMailSender javaMailSender;

    public SupplierOrder saveOrder(SupplierOrder order) {
        SupplierOrder savedOrder = supplierOrderRepository.save(order);
        sendOrderEmail(savedOrder);
        return savedOrder;
    }

    private void sendOrderEmail(SupplierOrder order) {
        SimpleMailMessage message = new SimpleMailMessage();

        // Expéditeur réel autorisé par Gmail
        message.setFrom("fatialar1@gmail.com");

        // Le fournisseur reçoit l’e-mail
        message.setTo(order.getSupplierEmail());

        // Sujet
        message.setSubject("Nouvelle commande N° " + order.getOrderNumber());

        // Corps du message (on inclut l’expéditeur réel ici)
        String contenu = "Expéditeur : " + order.getSenderEmail() + "\n\nMessage :\n" + order.getMessage();
        message.setText(contenu);

        // Envoi
        javaMailSender.send(message);
    }


}
