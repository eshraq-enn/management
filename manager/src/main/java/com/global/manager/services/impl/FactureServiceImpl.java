package com.global.manager.services.impl;

import com.global.manager.entity.Facture;
import com.global.manager.repository.FactureRepository;
import com.global.manager.services.FactureService;
import com.global.manager.enums.StatutFacture;
import com.global.manager.exception.FactureException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class FactureServiceImpl implements FactureService {

    private final FactureRepository factureRepository;

    public FactureServiceImpl(FactureRepository factureRepository) {
        this.factureRepository = factureRepository;
    }

    @Override
    public List<Facture> getAllFactures() {
        return factureRepository.findAll();
    }

    @Override
    public Facture getFactureById(Long id) {
        return factureRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Facture non trouvée avec l'id: " + id));
    }

    @Override
    public Facture saveFacture(Facture facture) {
        validateFacture(facture);
        calculerMontants(facture);
        return factureRepository.save(facture);
    }

    @Override
    public void deleteFacture(Long id) {
        Facture facture = getFactureById(id);
        if (facture.getStatut() == StatutFacture.PAYEE) {
            throw new RuntimeException("Impossible de supprimer une facture déjà payée");
        }
        factureRepository.deleteById(id);
    }

    @Override
    public List<Facture> searchFactures(String keyword) {
        return factureRepository.findByNumeroFactureContainingIgnoreCaseOrDescriptionContainingIgnoreCase(keyword, keyword);
    }

    @Override
    public List<Facture> getFacturesByFournisseur(Long fournisseurId) {
        return factureRepository.findByFournisseurId(fournisseurId);
    }

    @Override
    public List<Facture> getFacturesEnRetard() {
        return factureRepository.findFacturesEnRetard();
    }

    @Override
    public void marquerCommePayee(Long id) {
        Facture facture = getFactureById(id);
        facture.setStatut(StatutFacture.PAYEE);
        factureRepository.save(facture);
    }

    @Override
    public BigDecimal getMontantTotalFacturesEnAttente() {
        List<Facture> facturesEnAttente = factureRepository.findByStatutNot(StatutFacture.PAYEE);
        return facturesEnAttente.stream()
                .map(Facture::getMontantTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @Override
    public long countAllFactures() {
        return factureRepository.count();
    }

    private void validateFacture(Facture facture) {
        // Vérifier le numéro de facture unique
        Optional<Facture> existingFacture = factureRepository.findByNumeroFacture(facture.getNumeroFacture());
        if (existingFacture.isPresent() && !existingFacture.get().getId().equals(facture.getId())) {
            throw new FactureException("Le numéro de facture existe déjà");
        }

        // Vérifier les dates
        if (facture.getDateEcheance().isBefore(facture.getDateFacture())) {
            throw new FactureException("La date d'échéance ne peut pas être antérieure à la date de facture");
        }

        // Vérifier le montant
        if (facture.getMontantTotal() == null) {
            facture.setMontantTotal(BigDecimal.ZERO);
        } else if (facture.getMontantTotal().compareTo(BigDecimal.ZERO) < 0) {
            throw new FactureException("Le montant total ne peut pas être négatif");
        }

        // Vérifier le taux de TVA
        if (facture.getTauxTVA() == null) {
            facture.setTauxTVA(new BigDecimal("20")); // Taux par défaut 20%
        } else if (facture.getTauxTVA().compareTo(BigDecimal.ZERO) < 0) {
            throw new FactureException("Le taux de TVA ne peut pas être négatif");
        }
    }

    private void calculerMontants(Facture facture) {
        // S'assurer que les montants ne sont pas null
        if (facture.getMontantTotal() == null) {
            facture.setMontantTotal(BigDecimal.ZERO);
        }
        if (facture.getTauxTVA() == null) {
            facture.setTauxTVA(new BigDecimal("20"));
        }

        // Calculer le montant HT
        BigDecimal tauxTVA = facture.getTauxTVA().divide(new BigDecimal("100"));
        BigDecimal montantHT = facture.getMontantTotal().divide(BigDecimal.ONE.add(tauxTVA), 2, RoundingMode.HALF_UP);
        facture.setMontantHT(montantHT);

        // Calculer le montant TVA
        BigDecimal montantTVA = facture.getMontantTotal().subtract(montantHT);
        facture.setMontantTVA(montantTVA);
    }
} 