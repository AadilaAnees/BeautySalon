<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Reviews - Elegant Beauty Salon</title>
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
            max-width: 1000px;
            margin: 30px auto;
            background-color: var(--white);
            padding: 30px;
            border-radius: 12px;
            box-shadow: var(--shadow-lg);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            position: relative;
            padding-left: 15px;
        }

        .section-header h2 {
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

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
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
            background: linear-gradient(135deg, var(--blue-500), #64b5f6);
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #3687cf, #5aa7e7);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--red-500), #f87171);
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #d32f2f, #ef5350);
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

        .alert-success {
            background-color: var(--green-100);
            color: var(--green-500);
            border-left: 4px solid var(--green-500);
        }

        .alert-success::before {
            content: '\f058';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
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

        .empty-message {
            text-align: center;
            padding: 30px;
            color: var(--text-muted);
            font-style: italic;
            background-color: rgba(0, 0, 0, 0.02);
            border-radius: 8px;
            margin: 20px 0;
        }

        .review-card {
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .review-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }

        .review-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(to bottom, var(--secondary-color), var(--accent-color));
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .review-service {
            font-weight: 700;
            font-size: 18px;
            color: var(--primary-color);
            font-family: 'Playfair Display', serif;
        }

        .review-date {
            color: var(--text-muted);
            font-size: 14px;
        }

        .review-rating {
            margin-bottom: 15px;
        }

        .star {
            color: #ffc107;
            font-size: 18px;
        }

        .review-comment {
            margin-bottom: 20px;
            line-height: 1.6;
            color: var(--text-dark);
            background-color: rgba(0, 0, 0, 0.02);
            padding: 15px;
            border-radius: 8px;
        }

        .review-status {
            font-size: 13px;
            padding: 5px 12px;
            border-radius: 20px;
            display: inline-block;
            margin-bottom: 15px;
            font-weight: 500;
        }

        .status-approved {
            background-color: var(--green-100);
            color: var(--green-500);
        }

        .status-pending {
            background-color: var(--yellow-100);
            color: var(--yellow-500);
        }

        .review-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .tabs {
            display: flex;
            margin-bottom: 25px;
            border-bottom: 1px solid var(--border-color);
        }

        .tab {
            padding: 12px 20px;
            cursor: pointer;
            border: 1px solid transparent;
            margin-bottom: -1px;
            transition: all 0.3s ease;
            font-weight: 500;
            color: var(--text-light);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .tab:hover {
            color: var(--secondary-color);
        }

        .tab.active {
            border: 1px solid var(--border-color);
            border-bottom: 1px solid white;
            border-radius: 8px 8px 0 0;
            background-color: white;
            color: var(--secondary-color);
            font-weight: 600;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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

            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .section-header h2 {
                margin-bottom: 10px;
            }

            .tabs {
                overflow-x: auto;
                padding-bottom: 5px;
            }

            .tab {
                padding: 10px 15px;
                white-space: nowrap;
            }

            .review-actions {
                flex-direction: column;
            }

            .review-actions a {
                width: 100%;
                text-align: center;
                justify-content: center;
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
    <a href="${pageContext.request.contextPath}/client/payments">Payments</a>
    <a href="${pageContext.request.contextPath}/client/reviews" class="active">My Reviews</a>
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
        <h2>My Reviews</h2>
        <a href="${pageContext.request.contextPath}/client/review/add" class="btn">
            <i class="fas fa-plus"></i> Write New Review
        </a>
    </div>

    <div class="tabs">
        <div class="tab active" onclick="showTab('all')">
            <i class="fas fa-list"></i> All Reviews
        </div>
        <div class="tab" onclick="showTab('approved')">
            <i class="fas fa-check-circle"></i> Approved
        </div>
        <div class="tab" onclick="showTab('pending')">
            <i class="fas fa-clock"></i> Pending Approval
        </div>
    </div>

    <div id="all" class="tab-content active">
        <c:if test="${empty reviews}">
            <div class="empty-message">
                <i class="fas fa-comment-slash fa-2x" style="margin-bottom: 10px;"></i>
                <p>You haven't written any reviews yet.</p>
            </div>
        </c:if>

        <c:forEach items="${reviews}" var="review">
            <div class="review-card" data-status="${review.approved ? 'approved' : 'pending'}">
                <div class="review-header">
                    <div class="review-service">${review.serviceName}</div>
                    <div class="review-date">
                        <i class="fas fa-calendar-alt"></i> ${review.formattedReviewDate}
                    </div>
                </div>

                <div class="review-status ${review.approved ? 'status-approved' : 'status-pending'}">
                    <i class="fas ${review.approved ? 'fa-check-circle' : 'fa-clock'}"></i>
                        ${review.approved ? 'Approved' : 'Pending Approval'}
                </div>

                <div class="review-rating">
                    <c:forEach begin="1" end="5" var="star">
                        <span class="star">${star <= review.rating ? '★' : '☆'}</span>
                    </c:forEach>
                </div>

                <div class="review-comment">
                        ${review.comment}
                </div>

                <div class="review-actions">
                    <a href="${pageContext.request.contextPath}/client/review/edit/${review.id}" class="btn btn-secondary">
                        <i class="fas fa-edit"></i> Edit
                    </a>
                    <a href="${pageContext.request.contextPath}/client/review/delete/${review.id}" class="btn btn-danger"
                       onclick="return confirm('Are you sure you want to delete this review?')">
                        <i class="fas fa-trash"></i> Delete
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>

    <div id="approved" class="tab-content">
        <c:set var="hasApproved" value="false" />

        <c:forEach items="${reviews}" var="review">
            <c:if test="${review.approved}">
                <c:set var="hasApproved" value="true" />
                <div class="review-card">
                    <div class="review-header">
                        <div class="review-service">${review.serviceName}</div>
                        <div class="review-date">
                            <i class="fas fa-calendar-alt"></i> ${review.formattedReviewDate}
                        </div>
                    </div>

                    <div class="review-status status-approved">
                        <i class="fas fa-check-circle"></i> Approved
                    </div>

                    <div class="review-rating">
                        <c:forEach begin="1" end="5" var="star">
                            <span class="star">${star <= review.rating ? '★' : '☆'}</span>
                        </c:forEach>
                    </div>

                    <div class="review-comment">
                            ${review.comment}
                    </div>

                    <div class="review-actions">
                        <a href="${pageContext.request.contextPath}/client/review/edit/${review.id}" class="btn btn-secondary">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <a href="${pageContext.request.contextPath}/client/review/delete/${review.id}" class="btn btn-danger"
                           onclick="return confirm('Are you sure you want to delete this review?')">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>

        <c:if test="${!hasApproved}">
            <div class="empty-message">
                <i class="fas fa-check-circle fa-2x" style="margin-bottom: 10px;"></i>
                <p>You don't have any approved reviews yet.</p>
            </div>
        </c:if>
    </div>

    <div id="pending" class="tab-content">
        <c:set var="hasPending" value="false" />

        <c:forEach items="${reviews}" var="review">
            <c:if test="${!review.approved}">
                <c:set var="hasPending" value="true" />
                <div class="review-card">
                    <div class="review-header">
                        <div class="review-service">${review.serviceName}</div>
                        <div class="review-date">
                            <i class="fas fa-calendar-alt"></i> ${review.formattedReviewDate}
                        </div>
                    </div>

                    <div class="review-status status-pending">
                        <i class="fas fa-clock"></i> Pending Approval
                    </div>

                    <div class="review-rating">
                        <c:forEach begin="1" end="5" var="star">
                            <span class="star">${star <= review.rating ? '★' : '☆'}</span>
                        </c:forEach>
                    </div>

                    <div class="review-comment">
                            ${review.comment}
                    </div>

                    <div class="review-actions">
                        <a href="${pageContext.request.contextPath}/client/review/edit/${review.id}" class="btn btn-secondary">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <a href="${pageContext.request.contextPath}/client/review/delete/${review.id}" class="btn btn-danger"
                           onclick="return confirm('Are you sure you want to delete this review?')">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>

        <c:if test="${!hasPending}">
            <div class="empty-message">
                <i class="fas fa-hourglass-half fa-2x" style="margin-bottom: 10px;"></i>
                <p>You don't have any pending reviews.</p>
            </div>
        </c:if>
    </div>
</div>

<script>
    function showTab(tabId) {
        // Hide all tab contents
        document.querySelectorAll('.tab-content').forEach(content => {
            content.classList.remove('active');
        });

        // Show the selected tab content
        document.getElementById(tabId).classList.add('active');

        // Update tab styling
        document.querySelectorAll('.tab').forEach(tab => {
            tab.classList.remove('active');
        });

        // Find the clicked tab and activate it
        document.querySelectorAll('.tab').forEach(tab => {
            if (tab.textContent.toLowerCase().includes(tabId)) {
                tab.classList.add('active');
            }
        });
    }
</script>
</body>
</html>