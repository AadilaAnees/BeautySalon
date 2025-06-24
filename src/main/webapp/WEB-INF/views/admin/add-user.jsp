<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add User - Elegant Beauty Salon</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2d1b4e;
            --primary-dark: #1a0f2e;
            --secondary-color: #9c27b0;
            --accent-color: #f06292;
            --accent-light: #f8bbd0;
            --text-dark: #2d2d2d;
            --text-light: #757575;
            --text-muted: #a0aec0;
            --background: #f8f9fa;
            --white: #ffffff;
            --border-color: #e2e8f0;
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            --red-500: #e53e3e;
            --green-500: #48bb78;
            --blue-500: #4299e1;
            --orange-500: #ed8936;
            --purple-500: #9f7aea;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--background);
            color: var(--text-dark);
            line-height: 1.6;
            min-height: 100vh;
        }

        .dashboard-wrapper {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: var(--white);
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100vh;
            transition: all 0.3s ease;
            z-index: 10;
        }

        .sidebar-header {
            padding: 24px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logo {
            font-size: 24px;
            font-weight: 800;
            font-family: 'Playfair Display', serif;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo::before {
            content: "●";
            color: var(--accent-color);
            font-size: 28px;
        }

        .nav-menu {
            flex: 1;
            padding: 16px;
        }

        .nav-item {
            margin-bottom: 8px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 16px;
            color: var(--white);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-weight: 500;
            gap: 12px;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .nav-link.active {
            background: linear-gradient(90deg, var(--accent-color) 0%, var(--secondary-color) 100%);
            font-weight: 600;
        }

        .nav-icon {
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 32px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .page-title h1 {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-color);
            font-family: 'Playfair Display', serif;
        }

        .page-title p {
            color: var(--text-light);
            margin-top: 4px;
        }

        .user-section {
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .admin-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-weight: 600;
            font-size: 16px;
        }

        .logout-btn {
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            color: var(--white);
            padding: 8px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            box-shadow: var(--shadow-md);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .content-card {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-md);
            padding: 30px;
            max-width: 700px;
            margin: 0 auto;
            border: 1px solid var(--border-color);
        }

        .card-header {
            margin-bottom: 30px;
            position: relative;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-color);
        }

        .card-title {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            color: var(--primary-color);
            font-weight: 600;
        }

        .alert {
            padding: 16px;
            margin-bottom: 24px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
        }

        .alert-danger {
            background-color: rgba(229, 62, 62, 0.1);
            color: var(--red-500);
            border-left: 4px solid var(--red-500);
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 0;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-dark);
            font-size: 14px;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="tel"],
        select {
            width: 100%;
            padding: 12px 16px;
            background-color: var(--background);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 15px;
            color: var(--text-dark);
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
        }

        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus,
        input[type="tel"]:focus,
        select:focus {
            outline: none;
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(156, 39, 176, 0.1);
        }

        select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%232d1b4e' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            background-size: 16px;
            padding-right: 40px;
        }

        .role-options {
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }

        .role-option {
            flex: 1;
            text-align: center;
            padding: 15px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .role-option:hover {
            background-color: rgba(156, 39, 176, 0.05);
        }

        .role-option.active {
            border-color: var(--secondary-color);
            background-color: rgba(156, 39, 176, 0.1);
        }

        .role-icon {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .role-name {
            font-weight: 600;
            color: var(--text-dark);
        }

        .role-description {
            font-size: 12px;
            color: var(--text-light);
            margin-top: 5px;
        }

        .buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            font-size: 15px;
            font-family: 'Inter', sans-serif;
            text-decoration: none;
            text-align: center;
            box-shadow: var(--shadow-sm);
        }

        .btn-primary {
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            color: var(--white);
            flex: 1;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background-color: var(--background);
            color: var(--text-dark);
            border: 1px solid var(--border-color);
        }

        .btn-secondary:hover {
            background-color: var(--border-color);
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
            }

            .sidebar-header {
                padding: 16px;
            }

            .logo {
                font-size: 0;
                justify-content: center;
            }

            .logo::before {
                font-size: 24px;
            }

            .nav-link {
                padding: 12px;
                justify-content: center;
            }

            .nav-link span {
                display: none;
            }

            .main-content {
                margin-left: 70px;
                padding: 20px;
            }

            .form-row {
                flex-direction: column;
                gap: 24px;
            }

            .role-options {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-wrapper">
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="logo">Elegant Beauty Salon</div>
        </div>
        <nav class="nav-menu">
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">
                    <div class="nav-icon">📊</div>
                    <span>Dashboard</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/services" class="nav-link">
                    <div class="nav-icon">✂️</div>
                    <span>Services</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/appointments" class="nav-link">
                    <div class="nav-icon">📅</div>
                    <span>Appointments</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/payments" class="nav-link">
                    <div class="nav-icon">💰</div>
                    <span>Payments</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/user-dashboard" class="nav-link active">
                    <div class="nav-icon">👥</div>
                    <span>Users</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/reviews" class="nav-link">
                    <div class="nav-icon">⭐</div>
                    <span>Reviews</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/reports" class="nav-link">
                    <div class="nav-icon">📈</div>
                    <span>Reports</span>
                </a>
            </div>
        </nav>
    </div>

    <div class="main-content">
        <div class="header">
            <div class="page-title">
                <h1>Add New User</h1>
                <p>Create a new user account for the salon system</p>
            </div>
            <div class="user-section">
                <div class="admin-avatar">A</div>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            </div>
        </div>

        <div class="content-card">
            <div class="card-header">
                <h2 class="card-title">User Information</h2>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/user/add" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" placeholder="Enter username" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter password" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" placeholder="Enter email address" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" placeholder="Enter phone number" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Select User Role</label>
                    <div class="role-options">
                        <div class="role-option active" onclick="selectRole('CLIENT')">
                            <div class="role-icon">👤</div>
                            <div class="role-name">Client</div>
                            <div class="role-description">Can book appointments and manage personal profile</div>
                        </div>
                        <div class="role-option" onclick="selectRole('ADMIN')">
                            <div class="role-icon">👑</div>
                            <div class="role-name">Administrator</div>
                            <div class="role-description">Full access to manage salon system and users</div>
                        </div>
                    </div>
                    <input type="hidden" id="role" name="role" value="CLIENT">
                </div>

                <div class="buttons">
                    <button type="submit" class="btn btn-primary">Create User</button>
                    <a href="${pageContext.request.contextPath}/admin/user-dashboard" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function selectRole(role) {
        document.getElementById('role').value = role;
        const options = document.querySelectorAll('.role-option');
        options.forEach(option => {
            option.classList.remove('active');
        });

        if (role === 'CLIENT') {
            options[0].classList.add('active');
        } else {
            options[1].classList.add('active');
        }
    }
</script>
</body>
</html>