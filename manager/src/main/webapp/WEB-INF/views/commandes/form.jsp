<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


        <div class="container mt-4">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">${commande.id == null ? 'Nouvelle Commande' : 'Modifier
                                Commande'}</h3>
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
                            <form action="/commandes/enregistrer" method="POST" onsubmit="return validateForm()">
                                <input type="hidden" name="id" value="${commande.id}">
                                <div class="mb-3">
                                    <label for="fournisseur" class="form-label">Fournisseur</label>
                                    <select id="fournisseur" name="fournisseur.id" class="form-select" required>
                                        <option value="">Sélectionnez un fournisseur</option>
                                        <c:forEach items="${fournisseurs}" var="fournisseur">
                                            <option value="${fournisseur.id}" ${fournisseur.id==commande.fournisseur.id
                                                ? 'selected' : '' }>
                                                ${fournisseur.nom}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="dateCommande" class="form-label">Date de Commande</label>
                                    <input type="date" class="form-control" id="dateCommande" name="dateCommande"
                                        value="${commande.dateCommande}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="dateLivraison" class="form-label">Date de Livraison</label>
                                    <input type="date" class="form-control" id="dateLivraison" name="dateLivraison"
                                        value="${commande.dateLivraison}">
                                </div>
                                <div class="mb-3">
                                    <label for="statut" class="form-label">Statut</label>
                                    <select id="statut" name="statut" class="form-select" required>
                                        <c:forEach items="${statuts}" var="statut">
                                            <option value="${statut}" ${statut==commande.statut ? 'selected' : '' }>
                                                ${statut}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="montantTotal" class="form-label">Montant Total</label>
                                    <input type="number" step="0.01" class="form-control" id="montantTotal"
                                        name="montantTotal" value="${commande.montantTotal}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description"
                                        required>${commande.description}</textarea>
                                </div>
                               
                              
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i>
                                        Enregistrer</button>
                                    <a href="/commandes" class="btn btn-secondary"><i class="fas fa-times"></i>
                                        Annuler</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Validation du formulaire
            function validateForm() {
                var montantTotal = document.getElementById("montantTotal").value;
                var dateCommande = document.getElementById("dateCommande").value;
                var fournisseur = document.getElementById("fournisseur").value;
                var description = document.getElementById("description").value;
                if (montantTotal <= 0) {
                    alert("Le montant total doit être supérieur à 0.");
                    return false;
                }
                if (!dateCommande) {
                    alert("La date de commande est requise.");
                    return false;
                }
                if (!fournisseur) {
                    alert("Veuillez sélectionner un fournisseur.");
                    return false;
                }
                if (description.trim() === "") {
                    alert("La description est requise.");
                    return false;
                }
                return true;
            }
        </script>