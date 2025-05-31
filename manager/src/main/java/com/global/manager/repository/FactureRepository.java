package com.global.manager.repository;

import com.global.manager.entity.Facture;
import com.global.manager.enums.StatutFacture;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface FactureRepository extends JpaRepository<Facture, Long> {
    List<Facture> findByNumeroFactureContainingIgnoreCaseOrDescriptionContainingIgnoreCase(String numeroFacture, String description);
    List<Facture> findByFournisseurId(Long fournisseurId);
    Optional<Facture> findByNumeroFacture(String numeroFacture);
    List<Facture> findByDateEcheanceBeforeAndStatutNot(LocalDate date, StatutFacture statut);
    List<Facture> findByStatutNot(StatutFacture statut);
    
    @Query("SELECT f FROM Facture f WHERE f.dateEcheance < CURRENT_DATE AND f.statut != 'PAYEE'")
    List<Facture> findFacturesEnRetard();
    
    @Query("SELECT SUM(f.montantTotal) FROM Facture f WHERE f.statut = 'PAYEE' AND f.dateFacture >= ?1 AND f.dateFacture <= ?2")
    BigDecimal getMontantTotalPaye(LocalDate dateDebut, LocalDate dateFin);
    
    @Query("SELECT COUNT(f) FROM Facture f WHERE f.statut = ?1")
    long countByStatut(StatutFacture statut);

    List<Facture> findByNumeroFactureContainingIgnoreCase(String numeroFacture);
} 