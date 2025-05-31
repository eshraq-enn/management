package com.global.manager.entity;


import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Data
@Table(name = "supplier_orders")
public class SupplierOrder {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "order_number", nullable = false)
    private String orderNumber;

    @Column(name = "order_date", nullable = false)
    private LocalDate orderDate;

    @Column(name = "supplier_email", nullable = false)
    private String supplierEmail;

    @Column(name = "sender_email", nullable = false)
    private String senderEmail;

    @Column(name = "message", columnDefinition = "TEXT")
    private String message;
}