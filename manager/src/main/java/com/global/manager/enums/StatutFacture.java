package com.global.manager.enums;

public enum StatutFacture {
    EN_ATTENTE("En attente"),
    PAYEE("Payée"),
    EN_RETARD("En retard"),
    ANNULEE("Annulée");

    private final String description;

    StatutFacture(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
} 