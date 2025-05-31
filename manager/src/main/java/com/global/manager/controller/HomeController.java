package com.global.manager.controller;

import com.global.manager.services.FactureService;
import com.global.manager.services.FournisseurService;
import com.global.manager.services.CommandeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.time.format.DateTimeFormatter;
import java.math.BigDecimal;

@Controller
public class HomeController {

    private final FactureService factureService;
    private final FournisseurService fournisseurService;
    private final CommandeService commandeService;
    private final DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    public HomeController(FactureService factureService,
            FournisseurService fournisseurService,
            CommandeService commandeService) {
        this.factureService = factureService;
        this.fournisseurService = fournisseurService;
        this.commandeService = commandeService;
    }

    @GetMapping({ "/", "/home" })
    public String home(Model model) {
        // Statistiques générales
        model.addAttribute("totalFactures", factureService.countAllFactures());
        model.addAttribute("totalFournisseurs", fournisseurService.countAllFournisseurs());
        model.addAttribute("totalCommandes", commandeService.countAllCommandes());

        // Montant total des factures en attente
        BigDecimal montantTotal = factureService.getMontantTotalFacturesEnAttente();
        model.addAttribute("montantTotal", montantTotal != null ? montantTotal : BigDecimal.ZERO);

        // Factures en retard
        model.addAttribute("facturesEnRetard", factureService.getFacturesEnRetard());

        // Dernières commandes
        model.addAttribute("dernieresCommandes", commandeService.getDernieresCommandes(5));

        // Ajouter le formateur de date
        model.addAttribute("dateFormatter", dateFormatter);

        return "index-wrapper";
    }
}