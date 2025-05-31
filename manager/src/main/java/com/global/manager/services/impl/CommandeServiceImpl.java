package com.global.manager.services.impl;

import com.global.manager.entity.Commande;
import com.global.manager.repository.CommandeRepository;
import com.global.manager.services.CommandeService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

import java.util.List;

@Service
@Transactional
public class CommandeServiceImpl implements CommandeService {
    private final CommandeRepository commandeRepository;

    public CommandeServiceImpl(CommandeRepository commandeRepository) {
        this.commandeRepository = commandeRepository;
    }

    @Override
    public Page<Commande> getAllCommandes(Pageable pageable) {
        return commandeRepository.findAll(pageable);
    }

    @Override
    public Commande getCommandeById(Long id) {
        return commandeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Commande non trouvée avec l'ID : " + id));
    }

    @Override
    public Commande saveCommande(Commande commande) {
        return commandeRepository.save(commande);
    }

    @Override
    public void deleteCommande(Long id) {
        commandeRepository.deleteById(id);
    }

    @Override
    public Page<Commande> searchCommandes(String keyword, Pageable pageable) {
        return commandeRepository.findByNumeroCommandeContainingIgnoreCaseOrDescriptionContainingIgnoreCase(
            keyword, keyword, pageable);
    }

    @Override
    public long countAllCommandes() {
        return commandeRepository.count();
    }

    @Override
    public List<Commande> getDernieresCommandes(int limit) {
        return commandeRepository.findAll(
                PageRequest.of(0, limit, Sort.by(Sort.Direction.DESC, "dateCommande"))
        ).getContent();
    }

    @Override
    public Page<Commande> getCommandesByFournisseur(Long fournisseurId, Pageable pageable) {
        return commandeRepository.findByFournisseurId(fournisseurId, pageable);
    }

    @Override
    public Commande save(Commande commande) {
        return saveCommande(commande);
    }
}