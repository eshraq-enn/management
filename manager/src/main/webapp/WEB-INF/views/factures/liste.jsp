<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

                .btn-action:active {
                    transform: scale(0.96);
                    box-shadow: 0 1px 4px #b388f955;
                }

                .text-premium-accroche {
                    font-size: 1.13rem;
                    color: #a1006b;
                    font-weight: 500;
                    margin-bottom: 0.5rem;
                    letter-spacing: 0.2px;
                    text-shadow: 0 2px 12px #f7c1ff33;
                    margin-top: 0.2rem;
                }

                @media (max-width: 768px) {
                    .text-premium-accroche {
                        text-align: center;
                    }
                }

                .btn-action.view {
                    background: linear-gradient(135deg, #b388f9 0%, #a78bfa 100%);
                    box-shadow: 0 2px 16px #a78bfa44;
                }

                .btn-action.view:hover {
                    background: linear-gradient(135deg, #a78bfa 0%, #f7c1ff 100%);
                    box-shadow: 0 4px 32px #b388f999, 0 0 16px #f7c1ff66;
                    transform: scale(1.08) rotate(-3deg);
                }

                .dropdown-menu {
                    border-radius: 18px;
                    box-shadow: 0 4px 24px #a78bfa33;
                    background: #fff;
                    min-width: 170px;
                    padding: 0.5rem 0;
                }

                .dropdown-item {
                    font-weight: 500;
                    color: #a1006b;
                    border-radius: 12px;
                    transition: background 0.18s, color 0.18s;
                }

                .dropdown-item:hover {
                    background: linear-gradient(90deg, #f7c1ff 0%, #b388f9 100%);
                    color: #fff;
                }
            </style>
        </head>
        <div class="container mt-4">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-3">
                <div>
                    <h2>Liste des Factures</h2>
                    <p class="text-premium-accroche text-center text-md-start">
                        Surveillez vos finances et ne ratez aucune échéance.<br>
                        <span style="font-size:0.98em;color:#b388f9;">Toutes vos factures, à portée de main pour une
                            gestion sans stress.</span>
                    </p>
                </div>
                <a href="/factures/ajouter" class="btn btn-primary mt-2 mt-md-0">
                    <i class="fas fa-plus"></i> Nouvelle Facture
                </a>
            </div>
            <div class="card">
                <div class="card-body">
                    <table class="table table-hover table-striped table-bordered align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Numéro</th>
                                <th>Fournisseur</th>
                                <th>Date</th>
                                <th>Montant</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${factures}" var="facture">
                                <tr>
                                    <td>${facture.numeroFacture}</td>
                                    <td>${facture.fournisseur.nom}</td>
                                    <td>${facture.dateFacture}</td>
                                    <td>${facture.montantTotal} €</td>
                                    <td>
                                        <span
                                            class="badge bg-${facture.statut == 'PAYEE' ? 'success' : 
                                                                  facture.statut == 'EN_RETARD' ? 'danger' : 
                                                                  facture.statut == 'EN_ATTENTE' ? 'warning' : 'secondary'}">
                                            ${facture.statut.description}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="/factures/modifier/${facture.id}" class="btn-action edit"
                                                title="Modifier">
                                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                    stroke="#fff" stroke-width="2.2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <path d="M12 20h9" />
                                                    <path
                                                        d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19.5 3 21l1.5-4L16.5 3.5z" />
                                                </svg>
                                            </a>
                                            <a href="/factures/supprimer/${facture.id}" class="btn-action delete"
                                                title="Supprimer"
                                                onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette facture ?')">
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
                                            <a href="/factures/visualiser/${facture.id}" class="btn-action view"
                                                title="Visualiser" target="_blank">
                                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                    stroke="#fff" stroke-width="2.2" stroke-linecap="round"
                                                    stroke-linejoin="round">
                                                    <path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z" />
                                                    <circle cx="12" cy="12" r="3" />
                                                </svg>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty factures}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted">Aucune facture trouvée.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>