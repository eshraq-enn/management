package com.global.manager.services;

import com.global.manager.entity.Commande;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface CommandeService {
    Page<Commande> getAllCommandes(Pageable pageable);
    Commande getCommandeById(Long id);
    Commande saveCommande(Commande commande);
    void deleteCommande(Long id);
    Page<Commande> searchCommandes(String keyword, Pageable pageable);
    long countAllCommandes();
    List<Commande> getDernieresCommandes(int limit);
    Page<Commande> getCommandesByFournisseur(Long fournisseurId, Pageable pageable);
    Commande save(@Valid Commande commande);
} 