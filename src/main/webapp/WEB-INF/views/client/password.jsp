<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - Elegant Beauty Salon</title>
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

        .password-card {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-md);
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        .password-card-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border-color);
            background: linear-gradient(90deg, rgba(156, 39, 176, 0.05) 0%, rgba(240, 98, 146, 0.05) 100%);
        }

        .password-card-title {
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            font-weight: 600;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .password-card-content {
            padding: 24px;
        }

        .password-form-intro {
            margin-bottom: 24px;
            color: var(--text-light);
            font-size: 15px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-dark);
            font-size: 14px;
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

        .form-group .password-toggle {
            position: absolute;
            right: 16px;
            top: 40px;
            cursor: pointer;
            color: var(--text-muted);
            background: none;
            border: none;
            font-size: 16px;
        }

        .password-rules {
            margin-top: 30px;
            padding: 20px;
            border-radius: 8px;
            background: linear-gradient(135deg, rgba(156, 39, 176, 0.05) 0%, rgba(240, 98, 146, 0.05) 100%);
            border: 1px solid rgba(156, 39, 176, 0.1);
        }

        .password-rules h3 {
            font-size: 16px;
            color: var(--primary-color);
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .password-rules ul {
            list-style-type: none;
            padding: 0;
        }

        .password-rules li {
            margin-bottom: 8px;
            padding-left: 24px;
            position: relative;
            color: var(--text-light);
        }

        .password-rules li::before {
            content: "✓";
            position: absolute;
            left: 0;
            color: var(--green-500);
            font-weight: bold;
        }

        .buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            font-size: 15px;
            text-decoration: none;
            font-family: 'Inter', sans-serif;
        }

        .btn-primary {
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            color: var(--white);
            box-shadow: var(--shadow-sm);
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

        .breadcrumb {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .breadcrumb a {
            color: var(--text-light);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .breadcrumb a:hover {
            color: var(--secondary-color);
        }

        .breadcrumb .separator {
            margin: 0 10px;
            color: var(--text-muted);
        }

        .breadcrumb .current {
            color: var(--secondary-color);
            font-weight: 500;
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
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/client/profile" class="nav-link active">
                    <div class="nav-icon">👤</div>
                    <span>My Profile</span>
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
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/client/profile">My Profile</a>
            <span class="separator">›</span>
            <span class="current">Change Password</span>
        </div>

        <div class="header">
            <h1>Change Password</h1>
            <p>Update your password to keep your account secure</p>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="password-card">
            <div class="password-card-header">
                <h2 class="password-card-title"><span>🔒</span> Password Update</h2>
            </div>

            <div class="password-card-content">
                <p class="password-form-intro">
                    Please enter your current password and create a new password below. Ensure your new password follows our security guidelines for maximum protection.
                </p>

                <form action="${pageContext.request.contextPath}/client/profile/password/update" method="post">
                    <div class="form-group">
                        <label for="currentPassword">Current Password</label>
                        <input type="password" id="currentPassword" name="currentPassword" required>
                        <button type="button" class="password-toggle" onclick="togglePassword('currentPassword')">👁️</button>
                    </div>

                    <div class="form-group">
                        <label for="newPassword">New Password</label>
                        <input type="password" id="newPassword" name="newPassword" required>
                        <button type="button" class="password-toggle" onclick="togglePassword('newPassword')">👁️</button>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Confirm New Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                        <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">👁️</button>
                    </div>

                    <div class="password-rules">
                        <h3><span>🛡️</span> Password Guidelines</h3>
                        <ul>
                            <li>Use at least 8 characters</li>
                            <li>Include at least one uppercase letter (A-Z)</li>
                            <li>Include at least one number (0-9)</li>
                            <li>Include at least one special character (!@#$%^&*)</li>
                        </ul>
                    </div>

                    <div class="buttons">
                        <button type="submit" class="btn btn-primary">
                            <span>🔐</span> Update Password
                        </button>
                        <a href="${pageContext.request.contextPath}/client/profile" class="btn btn-secondary">
                            <span>✖️</span> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (newPassword !== confirmPassword) {
            e.preventDefault();
            alert('New password and confirmation do not match. Please try again.');
        }
    });

    function togglePassword(inputId) {
        const input = document.getElementById(inputId);
        if (input.type === "password") {
            input.type = "text";
        } else {
            input.type = "password";
        }
    }
</script>
</body>
</html>