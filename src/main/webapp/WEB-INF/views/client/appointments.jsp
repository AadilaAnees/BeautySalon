<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Appointments - Elegant Beauty Salon</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
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
            --green-500: #48bb78;
            --green-100: #f0fff4;
            --red-500: #e53e3e;
            --red-100: #fff5f5;
            --blue-500: #4299e1;
            --blue-100: #ebf8ff;
            --yellow-500: #ecc94b;
            --yellow-100: #fffff0;
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
        }

        .header {
            background: linear-gradient(to right, var(--secondary-dark), var(--secondary));
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow-md);
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
            font-family: 'Playfair Display', serif;
            font-weight: 600;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-info span {
            margin-right: 15px;
            font-weight: 500;
        }

        .logout-btn {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            background-color: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .navbar {
            background-color: var(--surface);
            border-radius: 12px;
            overflow: hidden;
            margin: 20px auto;
            max-width: 1200px;
            box-shadow: var(--shadow-sm);
            display: flex;
            justify-content: space-between;
        }

        .navbar a {
            display: block;
            color: var(--text-medium);
            text-align: center;
            padding: 16px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
        }

        .navbar a:hover {
            color: var(--secondary);
        }

        .navbar a.active {
            color: var(--secondary);
            font-weight: 600;
        }

        .navbar a.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(to right, var(--primary), var(--secondary-light));
            border-radius: 3px 3px 0 0;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            background-color: var(--surface);
            padding: 30px;
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .section-header h2 {
            margin: 0;
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            color: var(--text-dark);
            position: relative;
            padding-left: 15px;
        }

        .section-header h2::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 24px;
            background: linear-gradient(to bottom, var(--primary), var(--secondary));
            border-radius: 2px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-md);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background: linear-gradient(to right, var(--green-500), var(--green-500));
            color: white;
        }

        .btn-danger {
            background: linear-gradient(to right, var(--red-500));
            color: white;
        }

        .alert {
            padding: 16px;
            margin-bottom: 24px;
            border-radius: 8px;
            font-weight: 500;
            box-shadow: var(--shadow-sm);
        }

        .alert-success {
            background-color: rgba(102, 187, 106, 0.1);
            color: #2e7d32;
            border-left: 4px solid #2e7d32;
        }

        .alert-danger {
            background-color: rgba(229, 115, 115, 0.1);
            color: #c62828;
            border-left: 4px solid #c62828;
        }

        .tabs {
            display: flex;
            margin-bottom: 30px;
            border-bottom: 1px solid var(--border-light);
            gap: 10px;
        }

        .tab {
            padding: 12px 24px;
            cursor: pointer;
            border-bottom: 3px solid transparent;
            font-weight: 500;
            color: var(--text-medium);
            transition: all 0.3s ease;
            background-color: transparent;
            border-radius: 8px 8px 0 0;
        }

        .tab:hover {
            color: var(--secondary);
            background-color: rgba(155, 126, 189, 0.05);
        }

        .tab.active {
            color: var(--secondary);
            border-bottom: 3px solid var(--secondary);
            font-weight: 600;
        }

        .tab-content {
            display: none;
            animation: fadeIn 0.5s ease;
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
            text-align: center;
        }

        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
            letter-spacing: 0.5px;
        }

        .tagline {
            font-size: 12px;
            opacity: 0.8;
            font-weight: 300;
        }

        .user-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-weight: 600;
            font-size: 32px;
            margin: 20px auto 15px;
            border: 3px solid rgba(255, 255, 255, 0.2);
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

        .logout {
            margin: 16px;
            padding: 12px;
            background-color: var(--primary-dark);
            border-radius: 8px;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .logout:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .logout a {
            color: var(--white);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 32px;
        }



        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .tab-content.active {
            display: block;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 20px;
        }

        th {
            background-color: rgba(155, 126, 189, 0.1);
            color: var(--text-dark);
            font-weight: 600;
            text-align: left;
            padding: 16px;
            font-size: 14px;
            border-bottom: 1px solid var(--border-light);
        }

        td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid var(--border-light);
            color: var(--text-medium);
        }

        th:first-child, td:first-child {
            border-top-left-radius: 8px;
            border-bottom-left-radius: 8px;
        }

        th:last-child, td:last-child {
            border-top-right-radius: 8px;
            border-bottom-right-radius: 8px;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background-color: rgba(255, 225, 224, 0.2);
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .status-pending {
            color: var(--pending);
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 12px;
        }

        .status-pending::before {
            content: '⏱️';
        }

        .status-confirmed {
            color: var(--confirmed);
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .status-confirmed::before {
            content: '✅';
        }

        .status-cancelled {
            color: var(--cancelled);
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .status-cancelled::before {
            content: '❌';
        }

        .status-completed {
            color: var(--completed);
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .status-completed::before {
            content: '🏁';
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .empty-message {
            text-align: center;
            padding: 40px 20px;
            color: var(--text-light);
            font-style: italic;
            background-color: rgba(255, 225, 224, 0.2);
            border-radius: 8px;
            border: 1px dashed var(--border-light);
        }

        /* Debug info styling */
        .debug-info {
            font-size: 12px;
            color: var(--text-light);
            margin-bottom: 16px;
            padding: 8px 16px;
            background-color: rgba(255, 225, 224, 0.2);
            border-radius: 8px;
            display: inline-block;
        }
        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            justify-content: flex-start;
        }

        .actions .btn {
            padding: 8px 12px;
            font-size: 12px;
            white-space: nowrap;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .actions {
                flex-direction: column;
            }

            .actions .btn {
                width: 100%;
                margin-bottom: 5px;
            }
            .header {
                flex-direction: column;
                text-align: center;
                padding: 16px;
                gap: 10px;
            }

            .user-info {
                flex-direction: column;
                gap: 10px;
            }

            .user-info span {
                margin-right: 0;
            }

            .navbar {
                flex-wrap: wrap;
                justify-content: center;
            }

            .navbar a {
                padding: 12px 10px;
                font-size: 14px;
            }

            .container {
                padding: 16px;
            }

            .section-header {
                flex-direction: column;
                gap: 16px;
                align-items: flex-start;
            }

            .tabs {
                flex-wrap: wrap;
            }

            .tab {
                flex: 1;
                min-width: 100px;
                text-align: center;
                padding: 10px;
            }

            table {
                display: block;
                overflow-x: auto;
            }

            th, td {
                min-width: 120px;
            }

            .actions {
                flex-direction: column;
            }
            .dashboard-wrapper {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .sidebar-header {
                padding: 15px;
            }

            .user-avatar {
                width: 60px;
                height: 60px;
                font-size: 24px;
                margin: 15px auto 10px;
            }

            .nav-menu {
                display: flex;
                flex-wrap: wrap;
                padding: 10px;
            }

            .nav-item {
                flex: 1 0 50%;
                min-width: 120px;
                margin-bottom: 5px;
            }
        }
    </style>
</head>
<body>
<div>
<div class="dashboard-wrapper">
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="logo">Elegant Beauty Salon</div>
            <div class="tagline">Where Beauty Meets Elegance</div>
            <div class="user-avatar">${user.username.charAt(0)}</div>
            <div>Welcome, ${user.username}</div>
        </div>
        <nav class="nav-menu">
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/client/dashboard" class="nav-link">
                    <div class="nav-icon">📊</div>
                    <span>Dashboard</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/client/profile" class="nav-link">
                    <div class="nav-icon">👤</div>
                    <span>My Profile</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/client/appointment/book" class="nav-link">
                    <div class="nav-icon">📅</div>
                    <span>Book Appointment</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/client/appointments" class="nav-link active">
                    <div class="nav-icon">📋</div>
                    <span>My Appointments</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/client/services" class="nav-link">
                    <div class="nav-icon">✂️</div>
                    <span>Services</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/client/payments" class="nav-link">
                    <div class="nav-icon">💳</div>
                    <span>Payments</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/client/reviews" class="nav-link">
                    <div class="nav-icon">⭐</div>
                    <span>My Reviews</span>
                </a>
            </div>
        </nav>

        <div class="logout">
            <a href="${pageContext.request.contextPath}/logout">
                <span>🚪</span> Logout
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="container">
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="section-header">
                <h2>My Appointments</h2>
                <a href="${pageContext.request.contextPath}/client/appointment/book" class="btn">
                    <i class="fas fa-plus"></i> Book New Appointment
                </a>
            </div>

            <div class="tabs">
                <div class="tab active" onclick="showTab('upcoming')">
                    <i class="fas fa-calendar-day"></i> Upcoming
                </div>
                <div class="tab" onclick="showTab('past')">
                    <i class="fas fa-history"></i> Past
                </div>
                <div class="tab" onclick="showTab('cancelled')">
                    <i class="fas fa-ban"></i> Cancelled
                </div>
            </div>

    <!-- Debug info -->
    <c:set var="currentDate" value="<%= java.time.LocalDate.now() %>" />
    <div class="debug-info">
        Today's date: ${currentDate}
    </div>
            <div id="upcoming" class="tab-content active">
                <table>
                    <thead>
                    <tr>
                        <th>Service</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="hasUpcoming" value="false" />

                    <c:forEach items="${appointments}" var="appointment">
                        <c:if test="${appointment.status != 'CANCELLED' && appointment.appointmentDate != null &&
                            (appointment.appointmentDate.equals(currentDate) || appointment.appointmentDate.isAfter(currentDate))}">
                            <c:set var="hasUpcoming" value="true" />
                            <tr>
                                <td>${appointment.serviceName}</td>
                                <td>${appointment.formattedDate}</td>
                                <td>${appointment.formattedTime}</td>
                                <td>$${appointment.price}</td>
                                <td class="status-${appointment.status.toLowerCase()}">
                                        ${appointment.status}
                                </td>
                                <td> <!-- This is the Actions column -->
                                    <div class="actions">
                                        <c:if test="${appointment.status != 'COMPLETED'}">
                                            <a href="${pageContext.request.contextPath}/client/appointment/edit/${appointment.id}" class="btn btn-secondary">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <a href="${pageContext.request.contextPath}/client/appointment/cancel/${appointment.id}" class="btn btn-danger" onclick="return confirm('Are you sure you want to cancel this appointment?')">
                                                <i class="fas fa-times"></i> Cancel
                                            </a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>

                    <c:if test="${!hasUpcoming}">
                        <tr>
                            <td colspan="6" class="empty-message">
                                <i class="fas fa-calendar-times fa-2x" style="margin-bottom: 10px;"></i><br>
                                No upcoming appointments. Ready to pamper yourself?<br>
                                <a href="${pageContext.request.contextPath}/client/appointment/book" class="btn" style="margin-top: 15px;">
                                    <i class="fas fa-plus"></i> Book Now
                                </a>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>

    <div id="past" class="tab-content">
        <table>
            <thead>
            <tr>
                <th>Service</th>
                <th>Date</th>
                <th>Time</th>
                <th>Price</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <c:set var="hasPast" value="false" />

            <c:forEach items="${appointments}" var="appointment">
                <c:if test="${(appointment.status == 'COMPLETED' || appointment.appointmentDate != null &&
                                appointment.appointmentDate.isBefore(currentDate)) &&
                                appointment.status != 'CANCELLED'}">
                    <c:set var="hasPast" value="true" />
                    <tr>
                        <td>${appointment.serviceName}</td>
                        <td>${appointment.formattedDate}</td>
                        <td>${appointment.formattedTime}</td>
                        <td>$${appointment.price}</td>
                        <td class="status-${appointment.status.toLowerCase()}">${appointment.status}</td>
                    </tr>
                </c:if>
            </c:forEach>

            <c:if test="${!hasPast}">
                <tr>
                    <td colspan="6" class="empty-message">
                        <i class="fas fa-history fa-2x" style="margin-bottom: 10px;"></i><br>
                        No past appointments found
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>

    <div id="cancelled" class="tab-content">
        <table>
            <thead>
            <tr>
                <th>Service</th>
                <th>Date</th>
                <th>Time</th>
                <th>Price</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <c:set var="hasCancelled" value="false" />

            <c:forEach items="${appointments}" var="appointment">
                <c:if test="${appointment.status == 'CANCELLED'}">
                    <c:set var="hasCancelled" value="true" />
                    <tr>
                        <td>${appointment.serviceName}</td>
                        <td>${appointment.formattedDate}</td>
                        <td>${appointment.formattedTime}</td>
                        <td>$${appointment.price}</td>
                        <td class="status-cancelled">CANCELLED</td>
                    </tr>
                </c:if>
            </c:forEach>

            <c:if test="${!hasCancelled}">
                <tr>
                    <td colspan="5" class="empty-message">
                        <i class="fas fa-ban fa-2x" style="margin-bottom: 10px;"></i><br>
                        No cancelled appointments
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
    </div>
</div>
</div>

<script>
    function showTab(tabId) {
        // Hide all tab contents
        document.querySelectorAll('.tab-content').forEach(content => {
            content.classList.remove('active');
        });

        // Show the selected tab content
        document.getElementById(tabId).classList.add('active');

        // Update tab styling
        document.querySelectorAll('.tab').forEach(tab => {
            tab.classList.remove('active');
        });

        // Find the clicked tab and activate it
        document.querySelectorAll('.tab').forEach(tab => {
            if (tab.textContent.toLowerCase().includes(tabId)) {
                tab.classList.add('active');
            }
        });
    }
</script>
</body>
</html>