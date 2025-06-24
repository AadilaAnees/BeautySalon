<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Elegant Beauty Salon</title>
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
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--background);
            background-image: linear-gradient(135deg, rgba(45, 27, 78, 0.05) 0%, rgba(240, 98, 146, 0.05) 100%);
            color: var(--text-dark);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            width: 100%;
            max-width: 420px;
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            position: relative;
        }

        .header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            padding: 30px 40px;
            text-align: center;
            color: var(--white);
            position: relative;
        }

        .header::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            right: 0;
            height: 20px;
            background: var(--white);
            border-radius: 50% 50% 0 0 / 100% 100% 0 0;
        }

        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
            letter-spacing: 0.5px;
        }

        .tagline {
            font-size: 14px;
            opacity: 0.9;
            font-weight: 300;
        }

        .form-container {
            padding: 30px 40px 40px;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            font-size: 24px;
            margin-bottom: 25px;
            text-align: center;
            position: relative;
            display: inline-block;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 40px;
            height: 3px;
            background: linear-gradient(90deg, var(--accent-color) 0%, var(--secondary-color) 100%);
        }

        .form-title-wrapper {
            display: flex;
            justify-content: center;
            margin-bottom: 10px;
        }

        .alert {
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
        }

        .alert-danger {
            background-color: rgba(229, 62, 62, 0.1);
            color: var(--red-500);
            border-left: 4px solid var(--red-500);
        }

        .alert-success {
            background-color: rgba(72, 187, 120, 0.1);
            color: var(--green-500);
            border-left: 4px solid var(--green-500);
        }

        .form-group {
            margin-bottom: 24px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-dark);
            font-size: 14px;
        }

        input[type="text"],
        input[type="password"] {
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
        input[type="password"]:focus {
            outline: none;
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(156, 39, 176, 0.1);
        }

        .btn {
            display: block;
            width: 100%;
            padding: 14px;
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-md);
            text-align: center;
            font-family: 'Inter', sans-serif;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .links {
            text-align: center;
            margin-top: 25px;
            color: var(--text-light);
            font-size: 14px;
        }

        .links a {
            color: var(--secondary-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .links a:hover {
            color: var(--accent-color);
            text-decoration: underline;
        }

        .divider {
            margin: 10px 0;
            height: 1px;
            background-color: var(--border-color);
        }

        /* Decorative elements */
        .decoration {
            position: absolute;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent-light), var(--accent-color));
            opacity: 0.1;
            z-index: -1;
        }

        .decoration-1 {
            width: 100px;
            height: 100px;
            top: -20px;
            right: -20px;
        }

        .decoration-2 {
            width: 60px;
            height: 60px;
            bottom: 20px;
            left: -30px;
        }

        @media (max-width: 480px) {
            .container {
                max-width: 100%;
            }

            .form-container {
                padding: 20px 25px 30px;
            }

            .header {
                padding: 25px 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="decoration decoration-1"></div>
    <div class="decoration decoration-2"></div>

    <div class="header">
        <div class="logo">Elegant Beauty Salon</div>
        <div class="tagline">Where Beauty Meets Elegance</div>
    </div>

    <div class="form-container">
        <div class="form-title-wrapper">
            <h2>Sign In</h2>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <button type="submit" class="btn">Sign In</button>
        </form>

        <div class="links">
            <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a></p>
            <div class="divider"></div>
            <p><a href="${pageContext.request.contextPath}/">Back to Home</a></p>
        </div>
    </div>
</div>
</body>
</html>