<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
      
            <div class="container mt-4">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card border-danger">
                            <div class="card-header bg-danger text-white">
                                <h4 class="mb-0">Confirmer la suppression</h4>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <c:out value="${successMessage}" />
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <c:out value="${errorMessage}" />
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>
                                <p>Êtes-vous sûr de vouloir supprimer le fournisseur suivant ?</p>
                                <ul class="list-group mb-3">
                                    <li class="list-group-item"><strong>Nom:</strong> ${fournisseur.nom}</li>
                                    <li class="list-group-item"><strong>Email:</strong> ${fournisseur.email}</li>
                                    <li class="list-group-item"><strong>Téléphone:</strong> ${fournisseur.telephone}
                                    </li>
                                    <li class="list-group-item"><strong>Adresse:</strong> ${fournisseur.adresse}</li>
                                </ul>
                                <form action="/fournisseurs/supprimer/${fournisseur.id}" method="GET"
                                    class="d-flex justify-content-end gap-2">
                                    <button type="submit" class="btn btn-danger"><i class="fas fa-trash"></i>
                                        Supprimer</button>
                                    <a href="/fournisseurs" class="btn btn-secondary"><i class="fas fa-times"></i>
                                        Annuler</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
