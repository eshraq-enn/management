<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#8b5cf6">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Tableau de Bord</title>
</head>
<body>
<div class="container mt-4">
    <h1 class="mb-4" style="color:#8b5cf6;text-shadow:0 2px 12px #d94690aa;letter-spacing:2px;font-family:'Playfair Display',serif;">Tableau de Bord</h1>
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card" style="background:linear-gradient(135deg,#d94690 60%,#8b5cf6 100%);color:#fff;box-shadow:0 4px 24px #d9469033;border:none;">
                <div class="card-body">
                    <h5 class="card-title" style="color:#fff;"><i class="fas fa-file-invoice"></i> Factures</h5>
                    <p class="card-text display-6">${totalFactures}</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card" style="background:linear-gradient(135deg,#8b5cf6 60%,#7c3aed 100%);color:#fff;box-shadow:0 4px 24px #8b5cf633;border:none;">
                <div class="card-body">
                    <h5 class="card-title" style="color:#fff;"><i class="fas fa-truck"></i> Fournisseurs</h5>
                    <p class="card-text display-6">${totalFournisseurs}</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card" style="background:linear-gradient(135deg,#7c3aed 60%,#a78bfa 100%);color:#fff;box-shadow:0 4px 24px #7c3aed33;border:none;">
                <div class="card-body">
                    <h5 class="card-title" style="color:#fff;"><i class="fas fa-shopping-cart"></i> Commandes</h5>
                    <p class="card-text display-6">${totalCommandes}</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card" style="background:linear-gradient(135deg,#a78bfa 60%,#d94690 100%);color:#fff;box-shadow:0 4px 24px #a78bfa33;border:none;">
                <div class="card-body">
                    <h5 class="card-title" style="color:#fff;"><i class="fas fa-euro-sign"></i> Montant Total</h5>
                    <p class="card-text display-6">
                        <fmt:formatNumber value="${montantTotal}" type="currency" currencySymbol="€" />
                    </p>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <div class="card quick-actions-card" style="background:rgba(139,92,246,0.10);border-radius:18px;border:none;box-shadow:0 2px 12px #7c3aed22;">
                <div class="card-header" style="background:linear-gradient(90deg,#8b5cf6 60%,#d94690 100%);color:#fff;border-radius:18px 18px 0 0;">
                    <h5 class="card-title mb-0" style="color:#fff;"><i class="fas fa-bolt"></i> Actions rapides</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <a href="${pageContext.request.contextPath}/factures/ajouter" class="btn btn-lg w-100 mb-2" style="background:linear-gradient(90deg,#d94690 60%,#8b5cf6 100%);color:#fff;border:none;box-shadow:0 2px 8px #d9469033;">
                                <i class="fas fa-plus"></i> Nouvelle facture
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="${pageContext.request.contextPath}/fournisseurs/ajouter" class="btn btn-lg w-100 mb-2" style="background:linear-gradient(90deg,#8b5cf6 60%,#7c3aed 100%);color:#fff;border:none;box-shadow:0 2px 8px #8b5cf633;">
                                <i class="fas fa-plus"></i> Nouveau fournisseur
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="${pageContext.request.contextPath}/commandes/ajouter" class="btn btn-lg w-100 mb-2" style="background:linear-gradient(90deg,#7c3aed 60%,#a78bfa 100%);color:#fff;border:none;box-shadow:0 2px 8px #7c3aed33;">
                                <i class="fas fa-plus"></i> Nouvelle commande
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="${pageContext.request.contextPath}/factures" class="btn btn-lg w-100 mb-2" style="background:linear-gradient(90deg,#a78bfa 60%,#d94690 100%);color:#fff;border:none;box-shadow:0 2px 8px #a78bfa33;">
                                <i class="fas fa-search"></i> Rechercher
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>