<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>All Client Reviews</title>
</head>
<body>
<h2>All Reviews</h2>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Service ID</th>
        <th>Comment</th>
        <th>Rating</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="review" items="${reviews}">
        <tr>
            <td>${review.id}</td>
            <td>${review.clientUsername}</td>
            <td>${review.serviceId}</td>
            <td>${review.comment}</td>
            <td>${review.rating}</td>
            <td>
                <a href="/admin/review/edit/${review.id}">Edit</a> |
                <a href="/admin/review/delete/${review.id}" onclick="return confirm('Delete this review?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
