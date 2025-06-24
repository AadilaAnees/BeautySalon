<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Reviews</title>
</head>
<body>

<div>
    <h1>My Reviews</h1>

    <c:if test="${not empty success}">
        <div>${success}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div>${error}</div>
    </c:if>

    <div>
        <c:choose>
            <c:when test="${empty reviews}">
                <p>You haven't written any reviews yet.</p>
                <a href="/client/services">Browse Services to Review</a>
            </c:when>
            <c:otherwise>
                <c:forEach items="${reviews}" var="review">
                    <div style="margin-bottom: 20px; border: 1px solid #ddd; padding: 10px;">
                        <div>
                            <h3>${review.serviceName}</h3>
                            <div>
                                <c:forEach begin="1" end="5" var="star">
                                    <c:choose>
                                        <c:when test="${star <= review.rating}">
                                            ★
                                        </c:when>
                                        <c:otherwise>
                                            ☆
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                        </div>
                        <div>
                            <p>${review.comment}</p>
                        </div>
                        <div>
                            <span>${review.formattedCreatedAt}</span>
                            <div>
                                <a href="/client/review/edit/${review.id}">Edit</a>
                                <a href="/client/review/delete/${review.id}"
                                   onclick="return confirm('Are you sure you want to delete this review?')">Delete</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>