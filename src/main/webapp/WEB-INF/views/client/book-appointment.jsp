<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - Salon Booking System</title>
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
            margin: 0;
            padding: 0;
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
            font-size: 24px;
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
            background-color: var(--accent-color);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 6px;
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

        .container {
            max-width: 800px;
            margin: 30px auto;
            background-color: var(--white);
            padding: 30px;
            border-radius: 12px;
            box-shadow: var(--shadow-lg);
        }

        .section-header {
            margin-bottom: 30px;
            position: relative;
            padding-left: 15px;
        }

        .section-header h2 {
            margin: 0 0 10px 0;
            color: var(--primary-color);
            font-family: 'Playfair Display', serif;
            position: relative;
        }

        .section-header h2::before {
            content: '';
            position: absolute;
            left: -15px;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 24px;
            background: linear-gradient(to bottom, var(--secondary-color), var(--accent-color));
            border-radius: 2px;
        }

        .section-header p {
            color: var(--text-light);
            font-size: 15px;
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

        select, input[type="date"], textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #f9fafc;
            color: var(--text-dark);
        }

        select:focus, input[type="date"]:focus, textarea:focus {
            outline: none;
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(156, 39, 176, 0.1);
        }

        textarea {
            height: 120px;
            resize: vertical;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-md);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #64748b, #94a3b8);
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #475569, #64748b);
        }

        .buttons {
            margin-top: 30px;
            display: flex;
            gap: 15px;
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

        .alert-danger {
            background-color: var(--red-100);
            color: var(--red-500);
            border-left: 4px solid var(--red-500);
        }

        .alert-danger::before {
            content: '\f071';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
        }

        .service-details {
            background-color: #f9fafc;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .service-details::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: linear-gradient(to bottom, var(--secondary-color), var(--accent-color));
        }

        .service-name {
            font-weight: 600;
            font-size: 18px;
            color: var(--primary-color);
            margin-bottom: 5px;
        }

        .service-price {
            color: var(--accent-color);
            font-weight: 600;
            margin: 8px 0;
            font-size: 16px;
        }

        .service-duration {
            color: var(--text-light);
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .service-duration::before {
            content: '\f017';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .navbar {
            background-color: var(--white);
            overflow: hidden;
            margin-bottom: 0;
            box-shadow: var(--shadow-md);
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

        /* Booking steps */
        .booking-steps {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            position: relative;
        }

        .booking-steps::before {
            content: '';
            position: absolute;
            top: 15px;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: var(--border-color);
            z-index: 1;
        }

        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 2;
            background-color: var(--white);
            padding: 0 10px;
        }

        .step-number {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .step-text {
            font-size: 13px;
            color: var(--text-light);
            font-weight: 500;
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
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
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
                padding: 20px;
                margin: 20px 15px;
            }

            .booking-steps {
                overflow-x: auto;
                padding-bottom: 10px;
                justify-content: flex-start;
                gap: 30px;
            }

            .buttons {
                flex-direction: column;
                gap: 10px;
            }

            .btn {
                width: 100%;
                justify-content: center;
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
                <a href="${pageContext.request.contextPath}/client/profile" class="nav-link">
                    <div class="nav-icon">👤</div>
                    <span>My Profile</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/client/appointment/book" class="nav-link active">
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
<div class="header">
    <h1>Salon Booking System</h1>

</div>


<div class="container">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="section-header">
        <h2>Book an Appointment</h2>
        <p>Select a service and choose a date and time for your appointment.</p>
    </div>

    <div class="booking-steps">
        <div class="step">
            <div class="step-number">1</div>
            <div class="step-text">Select Service</div>
        </div>
        <div class="step">
            <div class="step-number">2</div>
            <div class="step-text">Choose Date</div>
        </div>
        <div class="step">
            <div class="step-number">3</div>
            <div class="step-text">Pick Time</div>
        </div>
        <div class="step">
            <div class="step-number">4</div>
            <div class="step-text">Add Notes</div>
        </div>
    </div>

    <form id="bookingForm" action="${pageContext.request.contextPath}/client/appointment/book" method="post">
        <!-- Step 1: Select Service -->
        <div class="form-group">
            <label for="serviceId"><i class="fas fa-spa"></i> Select Service:</label>
            <select id="serviceId" name="serviceId" required>
                <option value="">-- Select a Service --</option>
                <c:forEach items="${services}" var="service">
                    <option value="${service.id}"
                            data-price="${service.price}"
                            data-duration="${service.durationMinutes}"
                        ${selectedService != null && selectedService.id == service.id ? 'selected' : ''}>
                            ${service.name} - $${service.price} (${service.durationMinutes} min)
                    </option>
                </c:forEach>
            </select>
        </div>

        <div id="serviceDetails" class="service-details" style="display: none;">
            <div class="service-name" id="serviceName"></div>
            <div class="service-price">$<span id="servicePrice"></span></div>
            <div class="service-duration"><span id="serviceDuration"></span> minutes</div>
        </div>

        <!-- Step 2: Select Date -->
        <div class="form-group">
            <label for="appointmentDate"><i class="fas fa-calendar-alt"></i> Select Date:</label>
            <input type="date" id="appointmentDate" name="appointmentDate" min="${minDate}" required>
        </div>

        <!-- Step 3: Select Time -->
        <div class="form-group">
            <label for="appointmentTime"><i class="fas fa-clock"></i> Select Time:</label>
            <select id="appointmentTime" name="appointmentTime" required>
                <option value="">-- Select a Time Slot --</option>
                <option value="08:00">8:00 AM - 10:00 AM</option>
                <option value="10:00">10:00 AM - 12:00 PM</option>
                <option value="12:00">12:00 PM - 2:00 PM</option>
                <option value="14:00">2:00 PM - 4:00 PM</option>
                <option value="16:00">4:00 PM - 6:00 PM</option>
            </select>
        </div>

        <!-- Step 4: Additional Notes -->
        <div class="form-group">
            <label for="notes"><i class="fas fa-sticky-note"></i> Additional Notes (Optional):</label>
            <textarea id="notes" name="notes" placeholder="Any special requests or information for your appointment"></textarea>
        </div>

        <!-- Replace the buttons with this -->
        <div class="buttons">
            <button type="button" id="continueToPayment" class="btn">
                <i class="fas fa-credit-card"></i> Continue to Payment
            </button>
            <a href="${pageContext.request.contextPath}/client/appointments" class="btn btn-secondary">
                <i class="fas fa-times"></i> Cancel
            </a>
        </div>

        <!-- Hidden field to track if we're ready for payment -->
        <input type="hidden" id="proceedToPayment" name="proceedToPayment" value="false">
    </form>
</div>
</div>

<script>
    // Show service details when a service is selected
    document.getElementById('serviceId').addEventListener('change', function() {
        const selectedOption = this.options[this.selectedIndex];
        const serviceDetails = document.getElementById('serviceDetails');

        if (this.value) {
            // Display service details
            document.getElementById('serviceName').textContent = selectedOption.text.split(' - ')[0];
            document.getElementById('servicePrice').textContent = selectedOption.getAttribute('data-price');
            document.getElementById('serviceDuration').textContent = selectedOption.getAttribute('data-duration');
            serviceDetails.style.display = 'block';
        } else {
            serviceDetails.style.display = 'none';
        }
    });

    // Initialize service details if a service is pre-selected
    window.addEventListener('DOMContentLoaded', function() {
        const serviceSelect = document.getElementById('serviceId');
        if (serviceSelect.value) {
            const event = new Event('change');
            serviceSelect.dispatchEvent(event);
        }
    });

    // Form validation
    document.getElementById('bookingForm').addEventListener('submit', function(event) {
        const serviceId = document.getElementById('serviceId').value;
        const appointmentDate = document.getElementById('appointmentDate').value;
        const appointmentTime = document.getElementById('appointmentTime').value;

        if (!serviceId || !appointmentDate || !appointmentTime) {
            event.preventDefault();
            alert('Please complete all required fields');
        }
    });

    document.getElementById('continueToPayment').addEventListener('click', function() {
        const serviceId = document.getElementById('serviceId').value;
        const appointmentDate = document.getElementById('appointmentDate').value;
        const appointmentTime = document.getElementById('appointmentTime').value;

        if (!serviceId || !appointmentDate || !appointmentTime) {
            alert('Please complete all required fields');
            return;
        }

        // Collect form data
        const formData = new FormData(document.getElementById('bookingForm'));

        // Store appointment data in session storage
        sessionStorage.setItem('serviceId', serviceId);
        sessionStorage.setItem('servicePrice', document.getElementById('servicePrice').textContent);
        sessionStorage.setItem('serviceName', document.getElementById('serviceName').textContent);
        sessionStorage.setItem('appointmentDate', appointmentDate);
        sessionStorage.setItem('appointmentTime', appointmentTime);
        sessionStorage.setItem('notes', document.getElementById('notes').value);

        // Redirect to payment page
        window.location.href = "${pageContext.request.contextPath}/client/payment";
    });
</script>
</body>
</html>