package com.global.manager.controller;

import com.global.manager.entity.Commande;
import com.global.manager.services.CommandeService;
import com.global.manager.services.FournisseurService;
import com.global.manager.enums.StatutCommande;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

@Controller
@RequestMapping("/commandes")
public class CommandeController {

    private static final Logger logger = LoggerFactory.getLogger(CommandeController.class);
    private final CommandeService commandeService;
    private final FournisseurService fournisseurService;
    private final DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    public CommandeController(CommandeService commandeService, FournisseurService fournisseurService) {
        this.commandeService = commandeService;
        this.fournisseurService = fournisseurService;
    }

    @GetMapping
    public String lister(Model model, 
                        @RequestParam(defaultValue = "0") int page,
                        @RequestParam(defaultValue = "10") int size,
                        @RequestParam(defaultValue = "dateCommande") String sort,
                        @RequestParam(defaultValue = "desc") String direction) {
        
        Sort.Direction sortDirection = Sort.Direction.fromString(direction);
        Page<Commande> commandesPage = commandeService.getAllCommandes(
            PageRequest.of(page, size, Sort.by(sortDirection, sort))
        );
        
        model.addAttribute("commandes", commandesPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", commandesPage.getTotalPages());
        model.addAttribute("totalItems", commandesPage.getTotalElements());
        model.addAttribute("dateFormatter", dateFormatter);
        model.addAttribute("sort", sort);
        model.addAttribute("direction", direction);
        
        return "commandes/liste-wrapper";
    }

    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        model.addAttribute("commande", new Commande());
        model.addAttribute("fournisseurs", fournisseurService.getAllFournisseurs());
        model.addAttribute("statuts", StatutCommande.values());
        model.addAttribute("mode", "creation");
        return "commandes/form-wrapper";
    }

    @GetMapping("/modifier/{id}")
    public String modifierForm(@PathVariable Long id, Model model) {
        try {
            Commande commande = commandeService.getCommandeById(id);
            model.addAttribute("commande", commande);
            model.addAttribute("fournisseurs", fournisseurService.getAllFournisseurs());
            model.addAttribute("statuts", StatutCommande.values());
            model.addAttribute("mode", "modification");
            return "commandes/form-wrapper";
        } catch (Exception e) {
            logger.error("Erreur lors de la récupération de la commande {}: {}", id, e.getMessage());
            return "redirect:/commandes";
        }
    }

    @PostMapping("/enregistrer")
    public String enregistrer(@Valid @ModelAttribute Commande commande,
                            BindingResult result,
                            Model model,
                            RedirectAttributes redirectAttributes) {
        logger.debug("Tentative d'enregistrement de la commande: {}", commande);
        
        if (result.hasErrors()) {
            logger.debug("Erreurs de validation: {}", result.getAllErrors());
            model.addAttribute("fournisseurs", fournisseurService.getAllFournisseurs());
            model.addAttribute("statuts", StatutCommande.values());
            model.addAttribute("mode", commande.getId() == null ? "creation" : "modification");
            return "commandes/form-wrapper";
        }

        try {
            commandeService.saveCommande(commande);
            logger.info("Commande enregistrée avec succès: {}", commande.getNumeroCommande());
            redirectAttributes.addFlashAttribute("successMessage", 
                "Commande " + (commande.getId() == null ? "créée" : "modifiée") + " avec succès.");
            return "redirect:/commandes";
        } catch (Exception e) {
            logger.error("Erreur lors de l'enregistrement de la commande: {}", e.getMessage());
            model.addAttribute("fournisseurs", fournisseurService.getAllFournisseurs());
            model.addAttribute("statuts", StatutCommande.values());
            model.addAttribute("errorMessage", "Erreur lors de l'enregistrement: " + e.getMessage());
            model.addAttribute("mode", commande.getId() == null ? "creation" : "modification");
            return "commandes/form-wrapper";
        }
    }

    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            commandeService.deleteCommande(id);
            logger.info("Commande {} supprimée avec succès", id);
            redirectAttributes.addFlashAttribute("successMessage", "Commande supprimée avec succès.");
        } catch (Exception e) {
            logger.error("Erreur lors de la suppression de la commande {}: {}", id, e.getMessage());
            redirectAttributes.addFlashAttribute("errorMessage", "Erreur lors de la suppression: " + e.getMessage());
        }
        return "redirect:/commandes";
    }

    @GetMapping("/rechercher")
    public String rechercher(@RequestParam("keyword") String keyword, 
                           @RequestParam(defaultValue = "0") int page,
                           @RequestParam(defaultValue = "10") int size,
                           Model model) {
        try {
            Page<Commande> commandesPage = commandeService.searchCommandes(keyword, PageRequest.of(page, size));
            model.addAttribute("commandes", commandesPage.getContent());
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", commandesPage.getTotalPages());
            model.addAttribute("totalItems", commandesPage.getTotalElements());
            model.addAttribute("keyword", keyword);
            model.addAttribute("dateFormatter", dateFormatter);
        } catch (Exception e) {
            logger.error("Erreur lors de la recherche des commandes: {}", e.getMessage());
            model.addAttribute("errorMessage", "Erreur lors de la recherche: " + e.getMessage());
        }
        return "commandes/liste-wrapper";
    }

    @GetMapping("/fournisseur/{fournisseurId}")
    public String commandesParFournisseur(@PathVariable Long fournisseurId, 
                                        @RequestParam(defaultValue = "0") int page,
                                        @RequestParam(defaultValue = "10") int size,
                                        Model model) {
        try {
            Page<Commande> commandesPage = commandeService.getCommandesByFournisseur(
                fournisseurId, PageRequest.of(page, size)
            );
            model.addAttribute("commandes", commandesPage.getContent());
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", commandesPage.getTotalPages());
            model.addAttribute("totalItems", commandesPage.getTotalElements());
            model.addAttribute("dateFormatter", dateFormatter);
            model.addAttribute("fournisseurId", fournisseurId);
        } catch (Exception e) {
            logger.error("Erreur lors de la récupération des commandes du fournisseur {}: {}", 
                        fournisseurId, e.getMessage());
            model.addAttribute("errorMessage", "Erreur lors de la récupération des commandes: " + e.getMessage());
        }
        return "commandes/liste-wrapper";
    }
}