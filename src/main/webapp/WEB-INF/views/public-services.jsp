<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${service.name} Reviews - Salon Booking System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
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
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }
        .service-card {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .service-image {
            width: 100%;
            max-height: 300px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .service-heading {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        .service-title {
            margin: 0;
            font-size: 28px;
            color: #333;
        }
        .service-price {
            font-size: 22px;
            color: #4CAF50;
            font-weight: bold;
        }
        .service-description {
            line-height: 1.6;
            margin-bottom: 20px;
            color: #555;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
            transition: background-color 0.2s;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-outline {
            background-color: transparent;
            color: #4CAF50;
            border: 2px solid #4CAF50;
        }
        .btn-outline:hover {
            background-color: #4CAF50;
            color: white;
        }
        .rating-summary {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 30px;
        }
        .average-rating {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .rating-value {
            font-size: 48px;
            font-weight: bold;
            color: #333;
            line-height: 1;
        }
        .rating-stars {
            margin: 10px 0;
        }
        .star {
            color: #ffc107;
            font-size: 24px;
        }
        .empty-star {
            color: #e0e0e0;
            font-size: 24px;
        }
        .rating-text {
            color: #666;
            font-size: 14px;
        }
        .rating-progress {
            flex-grow: 1;
        }
        .review-count {
            font-size: 18px;
            color: #666;
            margin-bottom: 15px;
        }
        .progress-container {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .progress-label {
            min-width: 30px;
            margin-right: 10px;
        }
        .progress-bar-container {
            flex-grow: 1;
            height: 15px;
            background-color: #e0e0e0;
            border-radius: 10px;
            overflow: hidden;
        }
        .progress-bar {
            height: 100%;
            background-color: #4CAF50;
        }
        .progress-value {
            min-width: 40px;
            margin-left: 10px;
            font-size: 14px;
            color: #666;
        }
        .review-card {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 1px 5px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        .review-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .reviewer-name {
            font-weight: bold;
            color: #333;
        }
        .review-date {
            color: #999;
            font-size: 14px;
        }
        .review-rating {
            margin-bottom: 10px;
        }
        .review-content {
            line-height: 1.6;
            color: #555;
        }
        .reviews-heading {
            margin-top: 40px;
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .empty-message {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            color: #666;
        }
        .navbar {
            background-color: #f8f8f8;
            padding: 15px 0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            align-items: center;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            text-decoration: none;
        }
        .nav-links {
            margin-left: auto;
            display: flex;
            gap: 20px;
        }
        .nav-links a {
            color: #555;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
        }
        .nav-links a:hover {
            color: #4CAF50;
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
        @media (max-width: 768px) {
            .rating-summary {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }
            .average-rating {
                width: 100%;
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
                gap: 20px;
            }
            .service-heading {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
<div class="navbar">
    <div class="nav-container">
        <a href="${pageContext.request.contextPath}/" class="logo">Salon Booking</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <a href="${pageContext.request.contextPath}/services">Services</a>
            <a href="${pageContext.request.contextPath}/contact">Contact</a>
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </div>
    </div>
</div>

<div class="container">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="service-card">
        <c:if test="${not empty service.imageUrl}">
            <img src="${service.imageUrl}" alt="${service.name}" class="service-image">
        </c:if>

        <div class="service-heading">
            <h1 class="service-title">${service.name}</h1>
            <div class="service-price">$${service.price}</div>
        </div>

        <p class="service-description">${service.description}</p>

        <a href="${pageContext.request.contextPath}/client/appointment/book?serviceId=${service.id}" class="btn">Book Now</a>
        <a href="${pageContext.request.contextPath}/services" class="btn btn-outline" style="margin-left: 10px;">Back to Services</a>
    </div>

    <!-- Reviews Section -->
    <h2 class="reviews-heading">Customer Reviews</h2>

    <c:if test="${not empty reviews}">
        <div class="rating-summary">
            <div class="average-rating">
                <div class="rating-value"><fmt:formatNumber value="${averageRating}" pattern="#.0" /></div>
                <div class="rating-stars">
                    <c:forEach begin="1" end="5" var="i">
                        <c:choose>
                            <c:when test="${i <= averageRating}">
                                <span class="star">★</span>
                            </c:when>
                            <c:when test="${i > averageRating && i - 1 < averageRating}">
                                <span class="star">★</span>
                            </c:when>
                            <c:otherwise>
                                <span class="empty-star">★</span>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
                <div class="rating-text">Based on ${reviewCount} reviews</div>
            </div>

            <div class="rating-progress">
                <c:forEach begin="5" end="1" step="-1" var="rating">
                    <c:set var="ratingCount" value="0" />
                    <c:forEach items="${reviews}" var="review">
                        <c:if test="${review.rating == rating}">
                            <c:set var="ratingCount" value="${ratingCount + 1}" />
                        </c:if>
                    </c:forEach>

                    <c:set var="percentage" value="${(ratingCount / reviewCount) * 100}" />

                    <div class="progress-container">
                        <div class="progress-label">${rating}</div>
                        <div class="progress-bar-container">
                            <div class="progress-bar" style="width: ${percentage}%;"></div>
                        </div>
                        <div class="progress-value">${ratingCount}</div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <c:forEach items="${reviews}" var="review">
            <div class="review-card">
                <div class="review-header">
                    <div class="reviewer-name">${review.userName}</div>
                    <div class="review-date">${review.formattedReviewDate}</div>
                </div>

                <div class="review-rating">
                    <c:forEach begin="1" end="5" var="star">
                        <span class="${star <= review.rating ? 'star' : 'empty-star'}">★</span>
                    </c:forEach>
                </div>

                <div class="review-content">
                        ${review.comment}
                </div>
            </div>
        </c:forEach>
    </c:if>

    <c:if test="${empty reviews}">
        <div class="empty-message">
            <p>No reviews yet for this service.</p>
            <p>Be the first to share your experience!</p>
            <a href="${pageContext.request.contextPath}/client/review/add?serviceId=${service.id}" class="btn">Write a Review</a>
        </div>
    </c:if>
</div>
</body>
</html>