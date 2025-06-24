<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Management Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
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
            --success: #48bb78;
            --warning: #ed8936;
            --danger: #e53e3e;
            --info: #4299e1;
            --purple: #9f7aea;
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

        .section {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-lg);
            padding: 0;
            margin-bottom: 32px;
            overflow: hidden;
        }

        .section-header {
            background: linear-gradient(to right, rgba(156, 39, 176, 0.1), rgba(240, 98, 146, 0.05));
            padding: 20px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border-color);
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            font-weight: 600;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            gap: 12px;
            position: relative;
            padding-left: 15px;
        }

        .section-title::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 24px;
            background: linear-gradient(to bottom, var(--secondary-color), var(--accent-color));
            border-radius: 2px;
        }

        .section-title i {
            color: var(--accent-color);
        }

        .section-actions {
            display: flex;
            gap: 15px;
        }

        .section-content {
            padding: 20px 25px;
        }

        .search-bar {
            display: flex;
            position: relative;
        }

        .search-bar input {
            padding: 12px 15px 12px 40px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            width: 250px;
            font-family: 'Inter', sans-serif;
            background-color: var(--white);
            transition: all 0.3s ease;
        }

        .search-bar input:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(156, 39, 176, 0.1);
        }

        .search-bar i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }

        .filter-dropdown {
            position: relative;
        }

        .filter-dropdown select {
            padding: 12px 40px 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            background-color: var(--white);
            font-size: 14px;
            appearance: none;
            cursor: pointer;
            outline: none;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
            color: var(--text-dark);
        }

        .filter-dropdown select:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(156, 39, 176, 0.1);
        }

        .filter-dropdown::after {
            content: '\f0d7';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
            color: var(--text-muted);
        }

        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 0;
            font-size: 14px;
        }

        th, td {
            padding: 15px 16px;
            text-align: left;
        }

        th {
            background: linear-gradient(90deg, rgba(156, 39, 176, 0.05) 0%, rgba(240, 98, 146, 0.05) 100%);
            color: var(--primary-color);
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--border-color);
            white-space: nowrap;
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

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-badge::before {
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .status-pending {
            background-color: rgba(237, 137, 54, 0.1);
            color: var(--warning);
        }

        .status-pending::before {
            content: '\f017'; /* Clock icon */
        }

        .status-completed {
            background-color: rgba(72, 187, 120, 0.1);
            color: var(--success);
        }

        .status-completed::before {
            content: '\f00c'; /* Check icon */
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: var(--text-muted);
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 15px;
            opacity: 0.7;
            color: var(--accent-light);
        }

        .empty-state p {
            font-size: 16px;
            margin-bottom: 5px;
        }

        .empty-state p:last-child {
            font-size: 14px;
            opacity: 0.7;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
        }

        .btn-success {
            background: linear-gradient(90deg, var(--success), #6fcf97);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-success:disabled {
            background: linear-gradient(90deg, #a0aec0, #cbd5e0);
            color: var(--white);
            cursor: not-allowed;
            transform: none;
        }

        .btn-danger {
            background: linear-gradient(90deg, var(--danger), #f56565);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-info {
            background: linear-gradient(90deg, var(--info), var(--purple));
            color: white;
        }

        .btn-info:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-top: 25px;
            margin-bottom: 5px;
        }

        .pagination-item {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            background-color: var(--white);
            border: 1px solid var(--border-color);
            color: var(--text-dark);
            font-weight: 500;
        }

        .pagination-item:hover {
            background-color: rgba(156, 39, 176, 0.1);
            border-color: rgba(156, 39, 176, 0.2);
        }

        .pagination-item.active {
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            color: white;
            border-color: transparent;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: var(--white);
            border-radius: 12px;
            padding: 0;
            width: 100%;
            max-width: 500px;
            box-shadow: var(--shadow-xl);
            position: relative;
            overflow: hidden;
            animation: modalFadeIn 0.3s ease;
        }

        @keyframes modalFadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .modal-header {
            padding: 20px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(to right, rgba(156, 39, 176, 0.1), rgba(240, 98, 146, 0.05));
            border-bottom: 1px solid var(--border-color);
        }

        .modal-title {
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            font-weight: 600;
            color: var(--primary-color);
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: var(--text-muted);
            transition: all 0.3s ease;
        }

        .modal-close:hover {
            color: var(--danger);
        }

        .modal-body {
            padding: 25px;
        }

        .modal-body p {
            margin-bottom: 15px;
        }

        .modal-body strong {
            color: var(--primary-color);
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            padding: 15px 25px 25px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-primary {
            background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-light {
            background-color: #f3f4f6;
            color: var(--text-dark);
        }

        .btn-light:hover {
            background-color: #e5e7eb;
            transform: translateY(-2px);
        }

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
                gap: 15px;
            }

            .section-actions {
                width: 100%;
                flex-direction: column;
                gap: 10px;
            }

            .search-bar {
                width: 100%;
            }

            .search-bar input {
                width: 100%;
            }

            .filter-dropdown {
                width: 100%;
            }

            .filter-dropdown select {
                width: 100%;
            }

            .action-buttons {
                flex-direction: column;
                width: 100%;
            }

            .action-btn {
                width: 100%;
                justify-content: center;
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
                <a href="${pageContext.request.contextPath}/admin/payments" class="nav-link active">
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
                <h1>Payment Management</h1>
                <p>Process and manage all client payments</p>
            </div>
            <div class="user-section">
                <div class="admin-avatar">A</div>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <!-- Card Payments Section -->
        <div class="section">
            <div class="section-header">
                <div class="section-title">
                    <i class="fas fa-credit-card"></i> Card Payments
                </div>

                <div class="section-actions">
                    <div class="search-bar">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Search by ID or amount..." id="card-search">
                    </div>

                    <div class="filter-dropdown">
                        <select id="card-filter">
                            <option value="all">All Dates</option>
                            <option value="today">Today</option>
                            <option value="week">This Week</option>
                            <option value="month">This Month</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table id="cardPaymentsTable">
                    <thead>
                    <tr>
                        <th>Payment ID</th>
                        <th>Appointment ID</th>
                        <th>Amount</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${cardPayments}" var="payment">
                        <tr>
                            <td>${payment.id}</td>
                            <td>${payment.appointmentId}</td>
                            <td>₹<fmt:formatNumber value="${payment.amount}" pattern="#,##0.00"/></td>
                            <td>${payment.formattedPaymentDate}</td>
                            <td>
            <span class="status-badge status-completed">
                    ${payment.status}
            </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button type="button" onclick="generatePDF(this)" class="action-btn btn-info">
                                        <i class="fas fa-file-pdf"></i> Receipt
                                    </button>
                                    <button type="button" onclick="confirmDelete('${payment.id}')" class="action-btn btn-danger">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty cardPayments}">
                        <tr>
                            <td colspan="6">
                                <div class="empty-state">
                                    <i class="fas fa-credit-card"></i>
                                    <p>No card payments found</p>
                                    <p>Card payments will appear here after processing</p>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>

            <div class="pagination">
                <div class="pagination-item"><i class="fas fa-chevron-left"></i></div>
                <div class="pagination-item active">1</div>
                <div class="pagination-item">2</div>
                <div class="pagination-item">3</div>
                <div class="pagination-item"><i class="fas fa-chevron-right"></i></div>
            </div>
        </div>

        <!-- Cash Payments Section -->
        <div class="section">
            <div class="section-header">
                <div class="section-title">
                    <i class="fas fa-money-bill-wave"></i> Cash Payments
                </div>

                <div class="section-actions">
                    <div class="search-bar">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Search by ID or amount..." id="cash-search">
                    </div>

                    <div class="filter-dropdown">
                        <select id="cash-filter">
                            <option value="all">All Status</option>
                            <option value="pending">Pending</option>
                            <option value="completed">Completed</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table id="cashPaymentsTable">
                    <thead>
                    <tr>
                        <th>Payment ID</th>
                        <th>Appointment ID</th>
                        <th>Amount</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${cashPayments}" var="payment">
                        <tr>
                            <td>${payment.id}</td>
                            <td>${payment.appointmentId}</td>
                            <td>₹<fmt:formatNumber value="${payment.amount}" pattern="#,##0.00"/></td>
                            <td>${payment.formattedPaymentDate}</td>
                            <td>
            <span class="status-badge ${payment.status == 'PENDING' ? 'status-pending' : 'status-completed'}">
                    ${payment.status}
            </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <c:if test="${payment.status == 'PENDING'}">
                                        <button type="button" onclick="confirmMarkAsPaid('${payment.id}')" class="action-btn btn-success">
                                            <i class="fas fa-check"></i> Mark Paid
                                        </button>
                                    </c:if>
                                    <c:if test="${payment.status == 'COMPLETED'}">
                                        <button class="action-btn btn-success" disabled>
                                            <i class="fas fa-check-circle"></i> Paid
                                        </button>
                                    </c:if>
                                    <button type="button" onclick="generatePDF(this)" class="action-btn btn-info">
                                        <i class="fas fa-file-pdf"></i> Receipt
                                    </button>
                                    <button type="button" onclick="confirmDelete('${payment.id}')" class="action-btn btn-danger">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty cashPayments}">
                        <tr>
                            <td colspan="6">
                                <div class="empty-state">
                                    <i class="fas fa-money-bill-wave"></i>
                                    <p>No cash payments found</p>
                                    <p>Cash payments will appear here once created</p>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>



            <div class="pagination">
                <div class="pagination-item"><i class="fas fa-chevron-left"></i></div>
                <div class="pagination-item active">1</div>
                <div class="pagination-item">2</div>
                <div class="pagination-item">3</div>
                <div class="pagination-item"><i class="fas fa-chevron-right"></i></div>
            </div>
        </div>


    </div>
</div>

<!-- Mark as Paid Confirmation Modal -->
<div id="markAsPaidModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <div class="modal-title">Confirm Payment</div>
            <button class="modal-close" onclick="closeModal('markAsPaidModal')">&times;</button>
        </div>
        <div class="modal-body">
            <p>Are you sure you want to mark this payment as paid?</p>
            <p>Payment ID: <strong id="paymentIdToMark"></strong></p>
        </div>
        <div class="modal-footer">
            <button onclick="closeModal('markAsPaidModal')" class="btn btn-light">
                <i class="fas fa-times"></i> Cancel
            </button>
            <form method="post" action="${pageContext.request.contextPath}/admin/mark-as-paid" id="markAsPaidForm">
                <input type="hidden" name="paymentId" id="markAsPaidInput" value="">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-check"></i> Confirm
                </button>
            </form>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <div class="modal-title">Confirm Deletion</div>
            <button class="modal-close" onclick="closeModal('deleteModal')">&times;</button>
        </div>
        <div class="modal-body">
            <p>Are you sure you want to delete this payment? This action cannot be undone.</p>
            <p>Payment ID: <strong id="paymentIdToDelete"></strong></p>
        </div>
        <div class="modal-footer">
            <button onclick="closeModal('deleteModal')" class="btn btn-light">
                <i class="fas fa-times"></i> Cancel
            </button>
            <form method="post" action="${pageContext.request.contextPath}/admin/delete-payment" id="deleteForm">
                <input type="hidden" name="paymentId" id="deleteInput" value="">
                <button type="submit" class="btn btn-danger">
                    <i class="fas fa-trash"></i> Delete
                </button>
            </form>
        </div>
    </div>
</div>

<script>
    // Table search functionality
    document.getElementById('cash-search').addEventListener('keyup', function() {
        searchTable('cashPaymentsTable', this.value);
    });

    document.getElementById('card-search').addEventListener('keyup', function() {
        searchTable('cardPaymentsTable', this.value);
    });

    function searchTable(tableId, query) {
        const table = document.getElementById(tableId);
        const rows = table.getElementsByTagName('tr');

        query = query.toLowerCase();

        for (let i = 1; i < rows.length; i++) {
            const row = rows[i];
            let match = false;

            const cells = row.getElementsByTagName('td');
            if (cells.length === 0) continue; // Skip if no cells (like in empty state)

            for (let j = 0; j < cells.length; j++) {
                if (cells[j].textContent.toLowerCase().indexOf(query) > -1) {
                    match = true;
                    break;
                }
            }

            row.style.display = match ? '' : 'none';
        }
    }

    // Filter functionality
    document.getElementById('cash-filter').addEventListener('change', function() {
        filterTableByStatus('cashPaymentsTable', this.value);
    });

    function filterTableByStatus(tableId, status) {
        const table = document.getElementById(tableId);
        const rows = table.getElementsByTagName('tr');

        for (let i = 1; i < rows.length; i++) {
            const row = rows[i];
            const statusCell = row.cells[4];

            if (!statusCell) continue; // Skip if no status cell

            const rowStatus = statusCell.textContent.trim().toLowerCase();

            if (status === 'all' || (status === 'pending' && rowStatus.includes('pending'))
                || (status === 'completed' && rowStatus.includes('completed'))) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        }
    }

    // Modal functionality
    function confirmMarkAsPaid(paymentId) {
        document.getElementById('paymentIdToMark').textContent = paymentId;
        document.getElementById('markAsPaidInput').value = paymentId;
        openModal('markAsPaidModal');
    }

    function confirmDelete(paymentId) {
        document.getElementById('paymentIdToDelete').textContent = paymentId;
        document.getElementById('deleteInput').value = paymentId;
        openModal('deleteModal');
    }

    function openModal(modalId) {
        document.getElementById(modalId).style.display = 'flex';
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none';
        }
    };

    // PDF generator
    function generatePDF(button) {
        try {
            const { jsPDF } = window.jspdf;
            const row = button.closest('tr');

            const id = row.cells[0].innerText;
            const appointmentId = row.cells[1].innerText;
            const amount = row.cells[2].innerText;
            const date = row.cells[3].innerText;
            const status = row.cells[4].textContent.trim();
            const paymentType = row.closest('table').id === 'cashPaymentsTable' ? 'Cash' : 'Card';

            // Create new PDF
            const doc = new jsPDF();

            // Add styling and header
            doc.setFillColor(45, 27, 78);
            doc.rect(0, 0, 210, 30, 'F');

            doc.setTextColor(255, 255, 255);
            doc.setFontSize(22);
            doc.text("ELEGANT BEAUTY SALON", 105, 15, { align: 'center' });
            doc.setFontSize(16);
            doc.text("PAYMENT RECEIPT", 105, 25, { align: 'center' });

            // Add receipt content
            doc.setTextColor(0, 0, 0);
            doc.setFontSize(12);

            // Add receipt details
            doc.setFontSize(14);
            doc.setTextColor(156, 39, 176);
            doc.text("Payment Details", 105, 50, { align: 'center' });

            doc.setDrawColor(220, 220, 220);
            doc.line(20, 55, 190, 55);

            doc.setFontSize(11);
            doc.setTextColor(0, 0, 0);

            const startY = 70;
            const lineHeight = 10;

            doc.text("Payment ID:", 20, startY);
            doc.text(id, 80, startY);

            doc.text("Appointment ID:", 20, startY + lineHeight);
            doc.text(appointmentId, 80, startY + lineHeight);

            doc.text("Amount:", 20, startY + 2 * lineHeight);
            doc.text(amount, 80, startY + 2 * lineHeight);

            doc.text("Date:", 20, startY + 3 * lineHeight);
            doc.text(date, 80, startY + 3 * lineHeight);

            doc.text("Payment Method:", 20, startY + 4 * lineHeight);
            doc.text(paymentType, 80, startY + 4 * lineHeight);

            doc.text("Status:", 20, startY + 5 * lineHeight);

            // Style the status text
            if (status.includes("PENDING")) {
                doc.setTextColor(237, 137, 54);
            } else {
                doc.setTextColor(72, 187, 120);
            }
            doc.text(status, 80, startY + 5 * lineHeight);

            // Add pending message if needed
            if (status.includes("PENDING")) {
                doc.setFillColor(255, 243, 224);
                doc.roundedRect(20, startY + 6 * lineHeight, 170, 15, 2, 2, 'F');
                doc.setTextColor(237, 137, 54);
                doc.text("Note: Please pay cash at the salon during your appointment.", 25, startY + 7 * lineHeight);
            }

            // Add thank you message
            doc.setTextColor(0, 0, 0);
            doc.setFontSize(12);
            doc.text("Thank you for choosing Elegant Beauty Salon!", 105, 150, { align: 'center' });

            // Add footer
            doc.setFillColor(245, 245, 245);
            doc.rect(0, 270, 210, 30, 'F');

            doc.setTextColor(100, 100, 100);
            doc.setFontSize(9);
            const footerText = "This is an electronically generated receipt. No signature required.";
            doc.text(footerText, 105, 280, { align: 'center' });
            doc.text("For any inquiries, please contact our customer service.", 105, 285, { align: 'center' });

            // Save the PDF
            doc.save("Receipt_" + id + ".pdf");
        } catch (error) {
            console.error("Error generating PDF:", error);
            alert("Error generating PDF. Please check console for details.");
        }
    }
</script>
</body>
</html>

