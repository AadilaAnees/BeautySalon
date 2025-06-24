<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Reviews - Elegant Beauty Salon</title>
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
            margin: 0 auto;
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

        .btn-warning {
            background: linear-gradient(45deg, var(--orange-500), var(--orange-500));
            box-shadow: 0 4px 10px rgba(237, 137, 54, 0.3);
        }

        .btn-warning:hover {
            box-shadow: 0 6px 15px rgba(237, 137, 54, 0.4);
        }

        .btn-danger {
            background: linear-gradient(45deg, var(--red-500), var(--red-500));
            box-shadow: 0 4px 10px rgba(229, 62, 62, 0.3);
        }

        .btn-danger:hover {
            box-shadow: 0 6px 15px rgba(229, 62, 62, 0.4);
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

        select.filter-btn {
            cursor: pointer;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 16px;
            padding-right: 40px;
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

        .empty-message {
            text-align: center;
            padding: 20px;
            color: var(--text-muted);
            font-style: italic;
        }

        .star {
            color: #ffc107;
            font-size: 18px;
        }

        .rating-stars {
            white-space: nowrap;
        }

        .review-status {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        .status-approved {
            background-color: rgba(72, 187, 120, 0.15);
            color: var(--green-500);
        }

        .status-pending {
            background-color: rgba(237, 137, 54, 0.15);
            color: var(--orange-500);
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .action-buttons a {
            margin-bottom: 5px;
        }

        /* Review Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: var(--white);
            padding: 30px;
            border-radius: 12px;
            max-width: 600px;
            width: 100%;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: var(--shadow-xl);
        }

        .review-card {
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            background-color: var(--white);
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .review-service {
            font-weight: bold;
            font-size: 18px;
            color: var(--primary-color);
            font-family: 'Playfair Display', serif;
        }

        .review-client {
            font-size: 16px;
            margin-top: 5px;
            color: var(--text-dark);
        }

        .review-date {
            color: var(--text-muted);
            font-size: 14px;
        }

        .review-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .review-comment {
            margin-bottom: 20px;
            line-height: 1.6;
            background-color: rgba(0, 0, 0, 0.02);
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid var(--secondary-color);
            color: var(--text-dark);
        }

        .review-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
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

            .action-buttons {
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
                <a href="${pageContext.request.contextPath}/admin/appointments" class="nav-link">
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
                <a href="${pageContext.request.contextPath}/admin/reviews" class="nav-link active">
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
                <p>Manage customer reviews</p>
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
                <h2>Manage Reviews</h2>
            </div>

            <div style="padding: 20px;">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search by customer name, service or review content...">
                    <button class="btn" onclick="searchReviews()">
                        <i class="fas fa-search"></i> Search
                    </button>
                </div>

                <div class="filter-section">
                    <button class="filter-btn active" onclick="filterByStatus('all')">All Reviews</button>
                    <button class="filter-btn" onclick="filterByStatus('pending')">Pending Approval</button>
                    <button class="filter-btn" onclick="filterByStatus('approved')">Approved</button>
                    <select id="ratingFilter" onchange="filterByRating(this.value)" class="filter-btn">
                        <option value="all">All Ratings</option>
                        <option value="5">5 Stars</option>
                        <option value="4">4 Stars</option>
                        <option value="3">3 Stars</option>
                        <option value="2">2 Stars</option>
                        <option value="1">1 Star</option>
                    </select>
                </div>

                <!-- Table View -->
                <div class="table-responsive">
                    <table id="reviewsTable">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Service</th>
                            <th>Rating</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty reviews}">
                            <tr>
                                <td colspan="7" class="empty-message">No reviews found</td>
                            </tr>
                        </c:if>

                        <c:forEach items="${reviews}" var="review">
                            <tr data-status="${review.approved ? 'approved' : 'pending'}" data-rating="${review.rating}" data-id="${review.id}">
                                <td>${review.id}</td>
                                <td>${review.userName}</td>
                                <td>${review.serviceName}</td>
                                <td class="rating-stars">
                                    <c:forEach begin="1" end="5" var="star">
                                        <span class="star">${star <= review.rating ? '★' : '☆'}</span>
                                    </c:forEach>
                                </td>
                                <td>${review.formattedReviewDate}</td>
                                <td>
                                    <span class="review-status ${review.approved ? 'status-approved' : 'status-pending'}">
                                            ${review.approved ? 'Approved' : 'Pending'}
                                    </span>
                                </td>
                                <td class="action-buttons">
                                    <c:if test="${!review.approved}">
                                        <a href="${pageContext.request.contextPath}/admin/review/approve/${review.id}" class="btn">
                                            <i class="fas fa-check"></i> Approve
                                        </a>
                                    </c:if>

                                    <c:if test="${review.approved}">
                                        <a href="${pageContext.request.contextPath}/admin/review/reject/${review.id}" class="btn btn-warning">
                                            <i class="fas fa-times"></i> Reject
                                        </a>
                                    </c:if>

                                    <a href="${pageContext.request.contextPath}/admin/review/delete/${review.id}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this review?')">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>

                                    <a href="#" class="btn btn-secondary" onclick="showReviewDetails('${review.id}')">
                                        <i class="fas fa-eye"></i> View
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

<!-- Review Detail Modal -->
<div id="reviewModal" class="modal">
    <div class="modal-content">
        <div id="reviewDetails"></div>
        <div style="text-align: right; margin-top: 20px;">
            <button onclick="hideReviewDetails()" class="btn btn-secondary">Close</button>
        </div>
    </div>
</div>

<script>
    // Search functionality
    function searchReviews() {
        const searchInput = document.getElementById('searchInput').value.toLowerCase();
        const rows = document.querySelectorAll('#reviewsTable tbody tr');

        rows.forEach(row => {
            if (row.classList.contains('empty-message')) return;

            const customerName = row.cells[1].textContent.toLowerCase();
            const serviceName = row.cells[2].textContent.toLowerCase();
            // For comment search, we would need to add data attributes with comment content or use another approach

            if (customerName.includes(searchInput) || serviceName.includes(searchInput)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });

        checkNoResults();
    }

    // Filter by status (all, pending, approved)
    function filterByStatus(status) {
        const rows = document.querySelectorAll('#reviewsTable tbody tr');

        // Update active button
        document.querySelectorAll('.filter-section button').forEach(btn => {
            if (btn.textContent.toLowerCase().includes(status)) {
                btn.classList.add('active');
            } else {
                btn.classList.remove('active');
            }
        });

        rows.forEach(row => {
            if (row.querySelector('.empty-message')) return;

            const rowStatus = row.getAttribute('data-status');

            if (status === 'all' || rowStatus === status) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });

        checkNoResults();
    }

    // Filter by rating
    function filterByRating(rating) {
        const rows = document.querySelectorAll('#reviewsTable tbody tr');

        rows.forEach(row => {
            if (row.querySelector('.empty-message')) return;

            const rowRating = row.getAttribute('data-rating');

            if (rating === 'all' || rowRating === rating) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });

        checkNoResults();
    }

    // Check if there are any visible results
    function checkNoResults() {
        const tbody = document.querySelector('#reviewsTable tbody');
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
            noResultsCell.setAttribute('colspan', '7');
            noResultsCell.className = 'empty-message';
            noResultsCell.textContent = 'No reviews found matching the filter criteria';
            noResultsRow.appendChild(noResultsCell);
            tbody.appendChild(noResultsRow);
        }
    }

    // Show review details in modal
    function showReviewDetails(reviewId) {
        // Find the row with the matching review ID
        const row = document.querySelector(`tr[data-id="${reviewId}"]`);

        if (row) {
            const customerId = row.cells[1].textContent;
            const serviceName = row.cells[2].textContent;
            const rating = row.cells[3].innerHTML;
            const date = row.cells[4].textContent;
            const status = row.cells[5].innerHTML;

            // Create a simulated comment for demo purposes
            const reviewComment = "This is a placeholder for the review comment. In a real application, " +
                "this would be fetched from the server or stored as a data attribute. " +
                "The comment would contain the customer's detailed feedback about their experience with our service.";

            const detailsHTML = `
           <h3 style="font-family: 'Playfair Display', serif; margin-bottom: 20px; color: var(--primary-color);">Review Details</h3>
           <div class="review-card">
               <div class="review-header">
                   <div>
                       <div class="review-service">${serviceName}</div>
                       <div class="review-client">By: ${customerId}</div>
                   </div>
                   <div class="review-date">${date}</div>
               </div>

               <div class="review-meta">
                   <div class="review-rating">${rating}</div>
                   ${status}
               </div>

               <div class="review-comment">${reviewComment}</div>

               <div class="review-actions">
                   <a href="${pageContext.request.contextPath}/admin/review/approve/${reviewId}" class="btn">
                       <i class="fas fa-check"></i> Approve
                   </a>
                   <a href="${pageContext.request.contextPath}/admin/review/reject/${reviewId}" class="btn btn-warning">
                       <i class="fas fa-times"></i> Reject
                   </a>
                   <a href="${pageContext.request.contextPath}/admin/review/delete/${reviewId}" class="btn btn-danger"
                      onclick="return confirm('Are you sure you want to delete this review?')">
                       <i class="fas fa-trash"></i> Delete
                   </a>
               </div>
           </div>
       `;

            document.getElementById('reviewDetails').innerHTML = detailsHTML;
        } else {
            document.getElementById('reviewDetails').innerHTML = '<p>Review details not found.</p>';
        }

        document.getElementById('reviewModal').style.display = 'flex';
    }

    // Hide review details modal
    function hideReviewDetails() {
        document.getElementById('reviewModal').style.display = 'none';
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
        const modal = document.getElementById('reviewModal');
        if (event.target === modal) {
            hideReviewDetails();
        }
    };
    </script>
    </body>
    </html>