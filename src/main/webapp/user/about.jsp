<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>About Us - RentalFinder</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<!-- Font Awesome CDN -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

<link rel="stylesheet" href="../css/styles.css">
<!-- Link to your CSS file -->
</head>
<body>
	<!-- Navbar -->
	 <div class="navbar">
        <div class="logo">Rent<span>Easy</span></div>
        <ul class="nav-links">
            <li><a href="Home.jsp">Home</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="services.jsp">Services</a></li>
            <li><a href="user_properties.jsp">Properties</a></li>

            <!-- Dropdown Menu -->
            <li class="menu-dropdown">
                <a href="#" id="menu-toggle">Menu ▼</a>
                <ul class="dropdown">
                    <li><a href="register.jsp">Register</a></li>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="dashboard.jsp">Profile</a></li>
                    <li><a href="my_bookings.jsp">Bookings</a></li>
                    <li><a href="wishlist.jsp">Wishlist</a></li>
                </ul>
            </li>

            <li><a href="contact.jsp">Contact</a></li>
        </ul>
    </div>

	<!-- About Us Section -->
	<section class="about-section">
		<div class="container">
			<h2
				style="display: flex; justify-content: center; margin-top: 10px;; margin-bottom: 10px;">About
				RentalFinder</h2>
			<p>RentalFinder is a platform dedicated to connecting property
				owners with tenants looking for rental properties. We make property
				search easy, fast, and reliable.</p>
			<div class="about-details"></div>
		</div>
		<hr>
		<div class="container-fluid">
			<h2
				style="display: flex; justify-content: center; margin-top: 10px;; margin-bottom: 10px;">Why
				Choose US?</h2>
			<p
				style="display: flex; justify-content: center; margin-top: 10px;; margin-bottom: 10px;">Find,
				list, and manage properties effortlessly—your perfect rental is just
				a click away!</p>

			<div class="services-container">
				<div class="service-card">
					<div class="service-icon">
						<i class="fa-solid fa-house"></i>
					</div>
					<h3 class="service-title">Property Listings</h3>
					<p class="service-description">Browse and list rental
						properties with ease.</p>
				</div>

				<div class="service-card">
					<div class="service-icon">
						<i class="fa-solid fa-user"></i>
					</div>
					<h3 class="service-title">Tenant Management</h3>
					<p class="service-description">Manage tenant details and lease
						agreements.</p>
				</div>

				<div class="service-card">
					<div class="service-icon">
						<i class="fa-solid fa-key"></i>
					</div>
					<h3 class="service-title">Secure Payments</h3>
					<p class="service-description">Make and receive rent payments
						securely.</p>
				</div>

				<div class="service-card">
					<div class="service-icon">
						<i class="fa-solid fa-cart-plus"></i>
					</div>
					<h3 class="service-title">Hassle-Free Bookings</h3>
					<p class="service-description">Easily book properties with
						real-time availability and instant confirmations.</p>
				</div>
				<div class="service-card">
					<div class="service-icon">
						<i class="fa-solid fa-heart"></i>
					</div>
					<h3 class="service-title">Wishlist & Favorites</h3>
					<p class="service-description">Save your favorite properties
						and access them anytime.</p>
				</div>

			</div>
		</div>
		</div>

	</section>

	<!-- Footer -->
	<footer class="footer">
        <div class="container text-center">
            <div class="row">
                <div class="col-md-4 contact-info">
                    <h5>Address</h5>
                    <p>A108 Nirman Plaza<br>Chinchwad-411019 </p>
                </div>
                <div class="col-md-4 contact-info">
                    <h5>Contact</h5>
                    <p>Phone: +91 9632587410<br>Email: info@renteasy.com</p>
                </div>
                <div class="col-md-4 contact-info">
                    <h5>Opening Hours</h5>
                    <p>Mon-Sat: 11AM - 23PM<br>Sunday: Closed</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <h6>Follow Us</h6>
                    <ul class="social-icons">
                        <li><a href="#">&#x2716;</a></li> <!-- Replace with actual icons -->
                        <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
                        <li><a href="#"><i class="fab fa-instagram"></i></a></li>
                        <li><a href="#"><i class="fab fa-linkedin-in"></i></a></li>
                    </ul>
                </div>
            </div>
            <p>&copy; Copyright RentEasy All Rights Reserved | Designed by RentEasy</p>
        </div>
    </footer>

</body>
</html>
