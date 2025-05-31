package com.global.manager.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;
import java.time.LocalDate;
import com.global.manager.enums.StatutFacture;

@Entity
@Table(name = "factures")
public class Facture {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Le numéro de facture est obligatoire")
    @Size(min = 3, max = 50, message = "Le numéro de facture doit contenir entre 3 et 50 caractères")
    @Column(unique = true)
    private String numeroFacture;

    @NotNull(message = "Le fournisseur est obligatoire")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "fournisseur_id", nullable = false)
    private Fournisseur fournisseur;

    @NotNull(message = "La date de facture est obligatoire")
    @Column(name = "date_facture", nullable = false)
    private LocalDate dateFacture;

    @NotNull(message = "La date d'échéance est obligatoire")
    @Column(name = "date_echeance", nullable = false)
    private LocalDate dateEcheance;

    @NotNull(message = "Le montant total est obligatoire")
    @Positive(message = "Le montant total doit être positif")
    @Column(name = "montant_total", nullable = false, precision = 10, scale = 2)
    private BigDecimal montantTotal;

    @NotNull(message = "Le statut est obligatoire")
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutFacture statut;

    @Column(length = 500)
    private String description;

    @Column(name = "nom_fichier")
    private String nomFichier;

    @Column(name = "date_creation")
    private LocalDate dateCreation;

    @Column(name = "date_modification")
    private LocalDate dateModification;

    @Column(name = "montant_tva", precision = 10, scale = 2)
    private BigDecimal montantTVA;

    @Column(name = "montant_ht", precision = 10, scale = 2)
    private BigDecimal montantHT;

    @Column(name = "taux_tva")
    private BigDecimal tauxTVA;

    @PrePersist
    protected void onCreate() {
        dateCreation = LocalDate.now();
        dateModification = LocalDate.now();
    }

    @PreUpdate
    protected void onUpdate() {
        dateModification = LocalDate.now();
    }

    // Constructeurs
    public Facture() {}

    public Facture(String numeroFacture, Fournisseur fournisseur, LocalDate dateFacture, 
                  LocalDate dateEcheance, BigDecimal montantTotal, StatutFacture statut, 
                  String description, String nomFichier) {
        this.numeroFacture = numeroFacture;
        this.fournisseur = fournisseur;
        this.dateFacture = dateFacture;
        this.dateEcheance = dateEcheance;
        this.montantTotal = montantTotal;
        this.statut = statut;
        this.description = description;
        this.nomFichier = nomFichier;
        this.dateCreation = LocalDate.now();
        this.dateModification = LocalDate.now();
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumeroFacture() {
        return numeroFacture;
    }

    public void setNumeroFacture(String numeroFacture) {
        this.numeroFacture = numeroFacture;
    }

    public Fournisseur getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(Fournisseur fournisseur) {
        this.fournisseur = fournisseur;
    }

    public LocalDate getDateFacture() {
        return dateFacture;
    }

    public void setDateFacture(LocalDate dateFacture) {
        this.dateFacture = dateFacture;
    }

    public LocalDate getDateEcheance() {
        return dateEcheance;
    }

    public void setDateEcheance(LocalDate dateEcheance) {
        this.dateEcheance = dateEcheance;
    }

    public BigDecimal getMontantTotal() {
        return montantTotal;
    }

    public void setMontantTotal(BigDecimal montantTotal) {
        this.montantTotal = montantTotal;
    }

    public StatutFacture getStatut() {
        return statut;
    }

    public void setStatut(StatutFacture statut) {
        this.statut = statut;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getNomFichier() {
        return nomFichier;
    }

    public void setNomFichier(String nomFichier) {
        this.nomFichier = nomFichier;
    }

    public LocalDate getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(LocalDate dateCreation) {
        this.dateCreation = dateCreation;
    }

    public LocalDate getDateModification() {
        return dateModification;
    }

    public void setDateModification(LocalDate dateModification) {
        this.dateModification = dateModification;
    }

    public BigDecimal getMontantTVA() {
        return montantTVA;
    }

    public void setMontantTVA(BigDecimal montantTVA) {
        this.montantTVA = montantTVA;
    }

    public BigDecimal getMontantHT() {
        return montantHT;
    }

    public void setMontantHT(BigDecimal montantHT) {
        this.montantHT = montantHT;
    }

    public BigDecimal getTauxTVA() {
        return tauxTVA;
    }

    public void setTauxTVA(BigDecimal tauxTVA) {
        this.tauxTVA = tauxTVA;
    }
} 