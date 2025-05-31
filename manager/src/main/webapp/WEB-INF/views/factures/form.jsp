<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


            <div class="container mt-4">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">${facture.id == null ? 'Nouvelle Facture' : 'Modifier
                                    Facture'}</h3>
                            </div>
                            <div class="card-body">
                                <!-- Messages Flash -->
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

                                <!-- Affichage des erreurs de validation Spring -->
                                <c:if test="${not empty result}">
                                    <div class="alert alert-danger">
                                        <ul>
                                            <c:forEach items="${result.allErrors}" var="err">
                                                <li>
                                                    <c:out value="${err.defaultMessage}" />
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/factures/enregistrer" method="post"
                                    enctype="multipart/form-data">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <input type="hidden" name="id" value="${facture.id}">
                                    <input type="hidden" name="nomFichier" value="${facture.nomFichier}">

                                    <div class="mb-3">
                                        <label for="numeroFacture" class="form-label">Numéro de facture *</label>
                                        <input type="text" class="form-control" id="numeroFacture" name="numeroFacture"
                                            value="${facture.numeroFacture}" required minlength="3" maxlength="50">
                                    </div>

                                    <div class="mb-3">
                                        <label for="fournisseur.id" class="form-label">Fournisseur *</label>
                                        <select class="form-select" id="fournisseur.id" name="fournisseur.id" required>
                                            <option value="">Sélectionner un fournisseur</option>
                                            <c:forEach items="${fournisseurs}" var="fournisseur">
                                                <option value="${fournisseur.id}"
                                                    ${facture.fournisseur.id==fournisseur.id ? 'selected' : '' }>
                                                    ${fournisseur.nom}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="dateFacture" class="form-label">Date de facture *</label>
                                        <input type="date" class="form-control" id="dateFacture" name="dateFacture"
                                            value="${facture.dateFacture}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="dateEcheance" class="form-label">Date d'échéance *</label>
                                        <input type="date" class="form-control" id="dateEcheance" name="dateEcheance"
                                            value="${facture.dateEcheance}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="montantTotal" class="form-label">Montant total (TTC) *</label>
                                        <input type="number" step="0.01" min="0" class="form-control" id="montantTotal"
                                            name="montantTotal" value="${facture.montantTotal}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="tauxTVA" class="form-label">Taux de TVA (%) *</label>
                                        <input type="number" step="0.01" min="0" max="100" class="form-control"
                                            id="tauxTVA" name="tauxTVA" value="${facture.tauxTVA}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="statut" class="form-label">Statut *</label>
                                        <select class="form-select" id="statut" name="statut" required>
                                            <option value="">Sélectionner un statut</option>
                                            <c:forEach items="${statuts}" var="statut">
                                                <option value="${statut}" ${facture.statut==statut ? 'selected' : '' }>
                                                    ${statut.description}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="fichierFacture" class="form-label">Télécharger la facture (PDF ou
                                            image)</label>
                                        <input type="file" class="form-control" id="fichierFacture"
                                            name="fichierFacture" accept=".pdf,image/*">
                                    </div>

                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" name="description"
                                            rows="3">${facture.description}</textarea>
                                    </div>

                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Enregistrer
                                        </button>
                                        <a href="/factures" class="btn btn-secondary">
                                            <i class="fas fa-times"></i> Annuler
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>