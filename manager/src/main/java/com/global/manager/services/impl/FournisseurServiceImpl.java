package com.global.manager.services.impl;

import com.global.manager.entity.Fournisseur;
import com.global.manager.repository.FournisseurRepository;
import com.global.manager.services.FournisseurService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class FournisseurServiceImpl implements FournisseurService {

    private final FournisseurRepository repository;

    public FournisseurServiceImpl(FournisseurRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<Fournisseur> getAllFournisseurs() {
        return repository.findAll();
    }

    @Override
    public Fournisseur getFournisseurById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Fournisseur non trouvé avec l'id : " + id));
    }

    @Override
    public Fournisseur saveFournisseur(Fournisseur fournisseur) {
        if (fournisseur.getId() == null) {
            // Nouveau fournisseur
            if (fournisseur.getEmail() != null && repository.existsByEmail(fournisseur.getEmail())) {
                throw new RuntimeException("Un fournisseur avec cet email existe déjà");
            }
        } else {
            // Modification d'un fournisseur existant
            Fournisseur existingFournisseur = repository.findById(fournisseur.getId())
                    .orElseThrow(() -> new RuntimeException("Fournisseur non trouvé"));
            if (!existingFournisseur.getEmail().equals(fournisseur.getEmail()) 
                && repository.existsByEmail(fournisseur.getEmail())) {
                throw new RuntimeException("Un fournisseur avec cet email existe déjà");
            }
        }
        return repository.save(fournisseur);
    }

    @Override
    public void deleteFournisseur(Long id) {
        if (!repository.existsById(id)) {
            throw new RuntimeException("Fournisseur non trouvé avec l'id : " + id);
        }
        repository.deleteById(id);
    }
    @Override
    public List<Fournisseur> searchFournisseurs(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllFournisseurs();
        }
        return repository.findByNomContainingIgnoreCase(keyword);
    }

    @Override
    public long countAllFournisseurs() {
        return repository.count();
    }

}

