<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="container mt-5 main-content">
    <h2 class="mb-4">Contacter fournisseur</h2>
    <c:if test="${not empty success}">
        <div class="alert alert-success" role="alert">
            ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
            ${error}
        </div>
    </c:if>
    <form:form action="${pageContext.request.contextPath}/supplier-orders/send"
               method="post"
               modelAttribute="supplierOrder"
               cssClass="needs-validation">
        <div class="mb-3">
            <form:label path="orderNumber" cssClass="form-label">Numéro de commande</form:label>
            <form:input path="orderNumber" cssClass="form-control" required="required"/>
        </div>
        <div class="mb-3">
            <form:label path="orderDate" cssClass="form-label">Date de commande</form:label>
            <form:input path="orderDate" type="date" cssClass="form-control" required="required"/>
        </div>
        <div class="mb-3">
            <form:label path="supplierEmail" cssClass="form-label">Email du fournisseur</form:label>
            <form:input path="supplierEmail" type="email" cssClass="form-control" required="required"/>
        </div>
        <div class="mb-3">
            <form:label path="senderEmail" cssClass="form-label">Email de l'expéditeur</form:label>
            <form:input path="senderEmail" type="email" cssClass="form-control" required="required"/>
        </div>
        <div class="mb-3">
            <form:label path="message" cssClass="form-label">Message</form:label>
            <form:textarea path="message" cssClass="form-control" rows="4" required="required"></form:textarea>
        </div>
        <div class="mb-3">
            <button type="submit" class="btn btn-primary me-2">Envoyer </button>
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Annuler</a>
        </div>
    </form:form>
</div>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
