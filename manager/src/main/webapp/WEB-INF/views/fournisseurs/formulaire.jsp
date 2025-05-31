<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            

                <div class="container mt-4">
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">${fournisseur.id == null ? 'Nouveau Fournisseur' : 'Modifier
                                        Fournisseur'}</h3>
                                </div>
                                <div class="card-body">
                                    <c:if test="${not empty errorMessage}">
                                        <div class="alert alert-danger" role="alert">
                                            <c:out value="${errorMessage}" />
                                        </div>
                                    </c:if>
                                    <form:form action="/fournisseurs/enregistrer" method="post"
                                        modelAttribute="fournisseur">
                                        <form:hidden path="id" />
                                        <c:if test="${not empty successMessage}">
                                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                                <c:out value="${successMessage}" />
                                                <button type="button" class="btn-close"
                                                    data-bs-dismiss="alert"></button>
                                            </div>
                                        </c:if>
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
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label for="nom" class="form-label">Nom *</label>
                                                <form:input path="nom" class="form-control" required="required" />
                                                <form:errors path="nom" cssClass="text-danger small" />
                                            </div>
                                            <div class="col-md-6">
                                                <label for="email" class="form-label">Email *</label>
                                                <form:input path="email" type="email" class="form-control"
                                                    required="required" />
                                                <form:errors path="email" cssClass="text-danger small" />
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label for="telephone" class="form-label">Téléphone *</label>
                                                <form:input path="telephone" class="form-control" required="required"
                                                    pattern="^\\+?[0-9]{10,15}$"
                                                    title="Le numéro de téléphone doit contenir entre 10 et 15 chiffres" />
                                                <form:errors path="telephone" cssClass="text-danger small" />
                                            </div>
                                            <div class="col-md-6">
                                                <label for="type" class="form-label">Type *</label>
                                                <form:select path="type" class="form-select" required="required">
                                                    <form:option value="">Sélectionnez un type</form:option>
                                                    <form:options items="${types}" itemValue="name"
                                                        itemLabel="description" />
                                                </form:select>
                                                <form:errors path="type" cssClass="text-danger small" />
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="adresse" class="form-label">Adresse</label>
                                            <form:textarea path="adresse" class="form-control" rows="3" />
                                            <form:errors path="adresse" cssClass="text-danger small" />
                                        </div>
                                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-save"></i> Enregistrer
                                            </button>
                                            <a href="/fournisseurs" class="btn btn-secondary">
                                                <i class="fas fa-times"></i> Annuler
                                            </a>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                