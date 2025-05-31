<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


            <div class="container mt-4">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-3">
                    <div>
                        <h2>Liste des Commandes</h2>
                        <p class="text-premium-accroche text-center text-md-start">
                            Gardez le contrôle sur toutes vos commandes, du suivi à la livraison.<br>
                            <span style="font-size:0.98em;color:#b388f9;">Visualisez, modifiez et pilotez vos achats en
                                toute simplicité.</span>
                        </p>
                    </div>
                    <a href="/commandes/ajouter" class="btn btn-primary mt-2 mt-md-0">
                        <i class="fas fa-plus"></i> Nouvelle Commande
                    </a>
                </div>
                <form action="/commandes/rechercher" method="get" class="mb-3">
                    <div class="input-group">
                        <input type="text" name="keyword" class="form-control" placeholder="Rechercher une commande..."
                            value="${keyword != null ? keyword : ''}">
                        <button class="btn btn-outline-primary" type="submit">Rechercher</button>
                    </div>
                </form>
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover table-striped table-bordered align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Numéro</th>
                                        <th>Fournisseur</th>
                                        <th>Date</th>
                                        <th>Montant</th>
                                        <th>Statut</th>
                                        <th>Description</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${commandes}" var="commande">
                                        <tr>
                                            <td>${commande.numeroCommande}</td>
                                            <td>${commande.fournisseur.nom}</td>
                                            <td>${commande.dateCommande.format(dateFormatter)}</td>
                                            <td>
                                                <fmt:formatNumber value="${commande.montantTotal}" type="currency"
                                                    currencySymbol="€" />
                                            </td>
                                            <td>
                                                <span class="badge bg-${commande.statut == 'LIVREE' ? 'success' : 
                                                          commande.statut == 'ANNULEE' ? 'danger' : 
                                                          commande.statut == 'CONFIRMEE' ? 'primary' : 
                                                          commande.statut == 'EN_COURS' ? 'warning' : 'secondary'}">
                                                    ${commande.statut.description}
                                                </span>
                                            </td>
                                            <td>${commande.description}</td>
                                            <td>
                                                <a href="/commandes/modifier/${commande.id}" class="btn-action edit"
                                                    title="Modifier">
                                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                        stroke="#fff" stroke-width="2.2" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <path d="M12 20h9" />
                                                        <path
                                                            d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19.5 3 21l1.5-4L16.5 3.5z" />
                                                    </svg>
                                                </a>
                                                <a href="/commandes/supprimer/${commande.id}" class="btn-action delete"
                                                    title="Supprimer"
                                                    onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette commande ?')">
                                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                        stroke="#fff" stroke-width="2.2" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <polyline points="3 6 5 6 21 6" />
                                                        <path
                                                            d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v2" />
                                                        <line x1="10" y1="11" x2="10" y2="17" />
                                                        <line x1="14" y1="11" x2="14" y2="17" />
                                                    </svg>
                                                </a>
                                                <a href="/supplier-orders/new" class="btn-action email"
                                                    title="Envoyer par Email"
                                                    onclick="return confirm('Êtes-vous sûr de vouloir envoyer  email ?')">
                                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                        stroke="#fff" stroke-width="2.2" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <path
                                                            d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" />
                                                        <polyline points="22,6 12,13 2,6" />
                                                    </svg>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty commandes}">
                                        <tr>
                                            <td colspan="7" class="text-center text-muted">Aucune commande trouvée.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <head>
                <style>
                    .btn-action {
                        border: none;
                        outline: none;
                        border-radius: 50%;
                        width: 38px;
                        height: 38px;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        margin: 0 4px;
                        box-shadow: 0 2px 12px #b388f955, 0 0 8px #f7c1ff33;
                        background: rgba(255, 255, 255, 0.18);
                        transition: box-shadow 0.25s, transform 0.18s, background 0.25s;
                        position: relative;
                        z-index: 1;
                    }

                    .btn-action svg {
                        display: block;
                        filter: drop-shadow(0 0 4px #e0b3ff88);
                        transition: filter 0.2s;
                    }

                    .btn-action.edit {
                        background: linear-gradient(135deg, #a78bfa 0%, #f7c1ff 100%);
                        box-shadow: 0 2px 16px #a78bfa44;
                    }

                    .btn-action.delete {
                        background: linear-gradient(135deg, #f7c1ff 0%, #d94690 100%);
                        box-shadow: 0 2px 16px #d9469044;
                    }

                    .btn-action.email {
                        background: linear-gradient(135deg, #86efac 0%, #3b82f6 100%);
                        /* Vert à Bleu */
                        box-shadow: 0 2px 16px #3b82f644;
                    }

                    .btn-action.edit:hover {
                        background: linear-gradient(135deg, #b388f9 0%, #a78bfa 100%);
                        box-shadow: 0 4px 32px #a78bfa99, 0 0 16px #f7c1ff66;
                        transform: scale(1.08) rotate(-6deg);
                    }

                    .btn-action.delete:hover {
                        background: linear-gradient(135deg, #d94690 0%, #f7c1ff 100%);
                        box-shadow: 0 4px 32px #d94690aa, 0 0 16px #f7c1ff66;
                        transform: scale(1.08) rotate(6deg);
                    }

                    .btn-action.email:hover {
                        background: linear-gradient(135deg, #4ade80 0%, #2563eb 100%);
                        box-shadow: 0 4px 32px #2563eb99, 0 0 16px #4ade8066;
                        transform: scale(1.08) rotate(-3deg);
                    }

                    .btn-action:active {
                        transform: scale(0.96);
                        box-shadow: 0 1px 4px #b388f955;
                    }
                </style>
            </head>