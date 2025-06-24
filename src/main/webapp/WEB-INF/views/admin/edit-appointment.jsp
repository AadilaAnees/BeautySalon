<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Appointment - Elegant Beauty Salon</title>
    <!-- Google Fonts - Poppins -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #f06292;
            --primary-light: #f8bbd0;
            --primary-dark: #c2185b;
            --secondary: #7e57c2;
            --secondary-light: #b39ddb;
            --secondary-dark: #4d2c91;
            --dark: #292639;
            --darker: #1a1725;
            --light: #ffffff;
            --gray-light: #f5f5f5;
            --gray: #e0e0e0;
            --text-primary: #212121;
            --text-secondary: #757575;
            --success: #66bb6a;
            --warning: #ffca28;
            --danger: #ef5350;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: var(--darker);
            color: var(--light);
            font-family: 'Poppins', sans-serif;
            line-height: 1.6;
        }

        .header {
            background-color: var(--dark);
            color: var(--light);
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            margin: 0;
            font-size: 24px;
            font-weight: 600;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-info span {
            margin-right: 15px;
        }

        .logout-btn {
            background: linear-gradient(45deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 500;
            box-shadow: 0 4px 10px rgba(240, 98, 146, 0.3);
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(240, 98, 146, 0.4);
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 0 20px;
        }

        .content-card {
            background-color: var(--dark);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            margin-bottom: 2rem;
        }

        .section-header {
            background-color: rgba(0, 0, 0, 0.2);
            padding: 1.5rem;
            position: relative;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .section-header h2 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--light);
            margin: 0 0 10px 0;
            position: relative;
            padding-left: 1rem;
        }

        .section-header h2::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 4px;
            background: linear-gradient(to bottom, var(--primary), var(--secondary));
            border-radius: 4px;
        }

        .section-header p {
            color: var(--text-secondary);
            margin: 0;
            padding-left: 1rem;
        }

        .navbar {
            background-color: var(--dark);
            overflow: hidden;
            margin: 15px auto;
            border-radius: 8px;
            max-width: 800px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .navbar a {
            float: left;
            display: block;
            color: var(--light);
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .navbar a:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .navbar a.active {
            background: linear-gradient(45deg, var(--primary), var(--primary-dark));
            color: white;
        }

        .form-content {
            padding: 1.5rem;
        }

        .user-card {
            background-color: rgba(255, 255, 255, 0.05);
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .user-card h3 {
            margin-top: 0;
            margin-bottom: 1rem;
            color: var(--light);
            font-size: 1.2rem;
            font-weight: 600;
            position: relative;
            padding-left: 1rem;
        }

        .user-card h3::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 3px;
            background: linear-gradient(to bottom, var(--secondary), var(--secondary-light));
            border-radius: 4px;
        }

        .user-card p {
            margin: 0.5rem 0;
            color: var(--light);
        }

        .service-details {
            background-color: rgba(126, 87, 194, 0.1);
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(126, 87, 194, 0.2);
        }

        .service-details h3 {
            margin-top: 0;
            margin-bottom: 1rem;
            color: var(--light);
            font-size: 1.2rem;
            font-weight: 600;
            position: relative;
            padding-left: 1rem;
        }

        .service-details h3::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 3px;
            background: linear-gradient(to bottom, var(--primary), var(--primary-light));
            border-radius: 4px;
        }

        .service-details p {
            margin: 0.5rem 0;
            color: var(--light);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--light);
        }

        select, input[type="date"], textarea {
            width: 100%;
            padding: 0.75rem 1rem;
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            color: var(--light);
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        select:focus, input[type="date"]:focus, textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(240, 98, 146, 0.2);
        }

        select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%23ffffff' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            background-size: 1rem;
            padding-right: 2.5rem;
        }

        select option {
            background-color: var(--dark);
            color: var(--light);
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .status-select option.status-pending {
            color: var(--warning);
        }

        .status-select option.status-confirmed {
            color: var(--success);
        }

        .status-select option.status-completed {
            color: var(--secondary-light);
        }

        .status-select option.status-cancelled {
            color: var(--danger);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            text-decoration: none;
            font-family: 'Poppins', sans-serif;
        }

        .btn-primary {
            background: linear-gradient(45deg, var(--primary), var(--primary-dark));
            color: white;
            box-shadow: 0 4px 10px rgba(240, 98, 146, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(240, 98, 146, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(45deg, var(--secondary), var(--secondary-dark));
            color: white;
            box-shadow: 0 4px 10px rgba(126, 87, 194, 0.3);
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(126, 87, 194, 0.4);
        }

        .btn-danger {
            background: linear-gradient(45deg, var(--danger), #d32f2f);
            color: white;
            box-shadow: 0 4px 10px rgba(239, 83, 80, 0.3);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(239, 83, 80, 0.4);
        }

        .buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .alert {
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border-radius: 8px;
            font-weight: 500;
        }

        .alert-danger {
            background-color: rgba(239, 83, 80, 0.15);
            color: var(--danger);
            border-left: 4px solid var(--danger);
        }

        /* Responsive styles */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }

            .user-info {
                flex-direction: column;
                gap: 0.5rem;
            }

            .user-info span {
                margin-right: 0;
            }

            .buttons {
                flex-direction: column;
                width: 100%;
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
    <h1>Elegant Beauty Salon - Admin</h1>
    <div class="user-info">
        <span>Welcome, Admin</span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/admin/dashboard">
        <i class="fas fa-tachometer-alt"></i> Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/admin/services">
        <i class="fas fa-cut"></i> Services
    </a>
    <a href="${pageContext.request.contextPath}/admin/appointments" class="active">
        <i class="fas fa-calendar-alt"></i> Appointments
    </a>
    <a href="${pageContext.request.contextPath}/admin/user/add">
        <i class="fas fa-users"></i> Users
    </a>
</div>

<div class="container">
    <div class="content-card">
        <div class="section-header">
            <h2>Edit Appointment #${appointment.id}</h2>
            <p>Update appointment details and status</p>
        </div>

        <div class="form-content">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="user-card">
                <h3>Client Information</h3>
                <p><strong>Name:</strong> ${appointment.userName}</p>
            </div>

            <div class="service-details">
                <h3>Service Information</h3>
                <p><strong>Service:</strong> ${service.name}</p>
                <p><strong>Price:</strong> $${appointment.price}</p>
                <p><strong>Duration:</strong> ${service.durationMinutes} minutes</p>
            </div>

            <form id="editForm" action="${pageContext.request.contextPath}/admin/appointment/update" method="post">
                <input type="hidden" name="id" value="${appointment.id}">

                <!-- Client Selection (optional reassignment) -->
                <div class="form-group">
                    <label for="userId">Client:</label>
                    <select id="userId" name="userId" required>
                        <c:forEach items="${clients}" var="client">
                            <option value="${client.id}" ${client.id == appointment.userId ? 'selected' : ''}>
                                    ${client.username} (${client.email})
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Date -->
                <div class="form-group">
                    <label for="appointmentDate">Date:</label>
                    <input type="date" id="appointmentDate" name="appointmentDate"
                           value="${appointment.appointmentDate}"
                           min="${minDate}" required>
                </div>

                <!-- Time - Fixed time slots dropdown -->
                <div class="form-group">
                    <label for="appointmentTime">Time:</label>
                    <select id="appointmentTime" name="appointmentTime" required>
                        <option value="">-- Select a Time Slot --</option>
                        <option value="08:00" ${appointment.appointmentTime.toString().startsWith('08:') ? 'selected' : ''}>8:00 AM - 10:00 AM</option>
                        <option value="10:00" ${appointment.appointmentTime.toString().startsWith('10:') ? 'selected' : ''}>10:00 AM - 12:00 PM</option>
                        <option value="12:00" ${appointment.appointmentTime.toString().startsWith('12:') ? 'selected' : ''}>12:00 PM - 2:00 PM</option>
                        <option value="14:00" ${appointment.appointmentTime.toString().startsWith('14:') ? 'selected' : ''}>2:00 PM - 4:00 PM</option>
                        <option value="16:00" ${appointment.appointmentTime.toString().startsWith('16:') ? 'selected' : ''}>4:00 PM - 6:00 PM</option>
                    </select>
                </div>

                <!-- Status -->
                <div class="form-group">
                    <label for="status">Status:</label>
                    <select id="status" name="status" class="status-select">
                        <option value="PENDING" ${appointment.status == 'PENDING' ? 'selected' : ''} class="status-pending">Pending</option>
                        <option value="CONFIRMED" ${appointment.status == 'CONFIRMED' ? 'selected' : ''} class="status-confirmed">Confirmed</option>
                        <option value="COMPLETED" ${appointment.status == 'COMPLETED' ? 'selected' : ''} class="status-completed">Completed</option>
                        <option value="CANCELLED" ${appointment.status == 'CANCELLED' ? 'selected' : ''} class="status-cancelled">Cancelled</option>
                    </select>
                </div>

                <!-- Notes -->
                <div class="form-group">
                    <label for="notes">Notes:</label>
                    <textarea id="notes" name="notes" placeholder="Additional notes or comments">${appointment.notes}</textarea>
                </div>

                <div class="buttons">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Update Appointment
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/appointments" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/appointment/delete/${appointment.id}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this appointment? This action cannot be undone.')">
                        <i class="fas fa-trash"></i> Delete Appointment
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Form validation
    document.getElementById('editForm').addEventListener('submit', function(event) {
        const userId = document.getElementById('userId').value;
        const appointmentDate = document.getElementById('appointmentDate').value;
        const appointmentTime = document.getElementById('appointmentTime').value;

        if (!userId || !appointmentDate || !appointmentTime) {
            event.preventDefault();
            alert('Please complete all required fields');
        }
    });
</script>
</body>
</html>