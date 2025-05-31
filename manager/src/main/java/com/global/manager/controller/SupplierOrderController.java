package com.global.manager.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.global.manager.entity.SupplierOrder;
import com.global.manager.services.impl.SupplierOrderService;

@Controller
@RequestMapping("/supplier-orders")
public class SupplierOrderController {

    @Autowired
    private SupplierOrderService supplierOrderService;

    @GetMapping("/new")
    public String showOrderForm(Model model) {
        model.addAttribute("supplierOrder", new SupplierOrder());
        model.addAttribute("contentPage", "/WEB-INF/views/supplier-orders/create.jsp");
        return "layout/template";
    }

    @GetMapping("/new/{id}")
    public String showOrderFormWithId(@PathVariable Long id, Model model) {
        // Load the supplier order by id if needed
        model.addAttribute("supplierOrder", new SupplierOrder());
        model.addAttribute("contentPage", "/WEB-INF/views/supplier-orders/create.jsp");
        return "layout/template";
    }

    @PostMapping("/send")
    public String sendOrder(@ModelAttribute("supplierOrder") SupplierOrder supplierOrder,
                            RedirectAttributes redirectAttributes) {
        try {
            supplierOrderService.saveOrder(supplierOrder);
            redirectAttributes.addFlashAttribute("success", "Commande envoyée avec succès!");
            return "redirect:/supplier-orders/new";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de l'envoi de la commande: " + e.getMessage());
            return "redirect:/supplier-orders/new";
        }
    }
}