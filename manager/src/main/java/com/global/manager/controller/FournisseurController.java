package com.global.manager.controller;

import com.global.manager.entity.Fournisseur;
import com.global.manager.services.FournisseurService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/fournisseurs")
public class FournisseurController {

    private final FournisseurService fournisseurService;

    public FournisseurController(FournisseurService fournisseurService) {
        this.fournisseurService = fournisseurService;
    }

    // Liste des fournisseurs
    @GetMapping
    public String lister(Model model) {
        model.addAttribute("fournisseurs", fournisseurService.getAllFournisseurs());
        return "fournisseurs/liste-wrapper";
    }

    // Formulaire d'ajout ou de modification
    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        model.addAttribute("fournisseur", new Fournisseur());
        model.addAttribute("types", com.global.manager.enums.TypeFournisseur.values());
        return "fournisseurs/formulaire-wrapper";
    }

    // Enregistrer (ajouter ou modifier)
    @PostMapping("/enregistrer")
    public String enregistrer(@Valid @ModelAttribute Fournisseur fournisseur,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("types", com.global.manager.enums.TypeFournisseur.values());
            return "fournisseurs/formulaire-wrapper";
        }

        try {
            fournisseurService.saveFournisseur(fournisseur);
            redirectAttributes.addFlashAttribute("successMessage", "Fournisseur enregistré avec succès.");
            return "redirect:/fournisseurs";
        } catch (Exception e) {
            model.addAttribute("types", com.global.manager.enums.TypeFournisseur.values());
            model.addAttribute("errorMessage", e.getMessage());
            return "fournisseurs/formulaire-wrapper";
        }
    }

    // Modifier un fournisseur
    @GetMapping("/modifier/{id}")
    public String modifier(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        try {
            Fournisseur f = fournisseurService.getFournisseurById(id);
            if (f != null) {
                model.addAttribute("fournisseur", f);
                model.addAttribute("types", com.global.manager.enums.TypeFournisseur.values());
                return "fournisseurs/modifier-wrapper";
            }
            redirectAttributes.addFlashAttribute("errorMessage", "Fournisseur introuvable !");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erreur lors de la récupération : " + e.getMessage());
        }
        return "redirect:/fournisseurs";
    }

    // Supprimer un fournisseur
    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            fournisseurService.deleteFournisseur(id);
            redirectAttributes.addFlashAttribute("successMessage", "Fournisseur supprimé avec succès.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erreur lors de la suppression : " + e.getMessage());
        }
        return "redirect:/fournisseurs";
    }

    @GetMapping("/rechercher")
    public String rechercher(@RequestParam("keyword") String keyword, Model model) {
        model.addAttribute("fournisseurs", fournisseurService.searchFournisseurs(keyword));
        model.addAttribute("keyword", keyword);
        return "fournisseurs/liste-wrapper";
    }

}
