package com.global.manager.controller;

import com.global.manager.entity.Facture;
import com.global.manager.services.FactureService;
import com.global.manager.services.FournisseurService;
import com.global.manager.enums.StatutFacture;
import com.global.manager.exception.FactureException;

import jakarta.validation.Valid;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.time.format.DateTimeFormatter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.math.BigDecimal;

@Controller
@RequestMapping("/factures")
public class FactureController {

    private final FactureService factureService;
    private final FournisseurService fournisseurService;
    private final DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private final String UPLOAD_DIR = "uploads/factures/";

    public FactureController(FactureService factureService, FournisseurService fournisseurService) {
        this.factureService = factureService;
        this.fournisseurService = fournisseurService;
    }

    @GetMapping
    public String lister(Model model) {
        try {
            model.addAttribute("factures", factureService.getAllFactures());
            model.addAttribute("fournisseurs", fournisseurService.getAllFournisseurs());
            model.addAttribute("dateFormatter", dateFormatter);
            model.addAttribute("statuts", StatutFacture.values());
            model.addAttribute("facturesEnRetard", factureService.getFacturesEnRetard());
            return "factures/liste-wrapper";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Erreur lors du chargement des factures : " + e.getMessage());
            return "factures/liste-wrapper";
        }
    }

    @GetMapping("/ajouter")
    public String ajouterForm(Model model) {
        try {
            model.addAttribute("facture", new Facture());
            model.addAttribute("fournisseurs", fournisseurService.getAllFournisseurs());
            model.addAttribute("statuts", StatutFacture.values());
            return "factures/form-wrapper";
        } catch (Exception e) {
            return "redirect:/factures?error=" + e.getMessage();
        }
    }

    @PostMapping("/enregistrer")
    public String enregistrer(@Valid @ModelAttribute Facture facture,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {
        try {
            if (result.hasErrors()) {
                model.addAttribute("fournisseurs", fournisseurService.getAllFournisseurs());
                model.addAttribute("statuts", StatutFacture.values());
                return "factures/form-wrapper";
            }

            // Sauvegarder la facture
            factureService.saveFacture(facture);

            redirectAttributes.addFlashAttribute("successMessage",
                    facture.getId() == null ? "Facture créée avec succès." : "Facture modifiée avec succès.");
            return "redirect:/factures";
        } catch (FactureException e) {
            model.addAttribute("fournisseurs", fournisseurService.getAllFournisseurs());
            model.addAttribute("statuts", StatutFacture.values());
            model.addAttribute("errorMessage", e.getMessage());
            return "factures/form-wrapper";
        }
    }

    @GetMapping("/modifier/{id}")
    public String modifier(@PathVariable Long id, Model model) {
        try {
            Facture facture = factureService.getFactureById(id);
            if (facture == null) {
                return "redirect:/factures?error=Facture non trouvée";
            }

            model.addAttribute("facture", facture);
            model.addAttribute("fournisseurs", fournisseurService.getAllFournisseurs());
            model.addAttribute("statuts", StatutFacture.values());
            return "factures/form-wrapper";
        } catch (Exception e) {
            return "redirect:/factures?error=" + e.getMessage();
        }
    }

    @GetMapping("/supprimer/{id}")
    public String supprimer(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            factureService.deleteFacture(id);
            redirectAttributes.addFlashAttribute("successMessage", "Facture supprimée avec succès.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erreur lors de la suppression : " + e.getMessage());
        }
        return "redirect:/factures";
    }

