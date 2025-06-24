<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Salon Booking System</title>
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
            content: '\f007'; /* User icon */
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .payment-wrapper {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-lg);
            overflow: hidden;
        }

        .alert {
            padding: 16px;
            margin-bottom: 24px;
            border-radius: 8px;
            font-weight: 500;
            box-shadow: var(--shadow-sm);
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

        .alert-danger {
            background-color: rgba(229, 62, 62, 0.1);
            color: var(--red-500);
            border-left: 4px solid var(--red-500);
        }

        .alert-danger::before {
            content: '\f071'; /* Warning icon */
            color: var(--red-500);
        }

        .section-header {
            background: linear-gradient(to right, rgba(156, 39, 176, 0.1), rgba(240, 98, 146, 0.05));
            padding: 25px 30px;
            border-bottom: 1px solid var(--border-color);
        }

        .section-header h2 {
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            margin-bottom: 8px;
            font-weight: 700;
            font-size: 24px;
        }

        .section-header p {
            color: var(--text-light);
            font-size: 15px;
        }

        .order-summary {
            background-color: #f9fafc;
            padding: 25px 30px;
            border-bottom: 1px solid var(--border-color);
        }

        .order-summary h3 {
            margin-top: 0;
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            margin-bottom: 20px;
            font-weight: 600;
            font-size: 20px;
            position: relative;
            padding-left: 15px;
        }

        .order-summary h3::before {
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

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px dashed var(--border-color);
            font-size: 15px;
        }

        .summary-item:last-of-type {
            border-bottom: none;
            padding-bottom: 0;
            margin-bottom: 0;
        }

        .summary-item span:first-child {
            color: var(--text-light);
            font-weight: 500;
        }

        .summary-item span:last-child {
            font-weight: 600;
            color: var(--text-dark);
        }

        .summary-total {
            font-weight: bold;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 2px solid var(--border-color);
            font-size: 16px;
        }

        .summary-total span:first-child {
            color: var(--primary-color) !important;
            font-size: 18px;
        }

        .summary-total span:last-child {
            color: var(--accent-color) !important;
            font-size: 20px;
        }

        .payment-content {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text-dark);
            font-size: 15px;
        }

        input[type="text"],
        input[type="number"],
        input[type="email"],
        select {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-family: 'Inter', sans-serif;
            font-size: 15px;
            color: var(--text-dark);
            background-color: #f9fafc;
            transition: all 0.3s ease;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(156, 39, 176, 0.1);
        }
        .payment-methods {
            display: flex;
            margin-bottom: 25px;
            border-bottom: 1px solid var(--border-color);
        }

        .payment-method {
            flex: 1;
            text-align: center;
            padding: 15px;
            cursor: pointer;
            font-weight: 600;
            color: var(--text-light);
            border-bottom: 3px solid transparent;
            transition: all 0.3s ease;
        }

        .payment-method.active {
            color: var(--secondary-color);
            border-bottom-color: var(--secondary-color);
        }

        .payment-method i {
            margin-right: 8px;
            font-size: 18px;
        }

        .payment-section {
            display: none;
        }

        .payment-section.active {
            display: block;
        }

        .cash-payment {
            background-color: #f9fafc;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 25px;
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .cash-payment::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: linear-gradient(to bottom, var(--green-500), var(--blue-500));
            border-radius: 0 3px 3px 0;
        }

        .cash-payment h3 {
            margin-top: 0;
            margin-bottom: 20px;
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            font-size: 20px;
            font-weight: 600;
            position: relative;
            padding-left: 15px;
        }

        .cash-payment h3::before {
            content: '\f3d1';  /* Money bill icon */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 10px;
            color: var(--green-500);
        }

        .cash-payment p {
            margin-bottom: 15px;
            line-height: 1.7;
        }

        .cash-instructions {
            background-color: rgba(66, 153, 225, 0.1);
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
            border-left: 4px solid var(--blue-500);
        }

        .cash-instructions h4 {
            color: var(--blue-500);
            margin-top: 0;
            margin-bottom: 10px;
            font-size: 16px;
        }

        .cash-instructions ul {
            margin: 0;
            padding-left: 20px;
        }

        .cash-instructions li {
            margin-bottom: 5px;
        }

        .credit-card {
            background-color: #f9fafc;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 25px;
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .credit-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: linear-gradient(to bottom, var(--secondary-color), var(--accent-color));
            border-radius: 0 3px 3px 0;
        }

        .credit-card h3 {
            margin-top: 0;
            margin-bottom: 20px;
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            font-size: 20px;
            font-weight: 600;
            position: relative;
            padding-left: 15px;
        }

        .credit-card h3::before {
            content: '\f09d';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 10px;
            color: var(--accent-color);
        }

        .card-input {
            position: relative;
        }

        .card-icon {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }

        .expiry-cvv {
            display: flex;
            gap: 20px;
        }

        .expiry-cvv > div {
            flex: 1;
        }

        .buttons {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 14px 28px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            box-shadow: var(--shadow-sm);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            color: white;
            flex: 1;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background-color: #f3f4f6;
            color: var(--text-dark);
        }

        .btn-secondary:hover {
            background-color: #e5e7eb;
            transform: translateY(-2px);
        }

        .card-number-input {
            padding-right: 45px;
            letter-spacing: 0.5px;
            font-family: 'Courier New', monospace;
        }

        .payment-icons {
            display: flex;
            gap: 8px;
            margin-top: 5px;
        }

        .payment-icons i {
            font-size: 24px;
            color: var(--text-muted);
        }

        .payment-icons i.fa-cc-visa {
            color: #1a1f71;
        }

        .payment-icons i.fa-cc-mastercard {
            color: #eb001b;
        }

        .payment-icons i.fa-cc-amex {
            color: #006fcf;
        }

        .payment-icons i.fa-cc-discover {
            color: #ff6000;
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
                padding: 0 15px;
                margin: 20px auto;
            }

            .expiry-cvv {
                flex-direction: column;
                gap: 15px;
            }

            .buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                padding: 12px;
            }

            .section-header, .order-summary, .payment-content {
                padding: 20px;
            }
        }

        @media (max-width: 480px) {
            .expiry-cvv {
                flex-direction: column;
                gap: 15px;
            }

            .credit-card {
                padding: 20px;
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

<div class="container">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="payment-wrapper">
        <div class="section-header">
            <h2>Complete Your Payment</h2>
            <p>Secure payment to confirm your appointment</p>
        </div>

        <div class="order-summary">
            <h3>Order Summary</h3>
            <div id="serviceSummary">
                <!-- This will be populated by JavaScript -->
            </div>
        </div>

        <div class="payment-content">
            <div class="payment-methods">
                <div class="payment-method active" id="card-tab" onclick="switchPaymentMethod('card')">
                    <i class="fas fa-credit-card"></i> Card Payment
                </div>
                <div class="payment-method" id="cash-tab" onclick="switchPaymentMethod('cash')">
                    <i class="fas fa-money-bill-wave"></i> Cash Payment
                </div>
            </div>
            <form id="paymentForm" action="${pageContext.request.contextPath}/client/payment/process" method="post">
                <!-- Hidden fields for appointment data -->
                <input type="hidden" id="serviceId" name="serviceId" value="">
                <input type="hidden" id="appointmentDate" name="appointmentDate" value="">
                <input type="hidden" id="appointmentTime" name="appointmentTime" value="">
                <input type="hidden" id="notes" name="notes" value="">
                <input type="hidden" id="amount" name="amount" value="">
                <input type="hidden" id="serviceName" name="serviceName" value="">
                <input type="hidden" id="paymentMethod" name="paymentMethod" value="CARD">


                <!-- Card Payment Section -->
                <div class="payment-section active" id="card-payment">
                    <div class="credit-card">
                        <h3>Card Information</h3>

                        <div class="form-group">
                            <label for="cardHolderName">Card Holder Name</label>
                            <input type="text" id="cardHolderName" name="cardHolderName" placeholder="Name as it appears on your card">
                        </div>

                        <div class="form-group card-input">
                            <label for="cardNumber">Card Number</label>
                            <input type="text" id="cardNumber" name="cardNumber" class="card-number-input" placeholder="1234 5678 9012 3456" maxlength="19">
                            <div class="card-icon">
                                <i class="fas fa-credit-card"></i>
                            </div>
                        </div>

                        <div class="payment-icons">
                            <i class="fab fa-cc-visa"></i>
                            <i class="fab fa-cc-mastercard"></i>
                            <i class="fab fa-cc-amex"></i>
                            <i class="fab fa-cc-discover"></i>
                        </div>

                        <div class="expiry-cvv">
                            <div class="form-group">
                                <label for="expiryDate">Expiry Date</label>
                                <input type="text" id="expiryDate" placeholder="MM/YY" maxlength="5">
                            </div>

                            <div class="form-group">
                                <label for="cvv">CVV Code</label>
                                <input type="text" id="cvv" placeholder="123" maxlength="4">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Cash Payment Section -->
                <div class="payment-section" id="cash-payment">
                    <div class="cash-payment">
                        <h3>Pay with Cash</h3>
                        <p>You've selected to pay in cash at the salon during your appointment. Your appointment will be reserved, but payment status will remain pending until completed at the salon.</p>

                        <div class="cash-instructions">
                            <h4><i class="fas fa-info-circle"></i> Instructions</h4>
                            <ul>
                                <li>Please arrive 10 minutes before your appointment time</li>
                                <li>Bring the exact amount in cash</li>
                                <li>Payment will be collected before your service begins</li>
                                <li>You will receive a receipt after payment</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="buttons">
                    <button type="submit" class="btn btn-primary" id="payButton">
                        <i class="fas fa-lock"></i> Confirm Booking
                    </button>
                    <a href="${pageContext.request.contextPath}/client/appointment/book" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Load appointment data from session storage
    window.addEventListener('DOMContentLoaded', function() {
        const serviceId = sessionStorage.getItem('serviceId');
        const servicePrice = sessionStorage.getItem('servicePrice');
        const serviceName = sessionStorage.getItem('serviceName');
        const appointmentDate = sessionStorage.getItem('appointmentDate');
        const appointmentTime = sessionStorage.getItem('appointmentTime');
        const notes = sessionStorage.getItem('notes');

        // Populate hidden fields
        document.getElementById('serviceId').value = serviceId || '';
        document.getElementById('appointmentDate').value = appointmentDate || '';
        document.getElementById('appointmentTime').value = appointmentTime || '';
        document.getElementById('notes').value = notes || '';
        document.getElementById('amount').value = servicePrice || '';
        document.getElementById('serviceName').value = serviceName || '';

        // Format appointment date for display
        let formattedDate = '';
        if (appointmentDate) {
            const dateParts = appointmentDate.split('-');
            const date = new Date(dateParts[0], dateParts[1] - 1, dateParts[2]);
            formattedDate = date.toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
        }


        // Format appointment time for display
        let formattedTime = '';
        if (appointmentTime) {
            const timeParts = appointmentTime.split(':');
            const hours = parseInt(timeParts[0]);
            const minutes = parseInt(timeParts[1]);

            const ampm = hours >= 12 ? 'PM' : 'AM';
            const hours12 = hours % 12 || 12;

            formattedTime = `${hours12}:${minutes.toString().padStart(2, '0')} ${ampm}`;
        }

        // Create summary HTML
        const summaryHTML = `
                <div class="summary-item">
                    <span>Service:</span>
                    <span>${serviceName || 'Unknown service'}</span>
                </div>
                <div class="summary-item">
                    <span>Date:</span>
                    <span>${formattedDate || 'Unknown date'}</span>
                </div>
                <div class="summary-item">
                    <span>Time:</span>
                    <span>${formattedTime || 'Unknown time'}</span>
                </div>
                <div class="summary-item summary-total">
                    <span>Total:</span>
                    <span>$${servicePrice || '0'}</span>
                </div>
            `;

        // Update the summary
        document.getElementById('serviceSummary').innerHTML = summaryHTML;
    });

    // Format card number with spaces
    document.getElementById('cardNumber').addEventListener('input', function(e) {
        const value = e.target.value.replace(/\s+/g, '');
        const formatted = value.replace(/(\d{4})/g, '$1 ').trim();
        e.target.value = formatted;
    });

    // Format expiry date with slash
    document.getElementById('expiryDate').addEventListener('input', function(e) {
        const value = e.target.value.replace(/\D/g, '');
        if (value.length > 2) {
            e.target.value = value.substring(0, 2) + '/' + value.substring(2);
        } else {
            e.target.value = value;
        }
    });

    // Switch between payment methods
    function switchPaymentMethod(method) {
        // Update tabs
        document.getElementById('card-tab').classList.remove('active');
        document.getElementById('cash-tab').classList.remove('active');
        document.getElementById(method + '-tab').classList.add('active');

        // Update sections
        document.getElementById('card-payment').classList.remove('active');
        document.getElementById('cash-payment').classList.remove('active');
        document.getElementById(method + '-payment').classList.add('active');

        // Update hidden field
        document.getElementById('paymentMethod').value = method.toUpperCase();

        // Update button text and validation
        if (method === 'card') {
            document.getElementById('payButton').innerHTML = '<i class="fas fa-lock"></i> Pay Now';
        } else {
            document.getElementById('payButton').innerHTML = '<i class="fas fa-check"></i> Confirm Booking';
        }
    }

    // Validate form on submit
    document.getElementById('paymentForm').addEventListener('submit', function(e) {
        const paymentMethod = document.getElementById('paymentMethod').value;

        if (paymentMethod === 'CARD') {
            const cardNumber = document.getElementById('cardNumber').value.replace(/\s+/g, '');
            if (!cardNumber) {
                alert('Please enter a card number');
                e.preventDefault();
                return;
            }

            if (cardNumber.length < 13 || cardNumber.length > 19) {
                alert('Please enter a valid card number');
                e.preventDefault();
                return;
            }

            const cardHolderName = document.getElementById('cardHolderName').value;
            if (!cardHolderName) {
                alert('Please enter the card holder name');
                e.preventDefault();
                return;
            }

            const expiryDate = document.getElementById('expiryDate').value;
            if (!expiryDate || !expiryDate.match(/^\d{2}\/\d{2}$/)) {
                alert('Please enter a valid expiry date (MM/YY)');
                e.preventDefault();
                return;
            }

            const cvv = document.getElementById('cvv').value;
            if (!cvv || cvv.length < 3) {
                alert('Please enter a valid CVV');
                e.preventDefault();
                return;
            }
        }
    });
</script>
</body>
</html>