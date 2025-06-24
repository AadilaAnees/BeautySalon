<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Write a Review</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .rating-input {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
        }

        .rating-input input {
            display: none;
        }

        .rating-input label {
            cursor: pointer;
            font-size: 24px;
            color: #ddd;
            padding: 0 2px;
        }

        .rating-input label:hover,
        .rating-input label:hover ~ label,
        .rating-input input:checked ~ label {
            color: #ffc107;
        }
    </style>
</head>
<body>
<jsp:include page="../client-header.jsp" />

<div class="container">
    <h1>Write a Review for ${service.name}</h1>

    <div class="service-info">
        <h3>${service.name}</h3>
        <p>${service.description}</p>
        <p><strong>Price:</strong> $${service.price}</p>
        <p><strong>Duration:</strong> ${service.durationMinutes} minutes</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="form-container">
        <form action="/client/review/add" method="post">
            <input type="hidden" name="id" value="${review.id}">
            <input type="hidden" name="userId" value="${review.userId}">
            <input type="hidden" name="userName" value="${review.userName}">
            <input type="hidden" name="serviceId" value="${review.serviceId}">
            <input type="hidden" name="serviceName" value="${review.serviceName}">

            <div class="form-group">
                <label for="rating">Rating:</label>
                <div class="rating-input">
                    <input type="radio" id="star5" name="rating" value="5" required>
                    <label for="star5" title="5 stars"><i class="fas fa-star"></i></label>

                    <input type="radio" id="star4" name="rating" value="4">
                    <label for="star4" title="4 stars"><i class="fas fa-star"></i></label>

                    <input type="radio" id="star3" name="rating" value="3">
                    <label for="star3" title="3 stars"><i class="fas fa-star"></i></label>

                    <input type="radio" id="star2" name="rating" value="2">
                    <label for="star2" title="2 stars"><i class="fas fa-star"></i></label>

                    <input type="radio" id="star1" name="rating" value="1">
                    <label for="star1" title="1 star"><i class="fas fa-star"></i></label>
                </div>
            </div>

            <div class="form-group">
                <label for="comment">Your Review:</label>
                <textarea id="comment" name="comment" rows="5" class="form-control" required></textarea>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-primary">Submit Review</button>
                <a href="/client/services" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../client-footer.jsp" />
</body>
</html>