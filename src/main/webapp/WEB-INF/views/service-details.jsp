<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${service.name} - Salon Booking System</title>
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
        .auth-buttons {
            display: flex;
        }
        .auth-btn {
            margin-left: 10px;
            padding: 8px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
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
        .service-header {
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }
        .service-header h2 {
            margin-top: 0;
            color: #333;
        }
        .service-category {
            display: inline-block;
            background-color: #f1f1f1;
            padding: 5px 10px;
            border-radius: 3px;
            color: #333;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .service-details {
            display: flex;
            margin-bottom: 20px;
        }
        .detail-item {
            margin-right: 30px;
        }
        .detail-label {
            font-weight: bold;
            color: #666;
            margin-bottom: 5px;
        }
        .detail-value {
            font-size: 18px;
            color: #333;
        }
        .price {
            color: #4CAF50;
            font-weight: bold;
        }
        .service-description {
            margin-bottom: 30px;
            line-height: 1.6;
            color: #555;
        }
        .action-buttons {
            display: flex;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-right: 10px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
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
        .navbar a:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
<div class="header">
    <h1>Salon Booking System</h1>
    <c:choose>
        <c:when test="${empty sessionScope.user}">
            <div class="auth-buttons">
                <a href="${pageContext.request.contextPath}/login" class="auth-btn">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="auth-btn">Register</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="user-info">
                <span>Welcome, ${sessionScope.user.username}</span>
                <a href="${pageContext.request.contextPath}/logout" class="auth-btn">Logout</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/">Home</a>
    <a href="${pageContext.request.contextPath}/services">Services</a>
    <a href="${pageContext.request.contextPath}/about">About Us</a>
    <a href="${pageContext.request.contextPath}/contact">Contact</a>
</div>

<div class="container">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="service-header">
        <span class="service-category">${service.category}</span>
        <h2>${service.name}</h2>
    </div>

    <div class="service-details">
        <div class="detail-item">
            <div class="detail-label">Price</div>
            <div class="detail-value price">${service.price}</div>
        </div>
        <div class="detail-item">
            <div class="detail-label">Duration</div>
            <div class="detail-value">${service.durationMinutes} minutes</div>
        </div>
    </div>

    <div class="service-description">
        <h3>Description</h3>
        <p>${service.description}</p>
    </div>

    <div class="action-buttons">
        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/login?redirect=appointment/book?serviceId=${service.id}" class="btn">Login to Book</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/client/appointment/book?serviceId=${service.id}" class="btn">Book Now</a>
            </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}/services" class="btn btn-secondary">Back to Services</a>
    </div>
</div>
</body>
</html>;
}
.container {
max-width: 1200px;
margin: 20px auto;
background-color: white;
padding: 20px;
border-radius: 5px;
box-shadow: 0 0 10px rgba(0,0,0,0.1);
}
.section-header {
display: flex;
justify-content: space-between;
align-items: center;
margin-bottom: 20px;
}
.section-header h2 {
margin: 0;
}
.btn {
display: inline-block;
padding: 8px 15px;
background-color: #4CAF50;
color: white;
text-decoration: none;
border-radius: 4px;
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
.btn-danger {
background-color: #f44336;
}
.btn-danger:hover {
background-color: #d32f2f;
}
.alert {
padding: 15px;
margin-bottom: 20px;
border-radius: 4px;
}
.alert-success {
background-color: #d4edda;
color: #155724;
}
.alert-danger {
background-color: #f8d7da;
color: #721c24;
}
table {
width: 100%;
border-collapse: collapse;
}
th, td {
padding: 12px 15px;
text-align: left;
border-bottom: 1px solid #ddd;
}
th {
background-color: #f2f2f2;
}
tr:hover {
background-color: #f5f5f5;
}
.actions {
display: flex;
gap: 10px;
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
.navbar a:hover {
background-color: #ddd;
}
.navbar a.active {
background-color: #ddd;
}
</style>
</head>
<body>
<div class="header">
    <h1>Salon Booking System - Admin</h1>
    <div class="user-info">
        <span>Welcome, Admin</span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
    </div>
</div>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/services" class="active">Services</a>
    <a href="${pageContext.request.contextPath}/admin/appointments">Appointments</a>
    <a href="${pageContext.request.contextPath}/admin/user/add">Add User</a>
</div>

<div class="container">
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="section-header">
        <h2>Manage Services</h2>
        <a href="${pageContext.request.contextPath}/admin/service/add" class="btn">Add New Service</a>
    </div>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>Duration (mins)</th>
            <th>Category</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${services}" var="service">
            <tr>
                <td>${service.id}</td>
                <td>${service.name}</td>
                <td>$${service.price}</td>
                <td>${service.durationMinutes}</td>
                <td>${service.category}</td>
                <td class="actions">
                    <a href="${pageContext.request.contextPath}/admin/service/edit/${service.id}" class="btn btn-secondary">Edit</a>
                    <a href="${pageContext.request.contextPath}/admin/service/delete/${service.id}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this service?')">Delete</a>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty services}">
            <tr>
                <td colspan="6" style="text-align: center;">No services found</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
</body>
</html>