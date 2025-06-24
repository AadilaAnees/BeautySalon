<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Invoice - Salon Booking System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .header {
            background-color: #333;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            margin: 0;
            font-size: 24px;
        }
        .user-info {
            display: flex;
            align-items: center;
        }
        .user-info span {
            margin-right: 15px;
        }
        .logout-btn {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .invoice-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .invoice-header h2 {
            color: #333;
            margin-bottom: 5px;
        }
        .invoice-header p {
            color: #666;
            margin: 0;
        }
        .invoice-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
        }
        .invoice-info div {
            flex: 1;
        }
        .invoice-info h3 {
            margin-top: 0;
            margin-bottom: 10px;
            color: #333;
            font-size: 16px;
        }
        .invoice-info p {
            margin: 5px 0;
            color: #666;
        }
        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        .invoice-table th {
            background-color: #f2f2f2;
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .invoice-table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .invoice-total {
            text-align: right;
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-right: 10px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-print {
            background-color: #2196F3;
        }
        .btn-print:hover {
            background-color: #0b7dda;
        }
        .btn-warning {
            background-color: #ff9800;
        }
        .btn-warning:hover {
            background-color: #e68a00;
        }
        .payment-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 14px;
            margin-bottom: 20px;
        }
        .status-successful {
            background-color: #d4edda;
            color: #155724;
        }
        .status-refunded {
            background-color: #f8d7da;
            color: #721c24;
        }
        .navbar {
            background-color: #f2f2f2;
            overflow: hidden;
            margin-bottom: 20px;
        }
        .navbar a {
            float: left;
            display: block;
            color: #333;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }
        .navbar a:hover, .navbar a.active {
            background-color: #ddd;
        }
        .invoice-footer {
            margin-top: 50px;
            border-top: 1px solid #eee;
            padding-top: 20px;
            text-align: center;
            color: #666;
            font-size: 14px;
        }
        .buttons {
            margin-top: 30px;
            text-align: center;
        }
        @media print {
            .header, .navbar, .buttons {
                display: none;
            }
            .container {
                box-shadow: none;
                margin: 0;
                padding: 0;
            }
            body {
                background-color: white;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <h1>Salon Booking System - Admin</h1>
    <div class="user-info">
        <span>Welcome, Admin</span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
    </div>
</div>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/services">Services</a>
    <a href="${pageContext.request.contextPath}/admin/appointments">Appointments</a>
    <a href="${pageContext.request.contextPath}/admin/payments" class="active">Payments</a>
    <a href="${pageContext.request.contextPath}/admin/user-dashboard">Users</a>
</div>

<div class="container" id="invoice">
    <div class="invoice-header">
        <h2>INVOICE</h2>
        <p>Invoice #${payment.id}</p>
        <p>Date: ${payment.formattedPaymentDate}</p>
        <div class="payment-status status-${payment.status.toLowerCase()}">${payment.status}</div>
    </div>

    <div class="invoice-info">
        <div>
            <h3>From</h3>
            <p><strong>Salon Booking System</strong></p>
            <p>123 Beauty Street</p>
            <p>Anywhere, CA 12345</p>
            <p>Phone: (123) 456-7890</p>
            <p>Email: info@salonbooking.com</p>
        </div>

        <div>
            <h3>To</h3>
            <p><strong>${payment.userName}</strong></p>
            <p>Customer ID: ${payment.userId}</p>
            <c:if test="${not empty appointment}">
                <p>Appointment Date: ${appointment.formattedDate}</p>
                <p>Appointment Time: ${appointment.formattedTime}</p>
                <p>Appointment ID: ${appointment.id}</p>
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
        <p>Payment processed by Salon Booking System</p>
        <p>Card: ${payment.cardNumber}</p>
        <p>Card Holder: ${payment.cardHolderName}</p>
    </div>

    <div class="buttons">
        <button class="btn btn-print" onclick="window.print()">Print Invoice</button>

        <c:if test="${payment.status == 'SUCCESSFUL'}">
            <a href="${pageContext.request.contextPath}/admin/payment/refund/${payment.id}" class="btn btn-warning" onclick="return confirm('Are you sure you want to refund this payment?')">Refund Payment</a>
        </c:if>

        <a href="${pageContext.request.contextPath}/admin/payments" class="btn">Back to Payments</a>
    </div>
</div>
</body>
</html>