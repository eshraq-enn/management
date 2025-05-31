package com.global.manager.repository;

import com.global.manager.entity.Fournisseur;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FournisseurRepository extends JpaRepository<Fournisseur, Long> {
    boolean existsByEmail(String email);
    List<Fournisseur> findByNomContainingIgnoreCase(String nom);

}
