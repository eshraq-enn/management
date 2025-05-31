<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <title>
        <c:out value="${pageTitle != null ? pageTitle : 'Global Manager'}" />
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <link
            href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Playfair+Display:wght@700&display=swap"
            rel="stylesheet">
    <style>
        body {
            /* Dégradé fuchsia, lavande, violet pastel uniquement */
            min-height: 100vh;
            background-color: #e9d5ff;
            /* Couleur de secours lavande pastel */
            background: linear-gradient(120deg, #f472b6, #a78bfa, #c4b5fd, #d8b4fe 90%);
            background-size: 300% 300%;
            animation: gradientBG 18s ease-in-out infinite;
            font-family: 'Montserrat', Arial, Helvetica, sans-serif;
            color: #232526;
            transition: background 0.6s, color 0.6s;
        }

        @keyframes gradientBG {
            0% {
                background-position: 0% 50%;
            }

            50% {
                background-position: 100% 50%;
            }

            100% {
                background-position: 0% 50%;
            }
        }

        body.dark-mode {
            background: var(--main-bg-dark, linear-gradient(135deg, #232526 0%, #414345 100%));
            color: #f1f1f1;
        }

        :root {
            --main-color: #7c3aed;
            --accent-color: #232526;
            --gold: #facc15;
            --pearl: #f3f4f6;
            --main-bg: linear-gradient(135deg, #232526 0%, #7c3aed 100%);
            --main-bg-dark: linear-gradient(135deg, #18181b 0%, #232526 100%);
        }

        .lux-header {
            background: linear-gradient(90deg, #a78bfa 60%, #c4b5fd 100%);
            box-shadow: 0 4px 24px #a78bfa33;
            border-bottom: 1.5px solid #e9d5ff;
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(14px);
        }

        .dark-mode .lux-header {
            background: rgba(24, 24, 27, 0.92);
            border-bottom: 1.5px solid #232526;
        }

        .glass-card,
        .container.lux {
            background: rgba(255, 255, 255, 0.22);
            border-radius: 28px;
            box-shadow: 0 8px 32px 0 rgba(124, 58, 237, 0.10), 0 1.5px 8px 0 rgba(250, 204, 21, 0.06);
            border: 1.5px solid rgba(255, 255, 255, 0.18);
            padding: 48px 36px;
            margin-top: 40px;
            margin-bottom: 40px;
            backdrop-filter: blur(24px);
            transition: background 0.6s, color 0.6s, box-shadow 0.5s, transform 0.4s;
        }

        .glass-card:hover {
            box-shadow: 0 16px 64px 0 rgba(124, 58, 237, 0.18), 0 2.5px 12px 0 rgba(250, 204, 21, 0.12);
            transform: scale(1.012);
        }

        .dark-mode .glass-card,
        .dark-mode .container.lux {
            background: rgba(35, 37, 38, 0.92);
            color: #f3f4f6;
        }

        .lux-footer {
            background: linear-gradient(90deg, var(--main-color) 60%, var(--accent-color) 100%);
            color: #fff;
            border-top: none;
            box-shadow: 0 -2px 16px rgba(124, 58, 237, 0.10);
            font-size: 1.1rem;
            letter-spacing: 0.5px;
        }

        .dark-mode .lux-footer {
            background: linear-gradient(90deg, #18181b 60%, #232526 100%);
            color: #f3f4f6;
        }

        .main-content {
            min-height: 80vh;
            padding-top: 40px;
            padding-bottom: 40px;
            animation: fadeIn 0.9s;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }

            to {
                opacity: 1;
                transform: none;
            }
        }

        .navbar {
            min-height: 54px;
            padding-top: 0.1rem;
            padding-bottom: 0.1rem;
            display: flex;
            align-items: center;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 1.35rem;
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            color: #fff !important;
            letter-spacing: 1.2px;
            padding: 0;
        }

        .navbar-brand img {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            border: 2px solid #fff;
            box-shadow: 0 0 6px #a78bfa66;
        }

        .navbar-nav {
            display: flex;
            align-items: center;
            gap: 2px;
        }

        .navbar-nav .nav-link {
            color: #fff !important;
            font-size: 1.04rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
            padding: 0.35rem 0.85rem;
            border-radius: 10px;
            transition: background 0.2s, color 0.2s, box-shadow 0.2s;
        }

        .navbar-nav .nav-link svg {
            width: 20px;
            height: 20px;
            stroke: #fff;
            transition: stroke 0.2s, filter 0.2s;
            filter: drop-shadow(0 0 3px #a78bfa33);
        }

        .navbar-nav .nav-link.active,
        .navbar-nav .nav-link:hover {
            background: rgba(244, 114, 182, 0.13);
            color: #d94690 !important;
            box-shadow: 0 2px 8px #d9469033;
        }

        .navbar-nav .nav-link.active svg,
        .navbar-nav .nav-link:hover svg {
            stroke: #d94690;
            filter: drop-shadow(0 0 6px #d9469088);
        }

        .navbar-nav.ms-auto {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .notif-bell,
        .dark-toggle,
        .theme-picker,
        .avatar {
            margin-left: 0 !important;
            margin-right: 0 !important;
        }

        .notif-bell {
            font-size: 1.25rem;
        }

        .dark-toggle {
            font-size: 1.25rem;
        }

        .theme-picker {
            width: 28px;
            height: 28px;
        }

        .avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            object-fit: cover;
            border: none;
            box-shadow: none;
        }

        #userName {
            font-size: 1.05rem;
            color: #fff;
            font-weight: 500;
            margin-left: 6px;
        }

        @media (max-width: 991px) {
            .navbar-nav .nav-link {
                padding: 0.35rem 0.7rem;
                font-size: 0.98rem;
            }

            .navbar-brand {
                font-size: 1.1rem;
            }

            #userName {
                font-size: 0.98rem;
            }
        }

        .dropdown-menu {
            min-width: 200px;
            border-radius: 18px;
            box-shadow: 0 4px 24px #23252622;
            background: rgba(255, 255, 255, 0.95);
        }

        .notif-badge {
            position: absolute;
            top: 0;
            right: -6px;
            background: var(--gold);
            color: #232526;
            border-radius: 50%;
            font-size: 0.9rem;
            padding: 2px 8px;
            font-weight: bold;
            box-shadow: 0 0 8px #7c3aed33;
        }

        .btn,
        .btn-lg,
        .btn-primary,
        .btn-outline-primary,
        .btn-secondary {
            transition: box-shadow 0.3s, transform 0.3s, background 0.4s, color 0.4s;
            border-radius: 16px;
            font-family: 'Montserrat', Arial, Helvetica, sans-serif;
        }

        .btn-primary,
        .btn-outline-primary {
            box-shadow: 0 2px 12px #7c3aed33, 0 0 8px #facc1533;
            font-weight: 600;
            letter-spacing: 0.7px;
            background: linear-gradient(90deg, #7c3aed 60%, #facc15 100%);
            border: none;
            color: #fff;
        }

        .btn-primary:hover,
        .btn-outline-primary:hover {
            background: linear-gradient(90deg, #232526 60%, #7c3aed 100%);
            color: #facc15;
            box-shadow: 0 4px 32px #7c3aed55, 0 0 16px #facc1555;
            transform: scale(1.07);
        }

        .btn:hover,
        .btn-lg:hover,
        .btn-secondary:hover {
            box-shadow: 0 4px 24px #23252633, 0 0 8px #facc1533;
            transform: translateY(-2px) scale(1.04);
        }

        .dark-mode .btn-primary,
        .dark-mode .btn-outline-primary {
            background: #232526;
            color: #facc15;
            border: 1px solid #facc15;
        }

        .dark-mode .btn-primary:hover,
        .dark-mode .btn-outline-primary:hover {
            background: #facc15;
            color: #232526;
        }

        .dark-toggle {
            background: none;
            border: none;
            color: var(--gold);
            font-size: 1.8rem;
            margin-left: 18px;
            cursor: pointer;
            transition: color 0.4s, text-shadow 0.4s;
            text-shadow: 0 0 8px #facc15, 0 0 16px #7c3aed33;
        }

        .dark-toggle:hover {
            color: #fff;
            text-shadow: 0 0 32px #facc15, 0 0 32px #7c3aed;
        }

        .theme-picker {
            margin-left: 18px;
            border-radius: 50%;
            border: 2px solid #fff;
            width: 36px;
            height: 36px;
            cursor: pointer;
            outline: none;
            box-shadow: 0 2px 8px #7c3aed33;
        }

        /* Loader SVG haut de gamme */
        .loader {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.7);
            z-index: 9999;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: opacity 0.4s;
        }

        .loader.hidden {
            opacity: 0;
            pointer-events: none;
        }

        .toast-container {
            position: fixed;
            bottom: 32px;
            right: 32px;
            z-index: 1055;
        }

        a.nav-link.active,
        a.nav-link:hover {
            color: var(--gold) !important;
            text-shadow: 0 0 16px #7c3aed55, 0 0 8px #facc1533;
        }

        /* Tableaux élégants */
        table {
            border-radius: 18px;
            overflow: hidden;
            background: rgba(255, 255, 255, 0.85);
            box-shadow: 0 2px 16px #7c3aed22;
        }

        th {
            background: linear-gradient(90deg, #7c3aed 60%, #facc15 100%);
            color: #fff;
            font-family: 'Montserrat', Arial, Helvetica, sans-serif;
            font-weight: 600;
            letter-spacing: 1px;
        }

        td {
            font-family: 'Montserrat', Arial, Helvetica, sans-serif;
            color: #232526;
        }

        tr {
            transition: background 0.3s;
        }

        tr:hover {
            background: rgba(124, 58, 237, 0.07);
        }

        .notif-bell:hover svg {
            stroke: #d94690;
            filter: drop-shadow(0 0 12px #d94690cc);
            transform: scale(1.08) rotate(-8deg);
            transition: all 0.2s;
        }

        .notif-badge {
            transition: background 0.2s, box-shadow 0.2s;
        }

        .notif-icon-wrapper {
            position: relative;
            display: inline-block;
        }

        .notif-bell-svg {
            filter: drop-shadow(0 0 8px #e0b3ff);
            transition: filter 0.2s, transform 0.2s;
            vertical-align: middle;
        }

        .notif-icon-wrapper:hover .notif-bell-svg {
            filter: drop-shadow(0 0 24px #d94690cc);
            transform: scale(1.08) rotate(-6deg);
        }

        #notifBadgeText {
            animation: notif-pulse 1.2s infinite alternate;
        }

        @keyframes notif-pulse {
            0% {
                text-shadow: 0 0 8px #e0b3ff, 0 0 0 0 #f7c1ff55;
            }

            100% {
                text-shadow: 0 0 16px #b388f9, 0 0 0 8px #f7c1ff22;
            }
        }

        /* Styles pour l'authentification */
        .login-container,
        .register-container {
            max-width: 500px;
            margin: 50px auto;
        }

        .login-container .card,
        .register-container .card {
            background: rgba(255, 255, 255, 0.15);
            border: none;
        }

        .login-container .card-header,
        .register-container .card-header {
            background: none;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
            text-align: center;
        }

        .login-container .form-control,
        .register-container .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
        }

        .login-container .form-control:focus,
        .register-container .form-control:focus {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 0 0.25rem rgba(255, 255, 255, 0.1);
        }

        .login-container .btn-primary,
        .register-container .btn-primary {
            background: linear-gradient(135deg, #f472b6 0%, #a78bfa 100%);
            border: none;
            width: 100%;
            padding: 12px;
            margin-top: 20px;
            font-weight: 600;
        }

        .login-container .btn-primary:hover,
        .register-container .btn-primary:hover {
            background: linear-gradient(135deg, #a78bfa 0%, #f472b6 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(167, 139, 250, 0.3);
        }

        .forgot-password,
        .register-link,
        .login-link {
            text-align: center;
            margin-top: 20px;
            color: rgba(255, 255, 255, 0.8);
        }

        .forgot-password a,
        .register-link a,
        .login-link a {
            color: #f472b6;
            text-decoration: none;
            font-weight: 600;
        }

        .forgot-password a:hover,
        .register-link a:hover,
        .login-link a:hover {
            color: #a78bfa;
            text-decoration: underline;
        }

        .avatar-preview {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin: 10px auto;
            display: block;
            border: 3px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>

<body>
<div class="loader" id="mainLoader">
    <svg width="60" height="60" viewBox="0 0 60 60">
        <circle cx="30" cy="30" r="24" stroke="#6366f1" stroke-width="6" fill="none" opacity="0.2" />
        <circle cx="30" cy="30" r="24" stroke="#f0abfc" stroke-width="6" fill="none" stroke-dasharray="120"
                stroke-dashoffset="60">
            <animateTransform attributeName="transform" type="rotate" from="0 30 30" to="360 30 30" dur="1s"
                              repeatCount="indefinite" />
        </circle>
    </svg>
</div>
<div class="toast-container" id="toastContainer"></div>
<div class="lux-header">
    <nav class="navbar navbar-expand-lg navbar-dark lux-navbar"
         style="background: linear-gradient(90deg, #a78bfa 60%, #fbcfe8 100%); box-shadow: 0 8px 32px rgba(124, 58, 237, 0.12);">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center gap-2"
               href="${pageContext.request.contextPath}/">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Logo"
                     style="width:36px;height:36px;">
                <span>Global Manager</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">
                                        <span style="display:inline-block;vertical-align:middle;">
                                            <!-- Home icon premium avec dégradé -->
                                            <svg width="24" height="24" viewBox="0 0 256 256" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg" style="vertical-align:middle;">
                                                <path d="M40 120L128 48L216 120" stroke="currentColor"
                                                      stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" />
                                                <rect x="80" y="152" width="96" height="56" rx="8" stroke="currentColor"
                                                      stroke-width="2.5" fill="none" />
                                                <path d="M56 120V208a8 8 0 0 0 8 8H192a8 8 0 0 0 8-8V120"
                                                      stroke="currentColor" stroke-width="2.5" fill="none" />
                                            </svg>
                                        </span>
                            Accueil
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/fournisseurs">
                                        <span style="display:inline-block;vertical-align:middle;">
                                            <!-- Truck icon moderne -->
                                            <svg width="24" height="24" fill="none" stroke="currentColor"
                                                 stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"
                                                 style="vertical-align:middle;">
                                                <rect x="1" y="7" width="12" height="8" rx="2" />
                                                <path d="M13 9h3l3 3v3a2 2 0 0 1-2 2h-1" />
                                                <circle cx="5.5" cy="17" r="1.5" />
                                                <circle cx="17.5" cy="17" r="1.5" />
                                            </svg>
                                        </span>
                            Fournisseurs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/factures">
                                        <span style="display:inline-block;vertical-align:middle;">
                                            <!-- File-text icon moderne -->
                                            <svg width="24" height="24" fill="none" stroke="currentColor"
                                                 stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"
                                                 style="vertical-align:middle;">
                                                <rect x="4" y="3" width="14" height="18" rx="2" />
                                                <line x1="8" y1="7" x2="16" y2="7" />
                                                <line x1="8" y1="11" x2="16" y2="11" />
                                                <line x1="8" y1="15" x2="12" y2="15" />
                                            </svg>
                                        </span>
                            Factures
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/commandes">
                                        <span style="display:inline-block;vertical-align:middle;">
                                            <!-- Shopping-cart icon moderne -->
                                            <svg width="24" height="24" fill="none" stroke="currentColor"
                                                 stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"
                                                 style="vertical-align:middle;">
                                                <circle cx="8.5" cy="19" r="1.5" />
                                                <circle cx="17.5" cy="19" r="1.5" />
                                                <path d="M2 3h2l.4 2M7 13h10l4-8H5.4" />
                                            </svg>
                                        </span>
                            Commandes
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item position-relative">
                                    <span class="notif-icon-wrapper" id="notifBell"
                                          style="position:relative;cursor:pointer;">
                                        <svg width="36" height="36" viewBox="0 0 48 48" fill="none"
                                             class="notif-bell-svg">
                                            <!-- Ondes gauche -->
                                            <path d="M4 24c0-7 5-13 12-15" stroke="#b388f9" stroke-width="2.2"
                                                  stroke-linecap="round" />
                                            <path d="M8 24c0-5 4-9 9-11" stroke="#d94690" stroke-width="2.2"
                                                  stroke-linecap="round" />
                                            <!-- Ondes droite -->
                                            <path d="M44 24c0-7-5-13-12-15" stroke="#b388f9" stroke-width="2.2"
                                                  stroke-linecap="round" />
                                            <path d="M40 24c0-5-4-9-9-11" stroke="#d94690" stroke-width="2.2"
                                                  stroke-linecap="round" />
                                            <!-- Cloche -->
                                            <path d="M36 20v-4a12 12 0 1 0-24 0v4c0 10-6 10-6 10h36s-6 0-6-10z"
                                                  stroke="#fff" stroke-width="2.5" fill="none" />
                                            <!-- Battant -->
                                            <circle cx="24" cy="38" r="3" fill="#fff" stroke="#b388f9"
                                                    stroke-width="2" />
                                            <!-- Badge rond au centre -->
                                            <circle cx="24" cy="22" r="7.5" fill="url(#notif-gradient)" stroke="#fff"
                                                    stroke-width="2.5" />
                                            <text x="24" y="27" text-anchor="middle" font-size="11"
                                                  font-family="Montserrat, Arial, sans-serif" fill="#a1006b"
                                                  font-weight="bold" id="notifBadgeText">1</text>
                                            <defs>
                                                <radialGradient id="notif-gradient" cx="0.5" cy="0.5" r="0.5">
                                                    <stop offset="0%" stop-color="#f7c1ff" />
                                                    <stop offset="100%" stop-color="#b388f9" />
                                                </radialGradient>
                                            </defs>
                                        </svg>
                                    </span>
                    </li>
                    <li class="nav-item">
                        <button class="dark-toggle" id="darkToggle" title="Mode sombre/clair"><i
                                class="fas fa-moon"></i></button>
                    </li>
                    <li class="nav-item">
                        <!-- Color picker supprimé -->
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#"
                           id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                           <img class="avatar" src="" alt="Photo de profil">
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li><a class="dropdown-item" href="#"><i class="fas fa-user"></i> Profil</a>
                            </li>
                            <li><a class="dropdown-item" href="#"><i class="fas fa-cog"></i> Paramètres</a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item text-danger" href="#"><i
                                    class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Messages Flash -->
    <div class="container mt-2">
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
    </div>
</div>
<div class="main-content">
    <div class="container lux glass-card">
        <jsp:include page="${contentPage}" />
    </div>
</div>
<footer class="lux-footer py-3 mt-5">
    <div class="container text-center">
        <span>© 2025 Gestion de Fournisseurs & Factures — <b>Global Manager</b></span>
    </div>
</footer>

<script>
    // Loader (simulate AJAX)
    window.addEventListener('DOMContentLoaded', function () {
        setTimeout(() => document.getElementById('mainLoader').classList.add('hidden'), 800);
    });
    // Toasts
    function showToast(msg, type = 'info') {
        const toast = document.createElement('div');
        toast.className = `toast align-items-center text-bg-${type} border-0 show mb-2`;
        toast.role = 'alert';
        toast.innerHTML = `<div class="d-flex"><div class="toast-body">${msg}</div><button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button></div>`;
        document.getElementById('toastContainer').appendChild(toast);
        setTimeout(() => toast.remove(), 4000);
    }
    // Dark mode toggle
    const darkToggle = document.getElementById('darkToggle');
    if (darkToggle) {
        darkToggle.addEventListener('click', function () {
            document.body.classList.toggle('dark-mode');
            localStorage.setItem('darkMode', document.body.classList.contains('dark-mode'));
        });
    }
    if (localStorage.getItem('darkMode') === 'true') {
        document.body.classList.add('dark-mode');
    }
    // Theme color picker
    const themePicker = document.getElementById('themePicker');
    if (themePicker) {
        themePicker.addEventListener('input', function () {
            document.documentElement.style.setProperty('--main-color', this.value);
            localStorage.setItem('mainColor', this.value);
        });
    }
    if (localStorage.getItem('mainColor')) {
        document.documentElement.style.setProperty('--main-color', localStorage.getItem('mainColor'));
        themePicker.value = localStorage.getItem('mainColor');
    }
    // Notifications dynamiques (mock)
    function loadNotifications() {
        // Simuler un appel AJAX
        setTimeout(() => {
            const notifs = [
                { type: 'primary', icon: 'info-circle', text: 'Nouvelle facture reçue' },
                { type: 'warning', icon: 'exclamation-triangle', text: 'Facture en retard' },
                { type: 'success', icon: 'check-circle', text: 'Commande livrée' }
            ];
            const notifMenu = document.getElementById('notifMenu');
            notifMenu.innerHTML = '';
            notifs.forEach(n => {
                notifMenu.innerHTML += `<li><a class='dropdown-item' href='#'><i class='fas fa-${n.icon} text-${n.type}'></i> ${n.text}</a></li>`;
            });
            document.getElementById('notifBadge').textContent = notifs.length;
        }, 1000);
    }
    document.getElementById('notifBell')?.addEventListener('click', loadNotifications);
    // Utilisateur dynamique (mock)
    function loadUser() {
        // Simuler un appel AJAX
        setTimeout(() => {
            document.getElementById('userName').textContent = 'Fatima Zahra';
            document.getElementById('userAvatar').src = 'images/img.png';
        }, 500);
    }
    loadUser();
    // Effet hover sur les lignes de tableau
    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('table tr').forEach(tr => {
            tr.addEventListener('mouseenter', () => tr.style.background = 'rgba(13,110,253,0.07)');
            tr.addEventListener('mouseleave', () => tr.style.background = '');
        });
    });
</script>
</body>

</html>