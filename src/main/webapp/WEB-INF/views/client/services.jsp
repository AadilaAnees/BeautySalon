<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Services - Salon Booking System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Playfair+Display:wght@400;600;700;800&display=swap" rel="stylesheet">
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
            --red-500: #e53e3e;
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
            font-size: 28px;
            font-family: 'Playfair Display', serif;
            font-weight: 700;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .user-info span {
            font-weight: 500;
        }

        .logout-btn {
            background-color: var(--accent-color);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 8px;
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

        .navbar {
            background-color: var(--white);
            box-shadow: var(--shadow-md);
            margin-bottom: 0;
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

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .alert {
            padding: 16px;
            margin-bottom: 24px;
            border-radius: 8px;
            font-weight: 500;
            box-shadow: var(--shadow-sm);
            position: relative;
            padding-left: 50px;
            text-align: left;
        }

        .alert::before {
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
        }

        .alert-danger {
            background-color: rgba(229, 62, 62, 0.1);
            color: var(--red-500);
            border-left: 4px solid var(--red-500);
        }

        .alert-danger::before {
            content: '\f071'; /* Warning icon */
            color: var(--red-500);
        }

        .section-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .section-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            color: var(--primary-color);
            margin-bottom: 8px;
            position: relative;
            display: inline-block;
        }

        .section-header h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(to right, var(--secondary-color), var(--accent-color));
            border-radius: 3px;
        }

        .section-header p {
            color: var(--text-light);
            font-size: 16px;
            margin-top: 16px;
        }

        /* Filter buttons */
        .filter-section {
            margin-bottom: 30px;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        .filter-btn {
            padding: 10px 20px;
            background-color: var(--white);
            border: 1px solid var(--border-color);
            border-radius: 30px;
            cursor: pointer;
            font-family: 'Inter', sans-serif;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s ease;
            color: var(--text-dark);
            box-shadow: var(--shadow-sm);
        }

        .filter-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .filter-btn.active {
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            color: white;
            border-color: transparent;
        }

        /* Enhanced services grid */
        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
        }

        /* Enhanced service card */
        .service-card {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-md);
            padding: 25px;
            display: flex;
            flex-direction: column;
            height: 450px; /* Increased height */
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
        }

        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .service-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 60px;
            background: linear-gradient(to bottom, var(--secondary-color), var(--accent-color));
            border-radius: 0 4px 4px 0;
        }

        .service-card h3 {
            margin-top: 0;
            margin-bottom: 12px;
            color: var(--primary-color);
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            font-weight: 600;
            padding-left: 10px;
            line-height: 1.3;
            /* Allow title to wrap to two lines instead of truncating */
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            height: auto;
            max-height: 52px; /* Accommodate two lines */
        }

        .service-price {
            font-size: 22px;
            font-weight: 700;
            color: var(--accent-color);
            margin-bottom: 8px;
            padding-left: 10px;
        }

        .service-duration {
            color: var(--text-light);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
            padding-left: 10px;
        }

        .service-duration::before {
            content: '\f017'; /* Clock icon */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            color: var(--secondary-color);
        }

        .service-description {
            color: var(--text-dark);
            flex-grow: 1;
            overflow-y: auto;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #f9fafc;
            border-radius: 8px;
            border: 1px solid var(--border-color);

            /* Text handling */
            overflow-wrap: break-word;
            word-wrap: break-word;
            word-break: break-word;
            hyphens: auto;
            font-size: 15px;
            line-height: 1.5;

            /* Scrollbar styling */
            scrollbar-width: thin;
            scrollbar-color: var(--accent-light) #f1f1f1;
        }

        /* Webkit scrollbar styling */
        .service-description::-webkit-scrollbar {
            width: 6px;
        }

        .service-description::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .service-description::-webkit-scrollbar-thumb {
            background: var(--accent-light);
            border-radius: 10px;
        }

        .service-category {
            display: inline-block;
            background-color: rgba(156, 39, 176, 0.1);
            padding: 5px 12px;
            border-radius: 20px;
            color: var(--secondary-color);
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .book-btn {
            display: inline-flex;
            width: 100%;
            justify-content: center;
            align-items: center;
            gap: 8px;
            padding: 12px 0;
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
            border: none;
        }

        .book-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .book-btn::before {
            content: '\f274'; /* Calendar check icon */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .empty-message {
            grid-column: 1 / -1;
            text-align: center;
            padding: 40px 20px;
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border-color);
            color: var(--text-muted);
            font-style: italic;
        }

        .empty-message i {
            font-size: 48px;
            color: var(--accent-light);
            margin-bottom: 20px;
        }

        /* Responsive styles */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                padding: 15px;
                gap: 15px;
            }

            .navbar {
                overflow-x: auto;
                justify-content: flex-start;
                padding: 0 10px;
            }

            .navbar a {
                padding: 12px 10px;
                white-space: nowrap;
            }

            .services-grid {
                grid-template-columns: 1fr;
            }

            .filter-section {
                overflow-x: auto;
                justify-content: flex-start;
                padding-bottom: 10px;
            }

            .filter-btn {
                white-space: nowrap;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 0 15px;
                margin: 20px auto;
            }

            .service-card {
                height: 380px; /* Slightly taller on mobile */
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
    <a href="${pageContext.request.contextPath}/client/services" class="active">Services</a>
    <a href="${pageContext.request.contextPath}/client/appointments">My Appointments</a>
    <a href="${pageContext.request.contextPath}/client/payments">Payments</a>
    <a href="${pageContext.request.contextPath}/client/reviews">My Reviews</a>
    <a href="${pageContext.request.contextPath}/client/profile">My Profile</a>
</div>

<div class="container">
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="section-header">
        <h2>Our Services</h2>
        <p>Browse our range of premium salon services and treatments</p>
    </div>

    <div class="filter-section">
        <button class="filter-btn active" onclick="filterServices('all')">All Services</button>
        <button class="filter-btn" onclick="filterServices('Hair')">
            <i class="fas fa-cut"></i> Hair
        </button>
        <button class="filter-btn" onclick="filterServices('Nails')">
            <i class="fas fa-hand-sparkles"></i> Nails
        </button>
        <button class="filter-btn" onclick="filterServices('Facial')">
            <i class="fas fa-smile"></i> Facial
        </button>
        <button class="filter-btn" onclick="filterServices('Massage')">
            <i class="fas fa-spa"></i> Massage
        </button>
        <button class="filter-btn" onclick="filterServices('Makeup')">
            <i class="fas fa-magic"></i> Makeup
        </button>
    </div>

    <div class="services-grid">
        <c:forEach items="${services}" var="service">
            <div class="service-card" data-category="${service.category}">
                <h3 title="${service.name}">${service.name}</h3>
                <div class="service-price">$${service.price}</div>
                <div class="service-duration">${service.durationMinutes} minutes</div>
                <div class="service-description">${service.description}</div>
                <div class="service-category">${service.category}</div>
                <a href="${pageContext.request.contextPath}/client/appointment/book?serviceId=${service.id}" class="book-btn">Book Now</a>
            </div>
        </c:forEach>

        <c:if test="${empty services}">
            <div class="empty-message">
                <i class="fas fa-spa"></i>
                <p>No services available at the moment.</p>
                <p>Please check back later or contact our salon for more information.</p>
            </div>
        </c:if>
    </div>
</div>

<script>
    function filterServices(category) {
        // Update active button
        const buttons = document.querySelectorAll('.filter-btn');
        buttons.forEach(button => {
            button.classList.remove('active');
            if ((button.textContent.includes(category) && category !== 'all') ||
                (button.textContent.includes('All') && category === 'all')) {
                button.classList.add('active');
            }
        });

        // Filter services
        const serviceCards = document.querySelectorAll('.service-card');
        let visibleCount = 0;

        serviceCards.forEach(card => {
            if (category === 'all' || card.getAttribute('data-category') === category) {
                card.style.display = 'flex';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        // Show message if no services match the filter
        const existingMessage = document.querySelector('.no-results-message');
        if (visibleCount === 0 && !existingMessage) {
            const noResultsMessage = document.createElement('div');
            noResultsMessage.className = 'empty-message no-results-message';
            noResultsMessage.innerHTML = `
                <i class="fas fa-search"></i>
                <p>No ${category} services found.</p>
                <p>Please try another category or view all services.</p>
            `;
            document.querySelector('.services-grid').appendChild(noResultsMessage);
        } else if (visibleCount > 0 && existingMessage) {
            existingMessage.remove();
        }
    }
</script>
</body>
</html>