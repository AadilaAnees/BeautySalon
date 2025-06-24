<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Elegant Beauty Salon</title>
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

        .header {
            margin-bottom: 32px;
        }

        .header h1 {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-color);
            font-family: 'Playfair Display', serif;
            margin-bottom: 10px;
        }

        .header p {
            color: var(--text-light);
        }

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

        .profile-card {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-md);
            margin-bottom: 30px;
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        .profile-card-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(90deg, rgba(156, 39, 176, 0.05) 0%, rgba(240, 98, 146, 0.05) 100%);
        }

        .profile-card-title {
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            font-weight: 600;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .profile-card-title span {
            font-size: 20px;
        }

        .profile-card-content {
            padding: 24px;
        }

        .profile-details .row {
            display: flex;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border-color);
        }

        .profile-details .row:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .profile-details .label {
            width: 30%;
            font-weight: 600;
            color: var(--text-dark);
        }

        .profile-details .value {
            width: 70%;
            color: var(--text-light);
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

        .btn-outline {
            background-color: transparent;
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
        }

        .btn-outline:hover {
            background-color: rgba(45, 27, 78, 0.05);
        }

        .password-section {
            margin-top: 20px;
            text-align: center;
            padding: 30px;
            background-color: rgba(156, 39, 176, 0.03);
            border-radius: 12px;
            border: 1px dashed rgba(156, 39, 176, 0.2);
        }

        .password-section h3 {
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            margin-bottom: 15px;
            font-size: 18px;
        }

        .password-section p {
            color: var(--text-light);
            margin-bottom: 20px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-dark);
        }

        .form-group input {
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

        .form-group input:focus {
            outline: none;
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(156, 39, 176, 0.1);
        }

        .form-group .hint {
            margin-top: 5px;
            font-size: 12px;
            color: var(--text-muted);
            font-style: italic;
        }

        .buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        @media (max-width: 768px) {
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

            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .profile-details .row {
                flex-direction: column;
            }

            .profile-details .label,
            .profile-details .value {
                width: 100%;
            }

            .profile-details .label {
                margin-bottom: 5px;
            }

            .buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
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
                <a href="${pageContext.request.contextPath}/client/profile" class="nav-link active">
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
                <a href="${pageContext.request.contextPath}/client/appointments" class="nav-link">
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
        <div class="header">
            <h1>My Profile</h1>
            <p>View and manage your personal information</p>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="profile-card">
            <div class="profile-card-header">
                <h2 class="profile-card-title"><span>👤</span> Personal Information</h2>
                <button class="btn btn-outline" onclick="toggleEditForm()">
                    <span>✏️</span> Edit Profile
                </button>
            </div>

            <div class="profile-card-content">
                <!-- Profile Display View -->
                <div class="profile-details" id="profileDetails">
                    <div class="row">
                        <div class="label">Username</div>
                        <div class="value">${user.username}</div>
                    </div>
                    <div class="row">
                        <div class="label">Email Address</div>
                        <div class="value">${user.email}</div>
                    </div>
                    <div class="row">
                        <div class="label">Phone Number</div>
                        <div class="value">${user.phone}</div>
                    </div>
                </div>

                <!-- Edit Profile Form - Initially Hidden -->
                <div class="profile-details" id="editForm" style="display: none;">
                    <form action="${pageContext.request.contextPath}/client/profile/update" method="post">
                        <div class="row">
                            <div class="label">Username</div>
                            <div class="value">
                                <div class="form-group" style="margin-bottom: 0;">
                                    <input type="text" id="username" value="${user.username}" readonly>
                                    <div class="hint">Username cannot be changed</div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="label">Email Address</div>
                            <div class="value">
                                <div class="form-group" style="margin-bottom: 0;">
                                    <input type="email" id="email" name="email" value="${user.email}" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="label">Phone Number</div>
                            <div class="value">
                                <div class="form-group" style="margin-bottom: 0;">
                                    <input type="tel" id="phone" name="phone" value="${user.phone}" required>
                                </div>
                            </div>
                        </div>

                        <div class="buttons">
                            <button type="submit" class="btn btn-primary">
                                <span>💾</span> Save Changes
                            </button>
                            <button type="button" class="btn btn-outline" onclick="toggleEditForm()">
                                <span>✖️</span> Cancel
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Password Change Section -->
        <div class="profile-card">
            <div class="profile-card-header">
                <h2 class="profile-card-title"><span>🔒</span> Security</h2>
            </div>

            <div class="profile-card-content">
                <div class="password-section">
                    <h3>Password Management</h3>
                    <p>Protect your account by regularly updating your password. A strong password helps keep your personal information secure.</p>
                    <a href="${pageContext.request.contextPath}/client/profile/password" class="btn btn-primary">
                        <span>🔑</span> Change Password
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function toggleEditForm() {
        const profileDetails = document.getElementById('profileDetails');
        const editForm = document.getElementById('editForm');

        if (profileDetails.style.display === 'none') {
            profileDetails.style.display = 'block';
            editForm.style.display = 'none';
        } else {
            profileDetails.style.display = 'none';
            editForm.style.display = 'block';
        }
    }
</script>
</body>
</html>