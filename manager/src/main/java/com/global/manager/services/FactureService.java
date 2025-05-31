package com.global.manager.services;

import com.global.manager.entity.Facture;
import java.math.BigDecimal;
import java.util.List;

public interface FactureService {
    List<Facture> getAllFactures();
    Facture getFactureById(Long id);
    Facture saveFacture(Facture facture);
    void deleteFacture(Long id);
    List<Facture> searchFactures(String keyword);
    List<Facture> getFacturesByFournisseur(Long fournisseurId);
    List<Facture> getFacturesEnRetard();
    void marquerCommePayee(Long id);
    long countAllFactures();
    BigDecimal getMontantTotalFacturesEnAttente();
} 