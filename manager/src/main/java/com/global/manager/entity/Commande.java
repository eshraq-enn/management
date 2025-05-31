package com.global.manager.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.math.BigDecimal;
import java.time.LocalDate;
import com.global.manager.enums.StatutCommande;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "commandes")
public class Commande {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String numeroCommande;

    @NotNull(message = "Veuillez sélectionner un fournisseur")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "fournisseur_id")
    private Fournisseur fournisseur;

    @NotNull(message = "Veuillez saisir une date de commande")
    @Column(name = "date_commande")
    private LocalDate dateCommande;

    @Column(name = "date_livraison")
    private LocalDate dateLivraison;

    @NotNull(message = "Veuillez saisir un montant")
    @Positive(message = "Le montant doit être positif")
    @Column(name = "montant_total", precision = 10, scale = 2)
    private BigDecimal montantTotal;

    @Enumerated(EnumType.STRING)
    @NotNull(message = "Veuillez sélectionner un statut")
    @Column(nullable = false)
    private StatutCommande statut;

    @Column(length = 500)
    private String description;

    @CreationTimestamp
    @Column(name = "date_creation", updatable = false)
    private LocalDate dateCreation;

    @UpdateTimestamp
    @Column(name = "date_modification")
    private LocalDate dateModification;

    @PrePersist
    public void prePersist() {
        if (this.numeroCommande == null || this.numeroCommande.isEmpty()) {
            this.numeroCommande = generateNumeroCommande();
        }
        if (this.statut == null) {
            this.statut = StatutCommande.EN_ATTENTE;
        }
        if (this.dateCommande == null) {
            this.dateCommande = LocalDate.now();
        }
    }

    private String generateNumeroCommande() {
        return "CMD" + System.currentTimeMillis();
    }
}