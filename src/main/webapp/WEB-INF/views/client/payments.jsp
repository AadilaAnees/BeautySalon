<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Payments - Salon Booking System</title>
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
            --green-500: #48bb78;
            --red-500: #e53e3e;
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
            background-color: var(--accent-color);
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
            background-color: #d44a7a;
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
            content: '\f09d'; /* Credit card icon */
        }

        .navbar a:nth-child(5)::before {
            content: '\f005'; /* Star icon */
        }

        .navbar a:nth-child(6)::before {
            content: '\f007'; /* User icon */
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            background-color: var(--white);
            padding: 0;
            border-radius: 12px;
            box-shadow: var(--shadow-lg);
            overflow: hidden;
        }

        .alert {
            padding: 16px;
            margin-bottom: 0;
            border-radius: 0;
            font-weight: 500;
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

        .section-header {
            background: linear-gradient(to right, rgba(156, 39, 176, 0.1), rgba(240, 98, 146, 0.05));
            padding: 25px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border-color);
        }

        .section-header h2 {
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            font-weight: 700;
            font-size: 24px;
            margin: 0;
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
            background: linear-gradient(to bottom, var(--secondary-color), var(--accent-color));
            border-radius: 2px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 16px;
            background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background: linear-gradient(90deg, var(--blue-500), var(--purple-500));
        }

        /* Enhanced Table Styles */
        .table-container {
            overflow-x: auto;
            padding: 0;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        th, td {
            padding: 16px 20px;
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

        /* Styled price column */
        td:nth-child(4) {
            font-weight: 600;
            color: var(--accent-color);
        }

        /* Styled date column */
        td:nth-child(2) {
            color: var(--text-dark);
            font-weight: 500;
        }

        /* Payment status styling */
        .payment-status {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
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

        .status-failed {
            background-color: rgba(229, 62, 62, 0.15);
            color: var(--red-500);
        }

        .status-failed::before {
            content: '\f057';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .empty-message {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
            font-style: italic;
        }

        .empty-message i {
            font-size: 48px;
            color: var(--accent-light);
            margin-bottom: 20px;
            display: block;
        }

        .empty-message p {
            font-size: 16px;
            margin-bottom: 10px;
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
            }

            .section-header {
                padding: 20px;
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            th, td {
                padding: 12px 15px;
            }

            .empty-message {
                padding: 40px 20px;
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
    <a href="${pageContext.request.contextPath}/client/payments" class="active">Payments</a>
    <a href="${pageContext.request.contextPath}/client/reviews">My Reviews</a>
    <a href="${pageContext.request.contextPath}/client/profile">My Profile</a>
</div>

<div class="container">
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="section-header">
        <h2>Payment History</h2>
    </div>

    <div class="table-container">
        <c:choose>
            <c:when test="${empty payments}">
                <div class="empty-message">
                    <i class="fas fa-credit-card"></i>
                    <p>No payment records found.</p>
                    <p>Your payment history will appear here after making a purchase.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Date</th>
                        <th>Service</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${payments}" var="payment">
                        <tr>
                            <td>${payment.id}</td>
                            <td>${payment.formattedPaymentDate}</td>
                            <td>${payment.serviceName}</td>
                            <td>$${payment.amount}</td>
                            <td>
                                <span class="payment-status status-${payment.status.toLowerCase()}">${payment.status}</span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/client/payment/invoice/${payment.id}" class="btn btn-secondary">
                                    <i class="fas fa-file-invoice"></i> View Invoice
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>