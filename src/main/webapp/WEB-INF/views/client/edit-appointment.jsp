<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Appointment - Salon Booking System</title>
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

        .btn-danger {
            background: linear-gradient(135deg, #e53e3e, #f56565);
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #c53030, #e53e3e);
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

        .appointment-info {
            background-color: #f9fafc;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            position: relative;
            overflow: hidden;
        }

        .appointment-info::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: linear-gradient(to bottom, var(--secondary-color), var(--accent-color));
        }

        .appointment-info p {
            margin: 12px 0;
            display: flex;
            align-items: center;
        }

        .appointment-info p strong {
            display: inline-block;
            width: 100px;
            color: var(--primary-color);
        }

        .appointment-status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 12px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 14px;
        }

        .status-pending {
            background-color: var(--yellow-100);
            color: var(--yellow-500);
        }

        .status-pending::before {
            content: '\f017';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .status-confirmed {
            background-color: var(--green-100);
            color: var(--green-500);
        }

        .status-confirmed::before {
            content: '\f00c';
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
            content: '\f007'; /* User icon */
        }

        /* Edit page specific styles */
        .edit-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
        }

        .edit-header i {
            font-size: 20px;
            color: var(--secondary-color);
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
<div class="header">
    <h1>Salon Booking System</h1>
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
    <a href="${pageContext.request.contextPath}/client/appointments" class="active">My Appointments</a>
    <a href="${pageContext.request.contextPath}/client/profile">My Profile</a>
</div>

<div class="container">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="section-header">
        <h2>Edit Appointment</h2>
        <p>Update the date, time, or notes for your appointment.</p>
    </div>

    <div class="appointment-info">
        <div class="edit-header">
            <i class="fas fa-spa"></i>
            <h3>Appointment Details</h3>
        </div>
        <p><strong>Service:</strong> ${service.name}</p>
        <p><strong>Price:</strong> $${appointment.price}</p>
        <p><strong>Duration:</strong> ${service.durationMinutes} minutes</p>
        <p><strong>Status:</strong> <span class="appointment-status status-${appointment.status.toLowerCase()}">${appointment.status}</span></p>
    </div>

    <form id="editForm" action="${pageContext.request.contextPath}/client/appointment/update" method="post">
        <input type="hidden" name="id" value="${appointment.id}">

        <!-- Edit Date -->
        <div class="form-group">
            <label for="appointmentDate"><i class="fas fa-calendar-alt"></i> Date:</label>
            <input type="date" id="appointmentDate" name="appointmentDate"
                   value="${appointment.appointmentDate}"
                   min="${minDate}" required>
        </div>

        <!-- Edit Time - Fixed time slots dropdown -->
        <div class="form-group">
            <label for="appointmentTime"><i class="fas fa-clock"></i> Time:</label>
            <select id="appointmentTime" name="appointmentTime" required>
                <option value="">-- Select a Time Slot --</option>
                <option value="08:00" ${appointment.appointmentTime.toString().startsWith('08:') ? 'selected' : ''}>8:00 AM - 10:00 AM</option>
                <option value="10:00" ${appointment.appointmentTime.toString().startsWith('10:') ? 'selected' : ''}>10:00 AM - 12:00 PM</option>
                <option value="12:00" ${appointment.appointmentTime.toString().startsWith('12:') ? 'selected' : ''}>12:00 PM - 2:00 PM</option>
                <option value="14:00" ${appointment.appointmentTime.toString().startsWith('14:') ? 'selected' : ''}>2:00 PM - 4:00 PM</option>
                <option value="16:00" ${appointment.appointmentTime.toString().startsWith('16:') ? 'selected' : ''}>4:00 PM - 6:00 PM</option>
            </select>
        </div>

        <!-- Edit Notes -->
        <div class="form-group">
            <label for="notes"><i class="fas fa-sticky-note"></i> Additional Notes (Optional):</label>
            <textarea id="notes" name="notes" placeholder="Any special requests or information for your appointment">${appointment.notes}</textarea>
        </div>

        <div class="buttons">
            <button type="submit" class="btn">
                <i class="fas fa-save"></i> Update Appointment
            </button>
            <a href="${pageContext.request.contextPath}/client/appointments" class="btn btn-secondary">
                <i class="fas fa-times"></i> Cancel
            </a>
            <a href="${pageContext.request.contextPath}/client/appointment/cancel/${appointment.id}" class="btn btn-danger" onclick="return confirm('Are you sure you want to cancel this appointment?')">
                <i class="fas fa-ban"></i> Cancel Appointment
            </a>
        </div>
    </form>
</div>

<script>
    // Form validation
    document.getElementById('editForm').addEventListener('submit', function(event) {
        const appointmentDate = document.getElementById('appointmentDate').value;
        const appointmentTime = document.getElementById('appointmentTime').value;

        if (!appointmentDate || !appointmentTime) {
            event.preventDefault();
            alert('Please complete all required fields');
        }
    });
</script>
</body>
</html>