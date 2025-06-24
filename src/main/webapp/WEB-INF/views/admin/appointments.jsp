<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Appointments - Elegant Beauty Salon</title>
    <!-- Google Fonts - Poppins and Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:wght@400;600;700;800&display=swap" rel="stylesheet">
    <!-- Font Awesome for icons -->
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
        }

        .logo {
            font-size: 24px;
            font-weight: 800;
            font-family: 'Playfair Display', serif;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo::before {
            content: "●";
            color: var(--accent-color);
            font-size: 28px;
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

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 32px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .header-title h1 {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-color);
            font-family: 'Playfair Display', serif;
        }

        .header-title p {
            color: var(--text-light);
            margin-top: 4px;
        }

        .user-section {
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .admin-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-weight: 600;
            font-size: 16px;
        }

        .logout-btn {
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            color: var(--white);
            padding: 8px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            box-shadow: var(--shadow-md);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .container {
            max-width: 1280px;
            margin: 20px auto;
            padding: 0 20px;
        }

        .content-card {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
            overflow: hidden;
            transition: all 0.3s ease;
            margin-bottom: 2rem;
        }

        .content-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .section-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: linear-gradient(90deg, rgba(156, 39, 176, 0.05) 0%, rgba(240, 98, 146, 0.05) 100%);
        }

        .section-header h2 {
            font-family: 'Playfair Display', serif;
            font-weight: 600;
            color: var(--primary-color);
            margin: 0;
            position: relative;
        }

        .btn {
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            color: white;
            border: none;
            padding: 0.6rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            text-decoration: none;
            box-shadow: var(--shadow-md);
            cursor: pointer;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(45deg, var(--secondary-color), var(--secondary-color));
            box-shadow: 0 4px 10px rgba(126, 87, 194, 0.3);
        }

        .btn-secondary:hover {
            box-shadow: 0 6px 15px rgba(126, 87, 194, 0.4);
        }

        .btn-danger {
            background: linear-gradient(45deg, var(--red-500), var(--red-500));
            box-shadow: 0 4px 10px rgba(239, 83, 80, 0.3);
        }

        .btn-danger:hover {
            box-shadow: 0 6px 15px rgba(239, 83, 80, 0.4);
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 500;
        }

        .alert-success {
            background-color: rgba(102, 187, 106, 0.15);
            color: var(--green-500);
            border-left: 4px solid var(--green-500);
        }

        .alert-danger {
            background-color: rgba(239, 83, 80, 0.15);
            color: var(--red-500);
            border-left: 4px solid var(--red-500);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            color: var(--text-dark);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background-color: rgba(0, 0, 0, 0.03);
            color: var(--text-dark);
            font-weight: 500;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        tr:hover {
            background-color: rgba(156, 39, 176, 0.03);
        }

        .search-box {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }

        .search-box input {
            flex-grow: 1;
            padding: 12px 16px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            background-color: var(--white);
            color: var(--text-dark);
            font-family: 'Inter', sans-serif;
        }

        .search-box input::placeholder {
            color: var(--text-muted);
        }

        .search-box input:focus {
            outline: none;
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 2px rgba(156, 39, 176, 0.2);
        }

        .filter-section {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 8px 15px;
            background-color: var(--white);
            color: var(--text-dark);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            cursor: pointer;
            font-family: 'Inter', sans-serif;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .filter-btn:hover {
            background-color: rgba(156, 39, 176, 0.05);
        }

        .filter-btn.active {
            background: linear-gradient(45deg, var(--secondary-color), var(--accent-color));
            color: white;
            border: 1px solid transparent;
        }

        .date-picker {
            padding: 8px 15px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            background-color: var(--white);
            color: var(--text-dark);
            font-family: 'Inter', sans-serif;
        }

        .date-picker:focus {
            outline: none;
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 2px rgba(156, 39, 176, 0.2);
        }

        .status-pending {
            color: var(--orange-500);
            font-weight: bold;
        }

        .status-confirmed {
            color: var(--green-500);
            font-weight: bold;
        }

        .status-cancelled {
            color: var(--red-500);
            font-weight: bold;
        }

        .status-completed {
            color: var(--blue-500);
            font-weight: bold;
        }

        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .actions a {
            margin-bottom: 5px;
        }

        .dropdown-status {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: var(--white);
            min-width: 160px;
            box-shadow: var(--shadow-lg);
            z-index: 1;
            border-radius: 8px;
            overflow: hidden;
        }

        .dropdown-content a {
            color: var(--text-dark);
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            transition: all 0.3s ease;
        }

        .dropdown-content a:hover {
            background-color: rgba(156, 39, 176, 0.05);
        }

        .dropdown-status:hover .dropdown-content {
            display: block;
        }

        .empty-message, .no-results-message td {
            text-align: center;
            padding: 20px;
            color: var(--text-muted);
            font-style: italic;
        }

        .today-highlight {
            background-color: rgba(126, 87, 194, 0.1) !important;
        }

        /* Responsive styles */
        @media (max-width: 1200px) {
            .sidebar {
                width: 70px;
            }

            .sidebar-header {
                padding: 16px;
            }

            .logo {
                font-size: 0;
                justify-content: center;
            }

            .logo::before {
                font-size: 24px;
            }

            .nav-link {
                padding: 12px;
                justify-content: center;
            }

            .nav-link span {
                display: none;
            }

            .main-content {
                margin-left: 70px;
                padding: 20px;
            }
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }

            .user-section {
                flex-direction: column;
                gap: 10px;
            }

            .filter-section {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                flex-direction: column;
            }

            .actions {
                flex-direction: column;
            }

            table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-wrapper">
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="logo">Elegant Beauty Salon</div>
        </div>
        <nav class="nav-menu">
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">
                    <div class="nav-icon">📊</div>
                    <span>Dashboard</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/services" class="nav-link">
                    <div class="nav-icon">✂️</div>
                    <span>Services</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/appointments" class="nav-link active">
                    <div class="nav-icon">📅</div>
                    <span>Appointments</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/payments" class="nav-link">
                    <div class="nav-icon">💰</div>
                    <span>Payments</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/user-dashboard" class="nav-link">
                    <div class="nav-icon">👥</div>
                    <span>Users</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/reviews" class="nav-link">
                    <div class="nav-icon">⭐</div>
                    <span>Reviews</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/reports" class="nav-link">
                    <div class="nav-icon">📈</div>
                    <span>Reports</span>
                </a>
            </div>
        </nav>
    </div>

    <div class="main-content">
        <div class="header">
            <div class="header-title">
                <h1>Elegant Beauty Salon - Admin</h1>
                <p>Manage salon appointments</p>
            </div>
            <div class="user-section">
                <div class="admin-avatar">A</div>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="content-card">
            <div class="section-header">
                <h2>Manage Appointments</h2>
            </div>

            <div style="padding: 20px;">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search by client name, service or date...">
                    <button class="btn" onclick="searchAppointments()">
                        <i class="fas fa-search"></i> Search
                    </button>
                </div>

                <div class="filter-section">
                    <button class="filter-btn active" onclick="filterByTime('all')">All</button>
                    <button class="filter-btn" onclick="filterByTime('today')">Today</button>
                    <button class="filter-btn" onclick="filterByTime('upcoming')">Upcoming</button>
                    <button class="filter-btn" onclick="filterByTime('past')">Past</button>
                    <input type="date" class="date-picker" id="dateFilter" onchange="filterByDate(this.value)">
                    <button class="filter-btn" onclick="filterByStatus('all')">All Status</button>
                    <button class="filter-btn" onclick="filterByStatus('PENDING')">Pending</button>
                    <button class="filter-btn" onclick="filterByStatus('CONFIRMED')">Confirmed</button>
                    <button class="filter-btn" onclick="filterByStatus('COMPLETED')">Completed</button>
                    <button class="filter-btn" onclick="filterByStatus('CANCELLED')">Cancelled</button>
                </div>

                <div class="table-responsive">
                    <table id="appointmentsTable">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Client</th>
                            <th>Service</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="currentDate" value="<%= java.time.LocalDate.now() %>" />

                        <c:if test="${empty appointments}">
                            <tr>
                                <td colspan="8" class="empty-message">No appointments found</td>
                            </tr>
                        </c:if>

                        <c:forEach items="${appointments}" var="appointment">
                            <tr data-date="${appointment.appointmentDate}" data-status="${appointment.status}"
                                class="${appointment.appointmentDate != null && appointment.appointmentDate.equals(currentDate) ? 'today-highlight' : ''}">
                                <td>${appointment.id}</td>
                                <td>${appointment.userName}</td>
                                <td>${appointment.serviceName}</td>
                                <td>${appointment.formattedDate}</td>
                                <td>${appointment.formattedTime}</td>
                                <td>$${appointment.price}</td>
                                <td class="status-${appointment.status.toLowerCase()}">${appointment.status}</td>
                                <td class="actions">
                                    <a href="${pageContext.request.contextPath}/admin/appointment/edit/${appointment.id}" class="btn btn-secondary">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>

                                    <div class="dropdown-status">
                                        <button class="btn">
                                            <i class="fas fa-cog"></i> Status
                                        </button>
                                        <div class="dropdown-content">
                                            <a href="${pageContext.request.contextPath}/admin/appointment/change-status/${appointment.id}/PENDING">Pending</a>
                                            <a href="${pageContext.request.contextPath}/admin/appointment/change-status/${appointment.id}/CONFIRMED">Confirm</a>
                                            <a href="${pageContext.request.contextPath}/admin/appointment/change-status/${appointment.id}/COMPLETED">Complete</a>
                                            <a href="${pageContext.request.contextPath}/admin/appointment/change-status/${appointment.id}/CANCELLED">Cancel</a>
                                        </div>
                                    </div>

                                    <a href="${pageContext.request.contextPath}/admin/appointment/delete/${appointment.id}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this appointment?')">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Search functionality
    function searchAppointments() {
        const searchInput = document.getElementById('searchInput').value.toLowerCase();
        const rows = document.querySelectorAll('#appointmentsTable tbody tr');

        rows.forEach(row => {
            if (row.classList.contains('empty-message')) return;

            const clientName = row.cells[1].textContent.toLowerCase();
            const serviceName = row.cells[2].textContent.toLowerCase();
            const date = row.cells[3].textContent.toLowerCase();

            if (clientName.includes(searchInput) || serviceName.includes(searchInput) || date.includes(searchInput)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });

        checkNoResults();
    }

    // Filter by time (all, today, upcoming, past)
    function filterByTime(timeFilter) {
        const rows = document.querySelectorAll('#appointmentsTable tbody tr');
        const today = new Date().toISOString().split('T')[0];

        // Update active button
        document.querySelectorAll('.filter-section button').forEach(btn => {
            if (btn.textContent.toLowerCase() === timeFilter) {
                btn.classList.add('active');
            } else if (btn.textContent.toLowerCase() !== 'all status' &&
                btn.textContent.toLowerCase() !== 'pending' &&
                btn.textContent.toLowerCase() !== 'confirmed' &&
                btn.textContent.toLowerCase() !== 'completed' &&
                btn.textContent.toLowerCase() !== 'cancelled') {
                btn.classList.remove('active');
            }
        });

        rows.forEach(row => {
            if (row.classList.contains('empty-message')) return;

            const dateAttr = row.getAttribute('data-date');

            if (timeFilter === 'all') {
                row.style.display = '';
            } else if (timeFilter === 'today' && dateAttr === today) {
                row.style.display = '';
            } else if (timeFilter === 'upcoming' && dateAttr >= today) {
                row.style.display = '';
            } else if (timeFilter === 'past' && dateAttr < today) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });

        checkNoResults();
    }

    // Filter by specific date
    function filterByDate(date) {
        const rows = document.querySelectorAll('#appointmentsTable tbody tr');

        // Update active button
        document.querySelectorAll('.filter-section button').forEach(btn => {
            if (btn.textContent.toLowerCase() !== 'all status' &&
                btn.textContent.toLowerCase() !== 'pending' &&
                btn.textContent.toLowerCase() !== 'confirmed' &&
                btn.textContent.toLowerCase() !== 'completed' &&
                btn.textContent.toLowerCase() !== 'cancelled') {
                btn.classList.remove('active');
            }
        });

        rows.forEach(row => {
            if (row.classList.contains('empty-message')) return;

            const dateAttr = row.getAttribute('data-date');

            if (date === '' || dateAttr === date) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });

        checkNoResults();
    }

    // Filter by status
    function filterByStatus(status) {
        const rows = document.querySelectorAll('#appointmentsTable tbody tr');

        // Update active button for status filters
        document.querySelectorAll('.filter-section button').forEach(btn => {
            if (btn.textContent.toLowerCase() === status.toLowerCase() ||
                (btn.textContent.toLowerCase() === 'all status' && status === 'all')) {
                btn.classList.add('active');
            } else if (btn.textContent.toLowerCase() === 'all status' ||
                btn.textContent.toLowerCase() === 'pending' ||
                btn.textContent.toLowerCase() === 'confirmed' ||
                btn.textContent.toLowerCase() === 'completed' ||
                btn.textContent.toLowerCase() === 'cancelled') {
                btn.classList.remove('active');
            }
        });

        rows.forEach(row => {
            if (row.classList.contains('empty-message')) return;

            const statusAttr = row.getAttribute('data-status');

            if (status === 'all' || statusAttr === status) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });

        checkNoResults();
    }

    // Check if there are any visible results
    function checkNoResults() {
        const tbody = document.querySelector('#appointmentsTable tbody');
        const visibleRows = tbody.querySelectorAll('tr:not([style*="display: none"]):not(.empty-message)');

        // Remove existing "no results" message if it exists
        const existingNoResults = tbody.querySelector('.no-results-message');
        if (existingNoResults) {
            tbody.removeChild(existingNoResults);
        }

        if (visibleRows.length === 0) {
            const noResultsRow = document.createElement('tr');
            noResultsRow.className = 'no-results-message';
            const noResultsCell = document.createElement('td');
            noResultsCell.setAttribute('colspan', '8');
            noResultsCell.className = 'empty-message';
            noResultsCell.textContent = 'No appointments found matching the filter criteria';
            noResultsRow.appendChild(noResultsCell);
            tbody.appendChild(noResultsRow);
        }
    }
</script>
</body>
</html>