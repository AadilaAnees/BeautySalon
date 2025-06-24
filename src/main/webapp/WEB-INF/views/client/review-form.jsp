<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isNewReview ? 'Write a Review' : 'Edit Review'} - Elegant Beauty Salon</title>
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

        textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #f9fafc;
            color: var(--text-dark);
            font-family: 'Inter', sans-serif;
            min-height: 150px;
            resize: vertical;
        }

        textarea:focus {
            outline: none;
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(156, 39, 176, 0.1);
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

        .btn-cancel {
            background: linear-gradient(135deg, #64748b, #94a3b8);
        }

        .btn-cancel:hover {
            background: linear-gradient(135deg, #475569, #64748b);
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

        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
            margin-bottom: 20px;
        }

        .star-rating input[type="radio"] {
            display: none;
        }

        .star-rating label {
            display: inline-block;
            cursor: pointer;
            font-size: 32px;
            padding: 0 5px;
            color: #ddd;
            transition: all 0.3s ease;
        }

        .star-rating label:hover,
        .star-rating label:hover ~ label,
        .star-rating input[type="radio"]:checked ~ label {
            color: #ffc107;
            transform: scale(1.1);
        }

        .char-count {
            float: right;
            font-size: 14px;
            color: var(--text-muted);
            margin-top: 5px;
        }

        .form-note {
            font-size: 14px;
            color: var(--text-muted);
            margin-top: 20px;
            padding: 12px;
            background-color: #f9fafc;
            border-radius: 8px;
            border-left: 3px solid var(--secondary-color);
        }

        .buttons {
            margin-top: 30px;
            display: flex;
            gap: 15px;
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
    <h1>Elegant Beauty Salon</h1>
    <div class="user-info">
        <span>Welcome, ${user.username}</span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/client/dashboard">
        Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/client/services">
        Services
    </a>
    <a href="${pageContext.request.contextPath}/client/appointments">
        My Appointments
    </a>
    <a href="${pageContext.request.contextPath}/client/payments">
        Payments
    </a>
    <a href="${pageContext.request.contextPath}/client/reviews" class="active">
        My Reviews
    </a>
    <a href="${pageContext.request.contextPath}/client/profile">
        My Profile
    </a>
</div>

<div class="container">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="section-header">
        <h2>${isNewReview ? 'Write a Review' : 'Edit Your Review'}</h2>
        <p>Share your experience with our services. Your feedback helps us improve!</p>
    </div>

    <form action="${pageContext.request.contextPath}/client/review/save" method="post">
        <!-- Hidden fields to maintain data -->
        <input type="hidden" name="id" value="${review.id}" />
        <input type="hidden" name="userId" value="${review.userId}" />
        <input type="hidden" name="userName" value="${review.userName}" />
        <input type="hidden" name="serviceId" value="${review.serviceId}" />
        <input type="hidden" name="serviceName" value="${review.serviceName}" />

        <div class="form-group">
            <label><i class="fas fa-star"></i> Your Rating</label>
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
            <label for="comment"><i class="fas fa-comment-alt"></i> Your Review</label>
            <textarea id="comment" name="comment" placeholder="Share details about your experience..."
                      required maxlength="1000" oninput="updateCharCount()">${review.comment}</textarea>
            <div class="char-count"><span id="charCount">0</span>/1000 characters</div>
        </div>

        <div class="buttons">
            <button type="submit" class="btn">
                <i class="fas fa-${isNewReview ? 'paper-plane' : 'save'}"></i>
                ${isNewReview ? 'Submit Review' : 'Update Review'}
            </button>
            <a href="${pageContext.request.contextPath}/client/reviews" class="btn btn-cancel">
                <i class="fas fa-times"></i> Cancel
            </a>
        </div>

        <p class="form-note">
            <i class="fas fa-info-circle"></i> Your review will be visible after admin approval.
            We reserve the right to remove inappropriate content.
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
            charCount.style.color = var(--red-500);
        } else {
            charCount.style.color = var(--text-muted);
        }
    }

    // Initialize character count on page load
    window.onload = function() {
        updateCharCount();
    };
</script>
</body>
</html>