package com.global.manager.entity;

import com.global.manager.enums.TypeFournisseur;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.NotNull;

@Entity
public class Fournisseur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Veuillez saisir un nom")
    private String nom;

    @Email(message = "Veuillez saisir une adresse email valide")
    @NotBlank(message = "Veuillez saisir une adresse email")
    private String email;

    @Pattern(regexp = "^\\+?[0-9]{10,15}$", message = "Le numéro de téléphone doit contenir entre 10 et 15 chiffres")
    @NotBlank(message = "Veuillez saisir un numéro de téléphone")
    private String telephone;

    @NotNull(message = "Veuillez sélectionner un type de fournisseur")
    @Enumerated(EnumType.STRING)
    private TypeFournisseur type;

    private String adresse;

    // Constructeurs
    public Fournisseur() {}

    public Fournisseur(Long id, String nom, String email, String telephone, TypeFournisseur type, String adresse) {
        this.id = id;
        this.nom = nom;
        this.email = email;
        this.telephone = telephone;
        this.type = type;
        this.adresse = adresse;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public TypeFournisseur getType() {
        return type;
    }

    public void setType(TypeFournisseur type) {
        this.type = type;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }
}
