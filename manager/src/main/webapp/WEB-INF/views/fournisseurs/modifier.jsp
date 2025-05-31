<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    

            <div class="container mt-4">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Modifier Fournisseur</h3>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger" role="alert">
                                        <c:out value="${errorMessage}" />
                                    </div>
                                </c:if>
                                <form action="/fournisseurs/enregistrer" method="POST" onsubmit="return validateForm()">
                                    <input type="hidden" name="id" value="${fournisseur.id}">
                                    <div class="mb-3">
                                        <label for="nom" class="form-label">Nom</label>
                                        <input type="text" class="form-control" id="nom" name="nom"
                                            value="${fournisseur.nom}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email"
                                            value="${fournisseur.email}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="telephone" class="form-label">Téléphone</label>
                                        <input type="text" class="form-control" id="telephone" name="telephone"
                                            value="${fournisseur.telephone}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="type" class="form-label">Type</label>
                                        <select id="type" name="type" class="form-select" required>
                                            <c:forEach items="${types}" var="type">
                                                <option value="${type}" ${type==fournisseur.type ? 'selected' : '' }>
                                                    ${type}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="adresse" class="form-label">Adresse</label>
                                        <textarea class="form-control" id="adresse" name="adresse"
                                            required>${fournisseur.adresse}</textarea>
                                    </div>
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i>
                                            Enregistrer</button>
                                        <a href="/fournisseurs" class="btn btn-secondary"><i class="fas fa-times"></i>
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
                    var email = document.getElementById("email").value;
                    var telephone = document.getElementById("telephone").value;
                    var nom = document.getElementById("nom").value;

                    // Validation de l'email (expression régulière basique)
                    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                    if (!email.match(emailPattern)) {
                        alert("Veuillez entrer un email valide.");
                        return false;
                    }

                    // Validation du téléphone (expression régulière basique pour 10 chiffres)
                    var phonePattern = /^\d{10}$/;
                    if (!telephone.match(phonePattern)) {
                        alert("Veuillez entrer un numéro de téléphone valide (10 chiffres).");
                        return false;
                    }

                    // Vérification que le nom est non vide
                    if (nom.trim() === "") {
                        alert("Le nom est requis.");
                        return false;
                    }

                    return true; // Le formulaire peut être soumis si toutes les validations passent
                }
            </script>

            