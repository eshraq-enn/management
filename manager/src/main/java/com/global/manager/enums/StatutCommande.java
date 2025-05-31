package com.global.manager.enums;

public enum StatutCommande {
    EN_ATTENTE("En attente", "ATT"),
    CONFIRMEE("Confirmée", "CONF"),
    EN_COURS("En cours de traitement", "EN_COURS"),
    LIVREE("Livrée", "LIV"),
    ANNULEE("Annulée", "ANN");

    private final String description;
    private final String code;

    StatutCommande(String description, String code) {
        this.description = description;
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public String getCode() {
        return code;
    }

    public static StatutCommande fromCode(String code) {
        for (StatutCommande statut : values()) {
            if (statut.getCode().equals(code)) {
                return statut;
            }
        }
        throw new IllegalArgumentException("Code de statut invalide: " + code);
    }
} 