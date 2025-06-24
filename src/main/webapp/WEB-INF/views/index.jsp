<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elegant Beauty Salon - Book Your Appointment</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
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
            min-height: 100vh;
        }

        .hero {
            background: linear-gradient(135deg, rgba(45, 27, 78, 0.95) 0%, rgba(156, 39, 176, 0.9) 100%), url('https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80') center/cover no-repeat;
            color: var(--white);
            padding: 100px 20px;
            text-align: center;
            position: relative;
        }

        .hero::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 80px;
            background: var(--background);
            clip-path: polygon(0 100%, 100% 100%, 100% 0, 0 100%);
        }

        .salon-name {
            font-family: 'Playfair Display', serif;
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 15px;
            line-height: 1.2;
        }

        .tagline {
            font-size: 18px;
            font-weight: 300;
            margin-bottom: 30px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            opacity: 0.9;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .content-section {
            padding: 80px 0;
            position: relative;
        }

        .welcome-card {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-lg);
            padding: 40px;
            margin-top: -100px;
            position: relative;
            z-index: 10;
            text-align: center;
            background: linear-gradient(135deg, #ffffff 0%, #fcfcfc 100%);
            border: 1px solid rgba(226, 232, 240, 0.5);
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            font-size: 28px;
            margin-bottom: 20px;
            position: relative;
            display: inline-block;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--accent-color) 0%, var(--secondary-color) 100%);
        }

        .welcome-text {
            color: var(--text-light);
            font-size: 16px;
            max-width: 700px;
            margin: 0 auto 30px;
            line-height: 1.8;
        }

        .btn-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 14px 30px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            color: var(--white);
            box-shadow: var(--shadow-md);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background-color: transparent;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
        }

        .btn-secondary:hover {
            background-color: rgba(45, 27, 78, 0.05);
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .service-card {
            background-color: var(--white);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
        }

        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .service-image {
            height: 200px;
            overflow: hidden;
        }

        .service-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .service-card:hover .service-image img {
            transform: scale(1.05);
        }

        .service-content {
            padding: 20px;
        }

        .service-title {
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            color: var(--primary-color);
            margin-bottom: 10px;
        }

        .service-description {
            color: var(--text-light);
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .features-section {
            background-color: rgba(245, 245, 245, 0.5);
            position: relative;
        }

        .features-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 80px;
            background: var(--white);
            clip-path: polygon(0 0, 100% 0, 100% 100%, 0 0);
        }

        .features-section::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 80px;
            background: var(--white);
            clip-path: polygon(0 100%, 100% 0, 100% 100%, 0 100%);
        }

        .features-content {
            padding: 100px 0;
            position: relative;
            z-index: 2;
            text-align: center;
        }

        .features-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .feature-item {
            background-color: var(--white);
            padding: 30px;
            border-radius: 12px;
            box-shadow: var(--shadow-sm);
            text-align: center;
            transition: all 0.3s ease;
        }

        .feature-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-md);
        }

        .feature-icon {
            font-size: 40px;
            margin-bottom: 20px;
            color: var(--accent-color);
        }

        .feature-title {
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--primary-color);
        }

        .feature-description {
            color: var(--text-light);
            font-size: 14px;
        }

        .footer {
            background-color: var(--primary-dark);
            color: var(--white);
            padding: 40px 0;
            text-align: center;
        }

        .footer-logo {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            margin-bottom: 15px;
        }

        .footer-tagline {
            opacity: 0.7;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .social-links {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .social-link {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            color: var(--white);
            transition: all 0.3s ease;
        }

        .social-link:hover {
            background-color: var(--accent-color);
            transform: translateY(-3px);
        }

        .footer-text {
            opacity: 0.5;
            font-size: 12px;
        }

        @media (max-width: 768px) {
            .salon-name {
                font-size: 36px;
            }

            .tagline {
                font-size: 16px;
            }

            .welcome-card {
                padding: 30px 20px;
            }

            .section-title {
                font-size: 24px;
            }

            .btn-container {
                flex-direction: column;
                gap: 15px;
            }

            .btn {
                width: 100%;
                text-align: center;
            }

            .features-content {
                padding: 60px 0;
            }
        }
    </style>
</head>
<body>
<div class="hero">
    <div class="container">
        <h1 class="salon-name">Elegant Beauty Salon</h1>
        <p class="tagline">Where Beauty Meets Elegance. Experience the finest beauty treatments and services tailored just for you.</p>
    </div>
</div>

<div class="container">
    <div class="welcome-card">
        <h2 class="section-title">Welcome to Elegant Beauty Salon</h2>
        <p class="welcome-text">
            Book your salon appointment easily and quickly with our online booking system. Our team of professional stylists and beauticians are ready to provide you with exceptional service and transform your look.
        </p>
        <div class="btn-container">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Sign In</a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary">Create Account</a>
        </div>
    </div>
</div>

<section class="content-section">
    <div class="container">
        <h2 class="section-title" style="text-align: center; display: block;">Our Premium Services</h2>
        <div class="services-grid">
            <div class="service-card">
                <div class="service-image">
                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='200' viewBox='0 0 400 200' preserveAspectRatio='none'%3E%3Crect width='400' height='200' fill='%23f06292' opacity='0.3'/%3E%3Cpath d='M173,83 C173,83 220,83 220,83 C220,83 231,107 231,107 C231,107 245,49 245,49 C245,49 259,126 259,126 C259,126 271,92 271,92 C271,92 295,92 295,92' stroke='%23f06292' stroke-width='8' fill='none' /%3E%3C/svg%3E" alt="Hair Styling">
                </div>
                <div class="service-content">
                    <h3 class="service-title">Hair Styling</h3>
                    <p class="service-description">Our expert stylists provide cutting-edge haircuts, coloring, highlights, and styling services to give you the perfect look.</p>
                </div>
            </div>
            <div class="service-card">
                <div class="service-image">
                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='200' viewBox='0 0 400 200' preserveAspectRatio='none'%3E%3Crect width='400' height='200' fill='%239c27b0' opacity='0.3'/%3E%3Ccircle cx='200' cy='100' r='50' fill='%239c27b0' opacity='0.3'/%3E%3Ccircle cx='200' cy='100' r='40' fill='%239c27b0' opacity='0.4'/%3E%3Ccircle cx='200' cy='100' r='30' fill='%239c27b0' opacity='0.5'/%3E%3C/svg%3E" alt="Facial Treatments">
                </div>
                <div class="service-content">
                    <h3 class="service-title">Facial Treatments</h3>
                    <p class="service-description">Rejuvenate your skin with our customized facial treatments designed to address your specific skin concerns.</p>
                </div>
            </div>
            <div class="service-card">
                <div class="service-image">
                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='200' viewBox='0 0 400 200' preserveAspectRatio='none'%3E%3Crect width='400' height='200' fill='%232d1b4e' opacity='0.3'/%3E%3Cpath d='M100,150 C150,50 250,50 300,150' stroke='%232d1b4e' stroke-width='12' fill='none' /%3E%3C/svg%3E" alt="Nail Care">
                </div>
                <div class="service-content">
                    <h3 class="service-title">Nail Care</h3>
                    <p class="service-description">From classic manicures to gel extensions, our nail technicians will ensure your hands and feet look their absolute best.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="features-section">
    <div class="container">
        <div class="features-content">
            <h2 class="section-title" style="text-align: center; display: block;">Why Choose Us</h2>
            <div class="features-list">
                <div class="feature-item">
                    <div class="feature-icon">📅</div>
                    <h3 class="feature-title">Easy Booking</h3>
                    <p class="feature-description">Book your appointments online anytime, anywhere with our user-friendly booking system.</p>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">👩‍💼</div>
                    <h3 class="feature-title">Professional Team</h3>
                    <p class="feature-description">Our team of certified professionals is dedicated to providing high-quality services.</p>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">✨</div>
                    <h3 class="feature-title">Premium Products</h3>
                    <p class="feature-description">We use only the finest, high-quality products to ensure the best results for our clients.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<footer class="footer">
    <div class="container">
        <div class="footer-logo">Elegant Beauty Salon</div>
        <p class="footer-tagline">Where Beauty Meets Elegance</p>
        <div class="social-links">
            <a href="#" class="social-link">f</a>
            <a href="#" class="social-link">in</a>
            <a href="#" class="social-link">ig</a>
        </div>
        <p class="footer-text">© 2023 Elegant Beauty Salon. All rights reserved.</p>
    </div>
</footer>
</body>
</html>