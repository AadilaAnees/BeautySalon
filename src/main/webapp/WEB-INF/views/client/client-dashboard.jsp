<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Dashboard - Elegant Beauty Salon</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
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
            min-height: 100vh;
        }

        .dashboard-container {
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

        .salon-logo {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
            letter-spacing: 0.5px;
        }

        .salon-logo span {
            display: block;
            font-size: 14px;
            font-style: italic;
            letter-spacing: 0;
            opacity: 0.8;
            margin-top: 4px;
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

        .menu-item {
            padding: 12px 16px;
            margin: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: var(--white);
            font-weight: 500;
        }

        .menu-item:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .menu-item.active {
            background: linear-gradient(90deg, var(--accent-color) 0%, var(--secondary-color) 100%);
            font-weight: 600;
            box-shadow: var(--shadow-md);
        }

        .logout {
            margin: 16px;
            padding: 12px;
            background-color: var(--primary-dark);
            border-radius: 8px;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: auto;
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

        .welcome-banner {
            background: linear-gradient(135deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            border-radius: 16px;
            padding: 40px;
            color: white;
            margin-bottom: 32px;
            box-shadow: var(--shadow-lg);
            position: relative;
            overflow: hidden;
        }

        .welcome-banner::before {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
        }

        .welcome-banner::after {
            content: '';
            position: absolute;
            bottom: -50px;
            left: -50px;
            width: 150px;
            height: 150px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
        }

        .welcome-banner h2 {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            margin-bottom: 12px;
            position: relative;
            z-index: 2;
        }

        .welcome-banner p {
            font-size: 16px;
            opacity: 0.9;
            max-width: 700px;
            position: relative;
            z-index: 2;
        }

        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 24px;
            margin-bottom: 32px;
        }

        .stat-card {
            background-color: var(--white);
            border-radius: 12px;
            padding: 24px;
            box-shadow: var(--shadow-md);
            text-align: center;
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .stat-card::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
        }

        .stat-card .value {
            font-size: 32px;
            font-weight: 700;
            color: var(--secondary-color);
            margin: 12px 0;
            font-family: 'Playfair Display', serif;
        }

        .stat-card .label {
            color: var(--text-light);
            font-size: 14px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-icon {
            font-size: 24px;
            margin-bottom: 10px;
            color: var(--accent-color);
        }

        .section-title {
            display: flex;
            align-items: center;
            margin: 32px 0 20px;
            position: relative;
        }

        .section-title h2 {
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            color: var(--primary-color);
            position: relative;
            padding-left: 16px;
            z-index: 1;
        }

        .section-title h2::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 20px;
            background: linear-gradient(to bottom, var(--secondary-color), var(--accent-color));
            border-radius: 2px;
        }

        .section-title::after {
            content: '';
            flex: 1;
            height: 1px;
            background: linear-gradient(to right, var(--border-color) 0%, rgba(226, 232, 240, 0.1) 100%);
            margin-left: 15px;
        }

        .content-section {
            background-color: var(--white);
            padding: 24px;
            border-radius: 12px;
            box-shadow: var(--shadow-md);
            margin-bottom: 24px;
            border: 1px solid var(--border-color);
        }

        .notification {
            position: relative;
            padding: 12px 12px 12px 40px;
            margin-bottom: 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .notification:last-child {
            margin-bottom: 0;
        }

        .notification:hover {
            background-color: rgba(156, 39, 176, 0.05);
        }

        .notification::before {
            content: '';
            position: absolute;
            left: 16px;
            top: 16px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }

        .notification.info::before {
            background-color: var(--blue-500);
            box-shadow: 0 0 0 2px var(--blue-100);
        }

        .notification.success::before {
            background-color: var(--green-500);
            box-shadow: 0 0 0 2px var(--green-100);
        }

        .notification.warning::before {
            background-color: var(--yellow-500);
            box-shadow: 0 0 0 2px var(--yellow-100);
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 24px;
            margin-top: 20px;
        }

        .service-card {
            background-color: var(--white);
            border-radius: 12px;
            padding: 24px;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .service-card h3 {
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            margin-bottom: 12px;
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .service-card h3 span {
            font-size: 20px;
        }

        .service-card p {
            color: var(--text-light);
            margin-bottom: 20px;
            min-height: 50px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            font-size: 14px;
            text-decoration: none;
            font-family: 'Inter', sans-serif;
        }

        .btn-primary {
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            color: var(--white);
            box-shadow: var(--shadow-sm);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .icon {
            font-size: 18px;
        }

        /* Alert styles */
        .alert {
            padding: 16px;
            margin-bottom: 24px;
            border-radius: 8px;
            font-size: 14px;
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

        /* Responsive styles */
        @media (max-width: 992px) {
            .stats-row {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .dashboard-container {
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

            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .stats-row {
                grid-template-columns: 1fr;
            }

            .welcome-banner {
                padding: 30px 20px;
            }

            .services-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="salon-logo">
                Elegant Beauty Salon
                <span>Where Beauty Meets Elegance</span>
            </div>
            <div class="user-avatar">
                ${user.username.charAt(0)}
            </div>
            <p>Welcome, ${user.username}</p>
        </div>

        <a href="${pageContext.request.contextPath}/client/dashboard" class="menu-item active">
            <span class="icon">📊</span> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/client/profile" class="menu-item">
            <span class="icon">👤</span> My Profile
        </a>
        <a href="${pageContext.request.contextPath}/client/appointment/book" class="menu-item">
            <span class="icon">📅</span> Book Appointment
        </a>
        <a href="${pageContext.request.contextPath}/client/appointments" class="menu-item">
            <span class="icon">📋</span> My Appointments
        </a>
        <a href="${pageContext.request.contextPath}/client/services" class="menu-item">
            <span class="icon">💇</span> Services
        </a>
        <a href="${pageContext.request.contextPath}/client/payments" class="menu-item">
            <span class="icon">💳</span> Payments
        </a>
        <a href="${pageContext.request.contextPath}/client/reviews" class="menu-item">
            <span class="icon">⭐</span> My Reviews
        </a>

        <div class="logout">
            <a href="${pageContext.request.contextPath}/logout">
                <span>🚪</span> Logout
            </a>
        </div>
    </div>

    <div class="main-content">
        <!-- Alerts (if any) -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="welcome-banner">
            <h2>Welcome to Elegant Beauty Salon</h2>
            <p>Manage your appointments, services, and profile all in one place. We're delighted to have you with us!</p>
        </div>

        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-icon">📅</div>
                <div class="label">Upcoming Appointments</div>
                <div class="value">2</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🎁</div>
                <div class="label">Loyalty Points</div>
                <div class="value">350</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">✓</div>
                <div class="label">Completed Services</div>
                <div class="value">8</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🏷️</div>
                <div class="label">Available Offers</div>
                <div class="value">3</div>
            </div>
        </div>

        <div class="section-title">
            <h2>Recent Notifications</h2>
        </div>

        <div class="content-section">
            <div class="notification info">Your appointment for Hair Styling is confirmed for tomorrow at 2:00 PM</div>
            <div class="notification warning">New seasonal offers available! Check our services page.</div>
            <div class="notification success">Thank you for your recent review. We appreciate your feedback!</div>
        </div>

        <div class="section-title">
            <h2>Quick Access</h2>
        </div>

        <div class="services-grid">
            <div class="service-card">
                <h3><span>👤</span> My Profile</h3>
                <p>View and update your personal information and account settings</p>
                <a href="${pageContext.request.contextPath}/client/profile" class="btn btn-primary">Update Profile</a>
            </div>

            <div class="service-card">
                <h3><span>📅</span> Book Appointment</h3>
                <p>Schedule a new salon appointment with your preferred stylist and services</p>
                <a href="${pageContext.request.contextPath}/client/appointment/book" class="btn btn-primary">Book Now</a>
            </div>

            <div class="service-card">
                <h3><span>📋</span> My Appointments</h3>
                <p>View and manage your upcoming and past appointments</p>
                <a href="${pageContext.request.contextPath}/client/appointments" class="btn btn-primary">View Appointments</a>
            </div>

            <div class="service-card">
                <h3><span>💇</span> Services</h3>
                <p>Browse our salon services, treatments, and pricing information</p>
                <a href="${pageContext.request.contextPath}/client/services" class="btn btn-primary">View Services</a>
            </div>

            <div class="service-card">
                <h3><span>💳</span> Payments</h3>
                <p>Check your payment history and manage payment methods</p>
                <a href="${pageContext.request.contextPath}/client/payments" class="btn btn-primary">View Payments</a>
            </div>

            <div class="service-card">
                <h3><span>⭐</span> My Reviews</h3>
                <p>View, edit and add reviews for services you've experienced</p>
                <a href="${pageContext.request.contextPath}/client/reviews" class="btn btn-primary">View Reviews</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>