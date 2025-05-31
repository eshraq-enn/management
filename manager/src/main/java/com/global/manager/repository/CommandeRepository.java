package com.global.manager.repository;

import com.global.manager.entity.Commande;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface CommandeRepository extends JpaRepository<Commande, Long> {
    Page<Commande> findByNumeroCommandeContainingIgnoreCaseOrDescriptionContainingIgnoreCase(
        String numeroCommande, String description, Pageable pageable);
    Page<Commande> findByFournisseurId(Long fournisseurId, Pageable pageable);
} 