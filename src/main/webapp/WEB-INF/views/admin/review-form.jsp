<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${isNewReview ? 'Write a Review' : 'Edit Review'} - Salon Booking System</title>
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
        .section-header {
            margin-bottom: 20px;
        }
        .section-header h2 {
            margin: 0;
            margin-bottom: 10px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
            min-height: 150px;
            resize: vertical;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #2196F3;
        }
        .btn-secondary:hover {
            background-color: #0b7dda;
        }
        .btn-cancel {
            background-color: #f2f2f2;
            color: #333;
        }
        .btn-cancel:hover {
            background-color: #ddd;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .alert-danger {
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
        .star-rating {
            margin-bottom: 20px;
        }
        .star-rating input[type="radio"] {
            display: none;
        }
        .star-rating label {
            display: inline-block;
            cursor: pointer;
            font-size: 30px;
            color: #ccc;
            transition: color 0.2s;
        }
        .star-rating label:hover,
        .star-rating label:hover ~ label,
        .star-rating input[type="radio"]:checked ~ label {
            color: #ffc107;
        }
        .char-count {
            float: right;
            font-size: 14px;
            color: #666;
            margin-top: 5px;
        }
        .form-note {
            font-size: 14px;
            color: #666;
            margin-top: 10px;
        }
        .service-info {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="header">
    <h1>Salon Booking System</h1>
    <div class="user-info">
        <span>Welcome, ${user.username}</span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
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
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="section-header">
        <h2>${isNewReview ? 'Write a Review' : 'Edit Your Review'}</h2>
        <p>Share your experience with our services. Your feedback helps us improve!</p>
    </div>

    <c:if test="${not empty review.serviceName}">
        <div class="service-info">
            <strong>Service:</strong> ${review.serviceName}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/client/review/save" method="post">
        <input type="hidden" name="id" value="${review.id}" />
        <input type="hidden" name="userId" value="${review.userId}" />
        <input type="hidden" name="userName" value="${review.userName}" />
        <input type="hidden" name="serviceId" value="${review.serviceId}" />
        <input type="hidden" name="serviceName" value="${review.serviceName}" />

        <div class="form-group">
            <label>Your Rating</label>
            <div class="star-rating">
                <input type="radio" id="star5" name="rating" value="5" ${review.rating == 5 ? 'checked' : ''} />
                <label for="star5" title="5 stars">★</label>

                <input type="radio" id="star4" name="rating" value="4" ${review.rating == 4 ? 'checked' : ''} />
                <label for="star4" title="4 stars">★</label>

                <input type="radio" id="star3" name="rating" value="3" ${review.rating == 3 ? 'checked' : ''} />
                <label for="star3" title="3 stars">★</label>

                <input type="radio" id="star2" name="rating" value="2" ${review.rating == 2 ? 'checked' : ''} />
                <label for="star2" title="2 stars">★</label>

                <input type="radio" id="star1" name="rating" value="1" ${review.rating == 1 ? 'checked' : ''} />
                <label for="star1" title="1 star">★</label>
            </div>
        </div>

        <div class="form-group">
            <label for="comment">Your Review</label>
            <textarea id="comment" name="comment" placeholder="Share details about your experience..."
                      required maxlength="1000" oninput="updateCharCount()">${review.comment}</textarea>
            <div class="char-count"><span id="charCount">0</span>/1000 characters</div>
        </div>

        <div style="margin-top: 30px;">
            <button type="submit" class="btn">${isNewReview ? 'Submit Review' : 'Update Review'}</button>
            <a href="${pageContext.request.contextPath}/client/reviews" class="btn btn-cancel" style="margin-left: 10px;">Cancel</a>
        </div>

        <p class="form-note">
            Your review will be visible after admin approval. We reserve the right to remove
            inappropriate content.
        </p>
    </form>
</div>

<script>
    // Update character count for the comment textarea
    function updateCharCount() {
        const comment = document.getElementById('comment');
        const charCount = document.getElementById('charCount');

        charCount.textContent = comment.value.length;

        // Change color when approaching limit
        if (comment.value.length > 900) {
            charCount.style.color = '#f44336';
        } else {
            charCount.style.color = '#666';
        }
    }

    // Initialize character count on page load
    window.onload = function() {
        updateCharCount();
    };
</script>
</body>
</html>