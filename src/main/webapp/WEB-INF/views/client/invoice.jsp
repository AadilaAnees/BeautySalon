<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice - Salon Booking System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2d1b4e;
            --primary-dark: #1a0f2e;
            --secondary-color: #9c27b0;
            --accent-color: #4299e1;
            --text-dark: #2d2d2d;
            --text-light: #757575;
            --text-muted: #a0aec0;
            --background: #f8f9fa;
            --white: #ffffff;
            --border-color: #e2e8f0;
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --green-500: #48bb78;
            --red-500: #e53e3e;
            --blue-500: #4299e1;
            --orange-500: #ed8936;
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
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
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
            font-weight: 700;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .user-info span {
            font-weight: 500;
        }

        .logout-btn {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: var(--shadow-sm);
        }

        .logout-btn:hover {
            background-color: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .navbar {
            background-color: var(--white);
            box-shadow: var(--shadow-md);
            margin-bottom: 0;
            display: flex;
            justify-content: center;
            padding: 0 20px;
        }

        .navbar a {
            display: block;
            color: var(--text-dark);
            text-align: center;
            padding: 16px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
        }

        .navbar a:hover {
            color: var(--secondary-color);
        }

        .navbar a.active {
            color: var(--secondary-color);
            font-weight: 600;
        }

        .navbar a.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(to right, var(--secondary-color), var(--accent-color));
            border-radius: 3px 3px 0 0;
        }

        /* Icons for the navbar */
        .navbar a::before {
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 8px;
        }

        .navbar a:nth-child(1)::before {
            content: '\f015'; /* Home icon */
        }

        .navbar a:nth-child(2)::before {
            content: '\f1ad'; /* Building icon */
        }

        .navbar a:nth-child(3)::before {
            content: '\f073'; /* Calendar icon */
        }

        .navbar a:nth-child(4)::before {
            content: '\f007'; /* User icon */
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            background-color: var(--white);
            padding: 40px;
            border-radius: 12px;
            box-shadow: var(--shadow-lg);
        }

        .invoice-header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
        }

        .invoice-header h2 {
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            margin-bottom: 10px;
            font-size: 32px;
            letter-spacing: 1px;
        }

        .invoice-header p {
            color: var(--text-light);
            margin: 5px 0;
            font-size: 15px;
        }

        .invoice-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 40px;
            gap: 30px;
        }

        .invoice-info div {
            flex: 1;
        }

        .invoice-info h3 {
            margin-top: 0;
            margin-bottom: 15px;
            color: var(--primary-color);
            font-family: 'Playfair Display', serif;
            font-size: 18px;
            font-weight: 600;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 10px;
        }

        .invoice-info p {
            margin: 8px 0;
            color: var(--text-dark);
            font-size: 15px;
        }

        .invoice-info strong {
            color: var(--primary-color);
            font-weight: 600;
        }

        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            overflow: hidden;
        }

        .invoice-table th {
            background-color: #f8f9fa;
            padding: 12px 15px;
            text-align: left;
            color: var(--primary-color);
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .invoice-table td {
            padding: 12px 15px;
            border-top: 1px solid var(--border-color);
            color: var(--text-dark);
        }

        .invoice-table tr:nth-child(even) {
            background-color: #f9fafc;
        }

        .invoice-total {
            text-align: right;
            font-size: 20px;
            font-weight: bold;
            color: var(--primary-color);
            margin-top: 20px;
            padding: 15px 0;
            border-top: 2px solid var(--border-color);
        }

        .payment-status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            margin: 15px 0;
        }

        .status-successful {
            background-color: rgba(72, 187, 120, 0.15);
            color: var(--green-500);
        }

        .status-successful::before {
            content: '\f00c';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .status-refunded {
            background-color: rgba(237, 137, 54, 0.15);
            color: var(--orange-500);
        }

        .status-refunded::before {
            content: '\f0e2';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .invoice-footer {
            margin-top: 50px;
            border-top: 1px solid var(--border-color);
            padding-top: 20px;
            text-align: center;
            color: var(--text-muted);
            font-size: 14px;
            line-height: 1.8;
        }

        .buttons {
            margin-top: 40px;
            text-align: center;
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            background-color: var(--accent-color);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 15px;
            box-shadow: var(--shadow-sm);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-print {
            background-color: var(--blue-500);
        }

        .logo-placeholder {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo-text {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            font-weight: 700;
            color: var(--primary-color);
        }

        /* Responsive styles */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                padding: 15px;
                gap: 15px;
            }

            .navbar {
                overflow-x: auto;
                justify-content: flex-start;
                padding: 0 10px;
            }

            .navbar a {
                padding: 12px 10px;
                white-space: nowrap;
            }

            .container {
                margin: 20px 15px;
                padding: 25px;
            }

            .invoice-info {
                flex-direction: column;
                gap: 20px;
            }

            .buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media print {
            .header, .navbar, .buttons {
                display: none;
            }
            .container {
                box-shadow: none;
                margin: 0;
                padding: 20px;
            }
            body {
                background-color: white;
            }
            .invoice-header h2 {
                color: #000;
            }
            .invoice-info h3, .invoice-total, .invoice-info strong {
                color: #000;
            }
            .invoice-table th {
                background-color: #f1f1f1;
                color: #000;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <h1>Elegant Beauty Salon</h1>
    <div class="user-info">
        <span>Welcome, ${user.username}</span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/client/dashboard">Dashboard</a>
    <a href="${pageContext.request.contextPath}/client/services">Services</a>
    <a href="${pageContext.request.contextPath}/client/appointments">My Appointments</a>
    <a href="${pageContext.request.contextPath}/client/profile">My Profile</a>
</div>

<div class="container" id="invoice">
    <div class="logo-placeholder">
        <div class="logo-text">Elegant Beauty Salon</div>
    </div>

    <div class="invoice-header">
        <h2>INVOICE</h2>
        <p>Invoice #${payment.id}</p>
        <p>Date: ${payment.formattedPaymentDate}</p>
        <div class="payment-status status-${payment.status.toLowerCase()}">${payment.status}</div>
    </div>

    <div class="invoice-info">
        <div>
            <h3>From</h3>
            <p><strong>Elegant Beauty Salon</strong></p>
            <p>123 Beauty Street</p>
            <p>Anywhere, CA 12345</p>
            <p>Phone: (123) 456-7890</p>
            <p>Email: info@elegantbeauty.com</p>
        </div>

        <div>
            <h3>To</h3>
            <p><strong>${payment.userName}</strong></p>
            <c:if test="${not empty appointment}">
                <p>Appointment Date: ${appointment.formattedDate}</p>
                <p>Appointment Time: ${appointment.formattedTime}</p>
            </c:if>
        </div>
    </div>

    <table class="invoice-table">
        <thead>
        <tr>
            <th>Service</th>
            <th>Description</th>
            <th>Price</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>${payment.serviceName}</td>
            <td>Salon service</td>
            <td>$${payment.amount}</td>
        </tr>
        </tbody>
    </table>

    <div class="invoice-total">
        Total: $${payment.amount}
    </div>

    <div class="invoice-footer">
        <p>Thank you for your business!</p>
        <p>We appreciate your trust in our services and look forward to seeing you again.</p>
        <p>Payment processed by Elegant Beauty Salon | Card: ${payment.cardNumber}</p>
    </div>

    <div class="buttons">
        <button class="btn btn-print" onclick="window.print()">
            <i class="fas fa-print"></i> Print Invoice
        </button>
        <a href="${pageContext.request.contextPath}/client/payments" class="btn">
            <i class="fas fa-arrow-left"></i> Back to Payments
        </a>
    </div>
</div>
</body>
</html>