<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Elegant Beauty Salon</title>
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

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 24px;
            margin-bottom: 24px;
        }

        .dashboard-card {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .card-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(90deg, rgba(156, 39, 176, 0.05) 0%, rgba(240, 98, 146, 0.05) 100%);
        }

        .card-header h2, .card-header h3 {
            font-family: 'Playfair Display', serif;
            font-weight: 600;
            color: var(--primary-color);
            margin: 0;
        }

        .card-content {
            padding: 24px;
        }

        .dashboard-widgets {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 24px;
        }

        .widget {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
            padding: 24px;
            text-align: center;
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .widget:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .widget::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--accent-color) 0%, var(--secondary-color) 100%);
        }

        .widget-value {
            font-size: 36px;
            font-weight: bold;
            margin: 15px 0;
            font-family: 'Playfair Display', serif;
        }

        .widget-title {
            color: var(--text-light);
            margin-bottom: 10px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 14px;
        }

        .widget-today {
            color: var(--secondary-color);
        }

        .widget-pending {
            color: var(--orange-500);
        }

        .widget-confirmed {
            color: var(--green-500);
        }

        .widget-link {
            display: inline-block;
            margin-top: 10px;
            color: var(--accent-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .widget-link:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }

        .today-appointments {
            margin-top: 15px;
        }

        .appointment-item {
            padding: 16px;
            border-bottom: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .appointment-item:last-child {
            border-bottom: none;
        }

        .appointment-item:hover {
            background-color: rgba(156, 39, 176, 0.05);
        }

        .appointment-time {
            font-weight: bold;
            color: var(--secondary-color);
        }

        .appointment-client {
            font-weight: 600;
            color: var(--text-dark);
        }

        .appointment-service {
            color: var(--text-light);
            margin: 5px 0;
        }

        .appointment-status {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            margin-left: 5px;
        }

        .status-pending {
            background-color: rgba(237, 137, 54, 0.15);
            color: var(--orange-500);
        }

        .status-confirmed {
            background-color: rgba(72, 187, 120, 0.15);
            color: var(--green-500);
        }

        .status-cancelled {
            background-color: rgba(229, 62, 62, 0.15);
            color: var(--red-500);
        }

        .status-completed {
            background-color: rgba(66, 153, 225, 0.15);
            color: var(--blue-500);
        }

        .status-actions {
            margin-top: 12px;
            display: flex;
            gap: 8px;
        }

        .status-btn {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
            background-color: var(--background);
            color: var(--text-dark);
            border: none;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .status-btn:hover {
            background-color: var(--border-color);
        }

        .confirm-btn {
            background-color: var(--green-500);
            color: white;
        }

        .confirm-btn:hover {
            background-color: #3da066;
        }

        .complete-btn {
            background-color: var(--blue-500);
            color: white;
        }

        .complete-btn:hover {
            background-color: #3282c9;
        }

        .cancel-btn {
            background-color: var(--red-500);
            color: white;
        }

        .cancel-btn:hover {
            background-color: #c53030;
        }

        .btn {
            display: inline-block;
            padding: 10px 24px;
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            box-shadow: var(--shadow-md);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .empty-message {
            color: var(--text-muted);
            font-style: italic;
            text-align: center;
            padding: 30px 0;
        }
        /* Chart styles */
        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }

        .chart-filters {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
            gap: 10px;
        }

        .chart-filter {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            border: 1px solid var(--border-color);
            background-color: var(--white);
            color: var(--text-light);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .chart-filter.active {
            background-color: var(--primary-color);
            color: var(--white);
            border-color: var(--primary-color);
        }

        .chart-legend {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 20px;
        }

        .legend-item {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: var(--text-light);
        }

        .legend-color {
            width: 16px;
            height: 16px;
            border-radius: 4px;
            margin-right: 8px;
        }

        .legend-color.primary {
            background-color: rgba(156, 39, 176, 0.7);
        }

        .legend-color.secondary {
            background-color: rgba(240, 98, 146, 0.7);
        }

        @media (max-width: 1200px) {
            .dashboard-widgets {
                grid-template-columns: repeat(2, 1fr);
            }
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

            .dashboard-widgets {
                grid-template-columns: 1fr;
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
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link active">
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
            <div class="welcome-section">
                <h1>Welcome back, Admin</h1>
                <p>Manage your salon operations from this dashboard</p>
            </div>
            <div class="user-section">
                <div class="admin-avatar">A</div>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <!-- Dashboard Widgets -->
        <div class="dashboard-widgets">
            <div class="widget">
                <div class="widget-title">Today's Appointments</div>
                <div class="widget-value widget-today">
                    <c:set var="todayCount" value="0" />
                    <c:forEach items="${todayAppointments}" var="appointment">
                        <c:if test="${appointment.status != 'CANCELLED'}">
                            <c:set var="todayCount" value="${todayCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${todayCount}
                </div>
                <a href="${pageContext.request.contextPath}/admin/appointments" class="widget-link">View All Appointments</a>
            </div>

            <div class="widget">
                <div class="widget-title">Pending Appointments</div>
                <div class="widget-value widget-pending">
                    <c:set var="pendingCount" value="0" />
                    <c:forEach items="${todayAppointments}" var="appointment">
                        <c:if test="${appointment.status == 'PENDING'}">
                            <c:set var="pendingCount" value="${pendingCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${pendingCount}
                </div>
                <a href="${pageContext.request.contextPath}/admin/appointments" class="widget-link">View All Appointments</a>
            </div>

            <div class="widget">
                <div class="widget-title">Confirmed Appointments</div>
                <div class="widget-value widget-confirmed">
                    <c:set var="confirmedCount" value="0" />
                    <c:forEach items="${todayAppointments}" var="appointment">
                        <c:if test="${appointment.status == 'CONFIRMED'}">
                            <c:set var="confirmedCount" value="${confirmedCount + 1}" />
                        </c:if>
                    </c:forEach>
                    ${confirmedCount}
                </div>
                <a href="${pageContext.request.contextPath}/admin/appointments" class="widget-link">View All Appointments</a>
            </div>
        </div>

        <!-- Today's Appointments Card -->
        <div class="dashboard-card">
            <div class="card-header">
                <h2>Today's Appointments</h2>
                <span><%= java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy")) %></span>
            </div>

            <div class="card-content">
                <div class="today-appointments">
                    <c:if test="${empty todayAppointments}">
                        <div class="empty-message">No appointments scheduled for today.</div>
                    </c:if>

                    <c:forEach items="${todayAppointments}" var="appointment">
                        <div class="appointment-item">
                            <div>
                                <span class="appointment-time">${appointment.formattedTime}</span> -
                                <span class="appointment-client">${appointment.userName}</span>
                                <span class="appointment-status status-${appointment.status.toLowerCase()}">${appointment.status}</span>
                            </div>
                            <div class="appointment-service">${appointment.serviceName} - $${appointment.price}</div>

                            <div class="status-actions">
                                <a href="${pageContext.request.contextPath}/admin/appointment/edit/${appointment.id}" class="status-btn">Edit</a>

                                <c:if test="${appointment.status == 'PENDING'}">
                                    <a href="${pageContext.request.contextPath}/admin/appointment/change-status/${appointment.id}/CONFIRMED" class="status-btn confirm-btn">Confirm</a>
                                </c:if>

                                <c:if test="${appointment.status == 'CONFIRMED'}">
                                    <a href="${pageContext.request.contextPath}/admin/appointment/change-status/${appointment.id}/COMPLETED" class="status-btn complete-btn">Complete</a>
                                </c:if>

                                <c:if test="${appointment.status != 'CANCELLED' && appointment.status != 'COMPLETED'}">
                                    <a href="${pageContext.request.contextPath}/admin/appointment/change-status/${appointment.id}/CANCELLED" class="status-btn cancel-btn" onclick="return confirm('Are you sure you want to cancel this appointment?')">Cancel</a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- Dashboard Grid -->
        <div class="dashboard-grid">
            <!-- Quick Stats -->
            <div class="dashboard-card">
                <div class="card-header">
                    <h3>Quick Stats</h3>
                </div>
                <div class="card-content">
                    <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px;">
                        <div style="background-color: rgba(156, 39, 176, 0.1); padding: 20px; border-radius: 8px; text-align: center;">
                            <div style="color: var(--text-light); font-size: 14px;">Total Services</div>
                            <div style="font-size: 28px; font-weight: bold; color: var(--secondary-color); margin: 10px 0;">12</div>
                        </div>
                        <div style="background-color: rgba(240, 98, 146, 0.1); padding: 20px; border-radius: 8px; text-align: center;">
                            <div style="color: var(--text-light); font-size: 14px;">Total Users</div>
                            <div style="font-size: 28px; font-weight: bold; color: var(--accent-color); margin: 10px 0;">25</div>
                        </div>
                        <div style="background-color: rgba(240, 98, 146, 0.1); padding: 20px; border-radius: 8px; text-align: center;">
                            <div style="color: var(--text-light); font-size: 14px;">Monthly Revenue</div>
                            <div style="font-size: 28px; font-weight: bold; color: var(--accent-color); margin: 10px 0;">$1,250</div>
                        </div>
                        <div style="background-color: rgba(156, 39, 176, 0.1); padding: 20px; border-radius: 8px; text-align: center;">
                            <div style="color: var(--text-light); font-size: 14px;">Total Reviews</div>
                            <div style="font-size: 28px; font-weight: bold; color: var(--secondary-color); margin: 10px 0;">42</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Revenue Growth Chart (replacing Quick Actions) -->
            <div class="dashboard-card">
                <div class="card-header">
                    <h3>Revenue Growth</h3>
                </div>
                <div class="card-content">
                    <div class="chart-filters">
                        <button class="chart-filter active" data-period="monthly">Monthly</button>
                        <button class="chart-filter" data-period="quarterly">Quarterly</button>
                        <button class="chart-filter" data-period="yearly">Yearly</button>
                    </div>
                    <div class="chart-container">
                        <canvas id="revenueChart"></canvas>
                    </div>
                    <div class="chart-legend">
                        <div class="legend-item">
                            <div class="legend-color primary"></div>
                            <span>Revenue</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-color secondary"></div>
                            <span>Projected Growth</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- View All Appointments Button -->
        <div style="text-align: center; margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/admin/appointments" class="btn" style="padding: 12px 30px; font-size: 16px;">View All Appointments</a>
        </div>
    </div>
</div>
<script>
    // Revenue Chart Data
    const monthlyData = {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        datasets: [
            {
                label: 'Revenue',
                data: [950, 1050, 900, 1100, 1250, 1400, 1350, 1500, 1650, 1800, 1950, 2100],
                backgroundColor: 'rgba(156, 39, 176, 0.1)',
                borderColor: 'rgba(156, 39, 176, 0.7)',
                borderWidth: 2,
                tension: 0.4,
                fill: true
            },
            {
                label: 'Projected Growth',
                data: [950, 1050, 900, 1100, 1250, 1400, 1350, 1500, 1650, 1800, 1950, 2200, 2350, 2500],
                backgroundColor: 'rgba(240, 98, 146, 0.0)',
                borderColor: 'rgba(240, 98, 146, 0.7)',
                borderWidth: 2,
                borderDash: [5, 5],
                tension: 0.4,
                fill: false,
                pointStyle: false
            }
        ]
    };

    const quarterlyData = {
        labels: ['Q1 2024', 'Q2 2024', 'Q3 2024', 'Q4 2024', 'Q1 2025', 'Q2 2025'],
        datasets: [
            {
                label: 'Revenue',
                data: [2900, 3750, 4500, 5850, 6300, 7200],
                backgroundColor: 'rgba(156, 39, 176, 0.1)',
                borderColor: 'rgba(156, 39, 176, 0.7)',
                borderWidth: 2,
                tension: 0.4,
                fill: true
            },
            {
                label: 'Projected Growth',
                data: [2900, 3750, 4500, 5850, 6300, 7200, 8100, 9000],
                backgroundColor: 'rgba(240, 98, 146, 0.0)',
                borderColor: 'rgba(240, 98, 146, 0.7)',
                borderWidth: 2,
                borderDash: [5, 5],
                tension: 0.4,
                fill: false,
                pointStyle: false
            }
        ]
    };

    const yearlyData = {
        labels: ['2021', '2022', '2023', '2024', '2025'],
        datasets: [
            {
                label: 'Revenue',
                data: [12500, 18700, 24300, 32000, 39000],
                backgroundColor: 'rgba(156, 39, 176, 0.1)',
                borderColor: 'rgba(156, 39, 176, 0.7)',
                borderWidth: 2,
                tension: 0.4,
                fill: true
            },
            {
                label: 'Projected Growth',
                data: [12500, 18700, 24300, 32000, 39000, 48000, 58000],
                backgroundColor: 'rgba(240, 98, 146, 0.0)',
                borderColor: 'rgba(240, 98, 146, 0.7)',
                borderWidth: 2,
                borderDash: [5, 5],
                tension: 0.4,
                fill: false,
                pointStyle: false
            }
        ]
    };

    // Chart Configuration
    const chartConfig = {
        type: 'line',
        data: monthlyData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    mode: 'index',
                    intersect: false,
                    backgroundColor: 'rgba(45, 27, 78, 0.9)',
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    titleFont: {
                        size: 14,
                        weight: 'bold',
                        family: "'Inter', sans-serif"
                    },
                    bodyFont: {
                        size: 13,
                        family: "'Inter', sans-serif"
                    },
                    padding: 12,
                    cornerRadius: 8,
                    caretSize: 6,
                    displayColors: false,
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || '';
                            if (label) {
                                label += ': ';
                            }
                            if (context.parsed.y !== null) {
                                label += new Intl.NumberFormat('en-US', {
                                    style: 'currency',
                                    currency: 'USD',
                                    minimumFractionDigits: 0
                                }).format(context.parsed.y);
                            }
                            return label;
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)',
                        drawBorder: false
                    },
                    ticks: {
                        font: {
                            family: "'Inter', sans-serif",
                            size: 12
                        },
                        color: 'rgba(117, 117, 117, 0.8)'
                    }
                },
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)',
                        drawBorder: false
                    },
                    ticks: {
                        font: {
                            family: "'Inter', sans-serif",
                            size: 12
                        },
                        color: 'rgba(117, 117, 117, 0.8)',
                        callback: function(value, index, values) {
                            return '$' + value.toLocaleString();
                        }
                    }
                }
            },
            interaction: {
                mode: 'nearest',
                axis: 'x',
                intersect: false
            },
            elements: {
                point: {
                    radius: 3,
                    hoverRadius: 5
                }
            }
        }
    };

    // Initialize Chart
    document.addEventListener('DOMContentLoaded', function() {
        const ctx = document.getElementById('revenueChart').getContext('2d');
        const revenueChart = new Chart(ctx, chartConfig);

        // Handle Period Filter Clicks
        const filterButtons = document.querySelectorAll('.chart-filter');
        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Remove active class from all buttons
                filterButtons.forEach(btn => btn.classList.remove('active'));
                // Add active class to clicked button
                this.classList.add('active');

                // Update chart data based on selected period
                const period = this.getAttribute('data-period');
                if (period === 'monthly') {
                    revenueChart.data = monthlyData;
                } else if (period === 'quarterly') {
                    revenueChart.data = quarterlyData;
                } else if (period === 'yearly') {
                    revenueChart.data = yearlyData;
                }

                // Update chart
                revenueChart.update();
            });
        });
    });
</script>
</body>
</html>