<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users - Elegant Beauty Salon</title>
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

        .welcome-section h1 {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-color);
            font-family: 'Playfair Display', serif;
        }

        .welcome-section p {
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

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            color: var(--primary-color);
            position: relative;
            padding-bottom: 8px;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--accent-color) 0%, var(--secondary-color) 100%);
        }

        .add-btn {
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            color: var(--white);
            padding: 8px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: var(--shadow-md);
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .add-btn span {
            font-size: 20px;
            line-height: 1;
        }

        .card {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 30px;
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        .card-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border-color);
            background: linear-gradient(90deg, rgba(156, 39, 176, 0.05) 0%, rgba(240, 98, 146, 0.05) 100%);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-title {
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            font-weight: 600;
            color: var(--primary-color);
            margin: 0;
        }

        .card-content {
            padding: 0;
        }

        .alert {
            padding: 16px 24px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 500;
        }

        .alert-success {
            background-color: rgba(72, 187, 120, 0.1);
            color: var(--green-500);
            border-left: 4px solid var(--green-500);
        }

        .alert-danger {
            background-color: rgba(229, 62, 62, 0.1);
            color: var(--red-500);
            border-left: 4px solid var(--red-500);
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: rgba(156, 39, 176, 0.05);
            color: var(--text-dark);
            font-weight: 600;
            text-align: left;
            padding: 16px 24px;
            font-size: 14px;
        }

        td {
            padding: 16px 24px;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-light);
        }

        tbody tr:hover {
            background-color: rgba(240, 98, 146, 0.05);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .empty-message {
            text-align: center;
            padding: 40px 0;
            color: var(--text-muted);
            font-style: italic;
        }

        .action-links {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.3s ease;
        }

        .btn-edit {
            background-color: rgba(156, 39, 176, 0.1);
            color: var(--secondary-color);
        }

        .btn-edit:hover {
            background-color: rgba(156, 39, 176, 0.2);
        }

        .btn-delete {
            background-color: rgba(229, 62, 62, 0.1);
            color: var(--red-500);
        }

        .btn-delete:hover {
            background-color: rgba(229, 62, 62, 0.2);
        }

        .user-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .badge-admin {
            background-color: rgba(156, 39, 176, 0.1);
            color: var(--secondary-color);
        }

        .badge-client {
            background-color: rgba(240, 98, 146, 0.1);
            color: var(--accent-color);
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

            .table-container {
                overflow-x: auto;
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
            <div class="welcome-section">
                <h1>User Management</h1>
                <p>View and manage all users of the Elegant Beauty Salon</p>
            </div>
            <div class="user-section">
                <div class="admin-avatar">A</div>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            </div>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="section-header">
            <h2 class="section-title">User Overview</h2>
            <a href="${pageContext.request.contextPath}/admin/user/add" class="add-btn">
                <span>+</span> Add New User
            </a>
        </div>

        <!-- Clients Section -->
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Clients</h3>
                <div class="client-count">
                    <span class="badge-client user-badge">${clients.size()} Total</span>
                </div>
            </div>
            <div class="card-content">
                <div class="table-container">
                    <table>
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${clients}" var="client">
                            <tr>
                                <td>#${client.id}</td>
                                <td>${client.username}</td>
                                <td>${client.email}</td>
                                <td>${client.phone != null ? client.phone : 'Not provided'}</td>
                                <td><span class="badge-client user-badge">Client</span></td>
                                <td class="action-links">
                                    <a href="${pageContext.request.contextPath}/admin/user/edit/${client.id}" class="btn btn-edit">
                                        <span>✏️</span> Edit
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/user/delete/${client.id}" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this client?')">
                                        <span>🗑️</span> Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty clients}">
                            <tr>
                                <td colspan="6" class="empty-message">No clients found</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Admins Section -->
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Administrators</h3>
                <div class="admin-count">
                    <span class="badge-admin user-badge">${admins.size()} Total</span>
                </div>
            </div>
            <div class="card-content">
                <div class="table-container">
                    <table>
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${admins}" var="admin">
                            <tr>
                                <td>#${admin.id}</td>
                                <td>${admin.username}</td>
                                <td>${admin.email}</td>
                                <td>${admin.phone != null ? admin.phone : 'Not provided'}</td>
                                <td><span class="badge-admin user-badge">Admin</span></td>
                                <td class="action-links">
                                    <a href="${pageContext.request.contextPath}/admin/user/edit/${admin.id}" class="btn btn-edit">
                                        <span>✏️</span> Edit
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/user/delete/${admin.id}" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this admin?')">
                                        <span>🗑️</span> Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty admins}">
                            <tr>
                                <td colspan="6" class="empty-message">No administrators found</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>