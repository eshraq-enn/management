package com.global.manager.enums;

public enum TypeFournisseur {
    LOCAL("Fournisseur local", "FR"),
    INTERNATIONAL("Fournisseur international", "INT"),
    PARTENAIRE("Fournisseur partenaire", "PART");

    private final String description;
    private final String code;

    TypeFournisseur(String description, String code) {
        this.description = description;
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public String getCode() {
        return code;
    }

    public static TypeFournisseur fromCode(String code) {
        for (TypeFournisseur type : values()) {
            if (type.getCode().equals(code)) {
                return type;
            }
        }
        throw new IllegalArgumentException("Code de type fournisseur invalide: " + code);
    }
}
