package com.global.manager.services;

import com.global.manager.entity.Fournisseur;

import java.util.List;

public interface FournisseurService {
    List<Fournisseur> getAllFournisseurs();
    Fournisseur getFournisseurById(Long id);
    Fournisseur saveFournisseur(Fournisseur fournisseur);
    void deleteFournisseur(Long id);
    List<Fournisseur> searchFournisseurs(String keyword);
    long countAllFournisseurs();
}

