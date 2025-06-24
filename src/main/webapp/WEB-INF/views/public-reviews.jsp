<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Salon Services Reviews</title>
</head>
<body>

<div>
    <h1>Client Reviews</h1>

    <c:if test="${not empty error}">
        <div>${error}</div>
    </c:if>

    <div>
        <c:choose>
            <c:when test="${empty reviews}">
                <p>No reviews available.</p>
            </c:when>
            <c:otherwise>
                <c:forEach items="${reviews}" var="review">
                    <div>
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
                            <span>- ${review.userName}</span>
                            <span>${review.formattedCreatedAt}</span>
                        </div>
                        <hr>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>