    @PostMapping("/upload")
    public String uploadFile(@RequestParam("file") MultipartFile file,
            @RequestParam("numeroFacture") String numeroFacture,
            @RequestParam("fournisseurId") Long fournisseurId,
            @RequestParam("dateFacture") LocalDate dateFacture,
            @RequestParam("dateEcheance") LocalDate dateEcheance,
            @RequestParam("montantTotal") BigDecimal montantTotal,
            @RequestParam("tauxTVA") BigDecimal tauxTVA,
            @RequestParam(value = "description", required = false) String description,
            RedirectAttributes redirectAttributes) {
        try {
            // Vérifier si le fichier est vide
            if (file.isEmpty()) {
                throw new FactureException("Veuillez sélectionner un fichier");
            }

            // Vérifier le type de fichier
            String contentType = file.getContentType();
            if (contentType == null || (!contentType.equals("application/pdf") &&
                    !contentType.equals("application/msword") &&
                    !contentType.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document"))) {
                throw new FactureException("Format de fichier non supporté. Formats acceptés : PDF, DOC, DOCX");
            }

            // Vérifier la taille du fichier (max 10MB)
            if (file.getSize() > 10 * 1024 * 1024) {
                throw new FactureException("Le fichier est trop volumineux. Taille maximale : 10MB");
            }

            // Créer le répertoire s'il n'existe pas
            Path uploadPath = Paths.get(UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Générer un nom de fichier unique
            String originalFilename = file.getOriginalFilename();
            String extension = getFileExtension(originalFilename);
            String fileName = numeroFacture + "_" + System.currentTimeMillis() + extension;
            Path filePath = uploadPath.resolve(fileName);

            // Sauvegarder le fichier
            try {
                Files.copy(file.getInputStream(), filePath);
            } catch (IOException e) {
                throw new FactureException("Erreur lors de la sauvegarde du fichier : " + e.getMessage());
            }

            // Créer une nouvelle facture
            Facture facture = new Facture();
            facture.setNumeroFacture(numeroFacture);
            facture.setFournisseur(fournisseurService.getFournisseurById(fournisseurId));
            facture.setDateFacture(dateFacture);
            facture.setDateEcheance(dateEcheance);
            facture.setStatut(StatutFacture.EN_ATTENTE);
            facture.setDescription(description != null ? description : "Facture téléchargée : " + fileName);
            facture.setNomFichier(fileName);
            facture.setMontantTotal(montantTotal);
            facture.setTauxTVA(tauxTVA);

            factureService.saveFacture(facture);
            redirectAttributes.addFlashAttribute("successMessage", "Facture téléchargée avec succès.");
        } catch (FactureException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erreur lors du téléchargement : " + e.getMessage());
        }
        return "redirect:/factures";
    }

    @GetMapping("/telecharger/{id}")
    public ResponseEntity<Resource> telechargerFacture(@PathVariable Long id) {
        try {
            Facture facture = factureService.getFactureById(id);
            if (facture == null || facture.getNomFichier() == null) {
                return ResponseEntity.notFound().build();
            }

            Path filePath = Paths.get(UPLOAD_DIR).resolve(facture.getNomFichier());
            Resource resource = new UrlResource(filePath.toUri());

            if (resource.exists() && resource.isReadable()) {
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION,
                                "attachment; filename=\"" + facture.getNomFichier() + "\"")
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    @PostMapping("/marquer-payee/{id}")
    public String marquerCommePayee(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            factureService.marquerCommePayee(id);
            redirectAttributes.addFlashAttribute("successMessage", "Facture marquée comme payée avec succès.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erreur : " + e.getMessage());
        }
        return "redirect:/factures";
    }

    @GetMapping("/rechercher")
    public String rechercher(@RequestParam("keyword") String keyword, Model model) {
        try {
            model.addAttribute("factures", factureService.searchFactures(keyword));
            model.addAttribute("keyword", keyword);
            model.addAttribute("dateFormatter", dateFormatter);
            model.addAttribute("fournisseurs", fournisseurService.getAllFournisseurs());
            model.addAttribute("statuts", StatutFacture.values());
            return "factures/liste-wrapper";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Erreur lors de la recherche : " + e.getMessage());
            return "factures/liste-wrapper";
        }
    }

    @GetMapping("/visualiser/{id}")
    public ResponseEntity<Resource> visualiserFacture(@PathVariable Long id) {
        try {
            Facture facture = factureService.getFactureById(id);
            if (facture == null || facture.getNomFichier() == null) {
                return ResponseEntity.notFound().build();
            }

            Path filePath = Paths.get(UPLOAD_DIR).resolve(facture.getNomFichier());
            Resource resource = new UrlResource(filePath.toUri());

            if (resource.exists() && resource.isReadable()) {
                String contentType = Files.probeContentType(filePath);
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + facture.getNomFichier() + "\"")
                        .header(HttpHeaders.CONTENT_TYPE, contentType)
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    private String getFileExtension(String fileName) {
        if (fileName == null)
            return "";
        int lastIndexOf = fileName.lastIndexOf(".");
        if (lastIndexOf == -1)
            return "";
        return fileName.substring(lastIndexOf);
    }
}