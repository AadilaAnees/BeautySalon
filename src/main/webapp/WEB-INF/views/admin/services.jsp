<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Services - Salon Booking System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

        .header-title h1 {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-color);
            font-family: 'Playfair Display', serif;
        }

        .header-title p {
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
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .container {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-md);
            padding: 24px;
            margin-bottom: 32px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            position: relative;
            padding-left: 16px;
        }

        .section-header h2 {
            font-family: 'Playfair Display', serif;
            font-weight: 600;
            color: var(--primary-color);
            position: relative;
        }

        .section-header h2::before {
            content: '';
            position: absolute;
            left: -16px;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 24px;
            background: linear-gradient(to bottom, var(--secondary-color), var(--accent-color));
            border-radius: 2px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            color: var(--white);
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
            box-shadow: var(--shadow-sm);
            border: none;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background: linear-gradient(90deg, var(--blue-500) 0%, var(--purple-500) 100%);
        }

        .btn-danger {
            background: linear-gradient(90deg, var(--red-500) 0%, #f56565 100%);
        }

        .alert {
            padding: 16px;
            margin-bottom: 24px;
            border-radius: 8px;
            font-weight: 500;
            box-shadow: var(--shadow-sm);
            position: relative;
            padding-left: 50px;
        }

        .alert::before {
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
        }

        .alert-success {
            background-color: rgba(72, 187, 120, 0.1);
            color: var(--green-500);
            border-left: 4px solid var(--green-500);
        }

        .alert-success::before {
            content: '\f058'; /* Check circle icon */
            color: var(--green-500);
        }

        .alert-danger {
            background-color: rgba(229, 62, 62, 0.1);
            color: var(--red-500);
            border-left: 4px solid var(--red-500);
        }

        .alert-danger::before {
            content: '\f057'; /* Times circle icon */
            color: var(--red-500);
        }

        /* Enhanced Table Styles */
        .table-container {
            overflow-x: auto;
            border-radius: 8px;
            box-shadow: var(--shadow-sm);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            /* Removed fixed table layout */
        }

        th, td {
            padding: 16px;
            text-align: left;
        }

        th {
            background: linear-gradient(90deg, rgba(156, 39, 176, 0.05) 0%, rgba(240, 98, 146, 0.05) 100%);
            color: var(--primary-color);
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--border-color);
        }

        tr:not(:last-child) td {
            border-bottom: 1px solid var(--border-color);
        }

        tr {
            transition: all 0.3s ease;
        }

        tr:hover {
            background-color: rgba(156, 39, 176, 0.03);
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        /* Updated column widths */
        th:nth-child(1), td:nth-child(1) { width: 5%; min-width: 50px; } /* ID */
        th:nth-child(2), td:nth-child(2) { width: 15%; min-width: 150px; } /* Name */
        th:nth-child(3), td:nth-child(3) { width: 8%; min-width: 80px; } /* Price */
        th:nth-child(4), td:nth-child(4) { width: 8%; min-width: 80px; } /* Duration */
        th:nth-child(5), td:nth-child(5) { width: 30%; min-width: 200px; } /* Description */
        th:nth-child(6), td:nth-child(6) { width: 9%; min-width: 100px; } /* Category */
        th:nth-child(7), td:nth-child(7) { width: 25%; min-width: 220px; } /* Actions - increased width */

        /* Description cell with fancy tooltip */
        .description-cell {
            position: relative;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            cursor: pointer;
        }

        .description-tooltip {
            visibility: hidden;
            opacity: 0;
            position: absolute;
            left: 0;
            top: calc(100% + 10px);
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            box-shadow: var(--shadow-lg);
            z-index: 100;
            width: 300px;
            max-height: 200px;
            overflow-y: auto;
            white-space: normal;
            word-break: break-word;
            transition: all 0.3s ease;
            font-size: 14px;
            line-height: 1.5;
        }

        .description-cell:hover .description-tooltip {
            visibility: visible;
            opacity: 1;
        }

        .description-tooltip::before {
            content: '';
            position: absolute;
            top: -10px;
            left: 20px;
            border-width: 0 10px 10px 10px;
            border-style: solid;
            border-color: transparent transparent var(--primary-color) transparent;
        }

        /* Ensure all cells contain their content */
        td {
            max-width: 100%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        /* Service price styling */
        .price-cell {
            font-weight: 600;
            color: var(--accent-color);
        }

        /* Duration styling */
        .duration-cell {
            color: var(--secondary-color);
            font-weight: 500;
        }

        /* Category styling */
        .category-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            background-color: rgba(156, 39, 176, 0.1);
            color: var(--secondary-color);
        }

        /* Updated Actions column styling */
        .actions {
            white-space: nowrap;
            display: flex;
            gap: 8px;
            flex-wrap: wrap; /* Allow buttons to wrap if needed */
        }

        .actions a {
            padding: 8px 12px;
            font-size: 13px;
            /* Ensure minimum width for buttons */
            min-width: 80px;
            text-align: center;
            justify-content: center;
        }

        .empty-row {
            text-align: center;
            padding: 40px 0;
            color: var(--text-muted);
            font-style: italic;
        }

        /* Responsive styles */
        @media (max-width: 1200px) {
            .main-content {
                padding: 20px;
            }
        }

        @media (max-width: 992px) {
            .sidebar {
                width: 70px;
            }

            .sidebar-header {
                padding: 16px 0;
                display: flex;
                justify-content: center;
            }

            .logo {
                font-size: 0;
            }

            .logo::before {
                margin: 0;
            }

            .nav-link span {
                display: none;
            }

            .nav-link {
                justify-content: center;
                padding: 12px;
            }

            .main-content {
                margin-left: 70px;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 16px;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }

            .user-section {
                align-self: flex-end;
            }

            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }

            .section-header .btn {
                align-self: flex-start;
            }

            /* For very small screens, stack action buttons vertically */
            .actions {
                flex-direction: column;
                width: 100%;
            }

            .actions a {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-wrapper">
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="logo">Salon Booking System</div>
        </div>
        <nav class="nav-menu">
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">
                    <div class="nav-icon">📊</div>
                    <span>Dashboard</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/services" class="nav-link active">
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
                <a href="${pageContext.request.contextPath}/admin/user-dashboard" class="nav-link">
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
            <div class="header-title">
                <h1>Manage Services</h1>
                <p>View, add, edit or delete salon services</p>
            </div>
            <div class="user-section">
                <div class="admin-avatar">A</div>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="container">
            <div class="section-header">
                <h2>Service Catalog</h2>
                <a href="${pageContext.request.contextPath}/admin/service/add" class="btn">
                    <i class="fas fa-plus"></i> Add New Service
                </a>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Duration</th>
                        <th>Description</th>
                        <th>Category</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${services}" var="service">
                        <tr>
                            <td>${service.id}</td>
                            <td title="${service.name}">${service.name}</td>
                            <td class="price-cell">$${service.price}</td>
                            <td class="duration-cell">${service.durationMinutes} min</td>
                            <td class="description-cell">
                                    ${service.description.length() > 30 ? service.description.substring(0, 30).concat('...') : service.description}
                                <div class="description-tooltip">${service.description}</div>
                            </td>
                            <td><span class="category-badge">${service.category}</span></td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/service/edit/${service.id}" class="btn btn-secondary">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/service/delete/${service.id}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this service?')">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty services}">
                        <tr>
                            <td colspan="7" class="empty-row">
                                <i class="fas fa-spa fa-2x" style="margin-bottom: 15px; color: var(--text-muted);"></i>
                                <p>No services found</p>
                                <p style="font-size: 14px; margin-top: 10px;">Click "Add New Service" to create your first service</p>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>