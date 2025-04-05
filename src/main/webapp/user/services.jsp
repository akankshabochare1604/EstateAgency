<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Services</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
  <!-- Navbar -->
    <div class="navbar">
        <div class="logo">Estate<span>Agency</span></div>
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
    <div class="container-fluid" >
        <h2 style="display:flex;justify-content:center;">Our Services</h2>
        <p style="display:flex;justify-content:center;">Find, list, and manage properties effortlessly—your perfect rental is just a click away!</p>
        
        <div class="services-container">
            <div class="service-card">
                <div class="service-icon">
                    <i class="fa-solid fa-house"></i>
                </div>
                <h3 class="service-title">Property Listings</h3>
                <p class="service-description">Browse and list rental properties with ease.</p>
            </div>

            <div class="service-card">
                <div class="service-icon">
                    <i class="fa-solid fa-user"></i>
                </div>
                <h3 class="service-title">Tenant Management</h3>
                <p class="service-description">Manage tenant details and lease agreements.</p>
            </div>

            <div class="service-card">
                <div class="service-icon">
                    <i class="fa-solid fa-key"></i>
                </div>
                <h3 class="service-title">Secure Payments</h3>
                <p class="service-description">Make and receive rent payments securely.</p>
            </div>

            <div class="service-card">
                <div class="service-icon">
                    <i class="fa-solid fa-cart-plus"></i>
                </div>
                <h3 class="service-title">Hassle-Free Bookings</h3>
                <p class="service-description">Easily book properties with real-time availability and instant confirmations.</p>
            </div>
            
            <div class="service-card">
                <div class="service-icon">
                    <i class="fa-solid fa-heart"></i>
                </div>
                <h3 class="service-title">Wishlist & Favorites</h3>
                <p class="service-description">Save your favorite properties and access them anytime.</p>
            </div>
        </div>   
    </div>

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

       <!-- JavaScript for Dropdown -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const menuToggle = document.getElementById("menu-toggle");
            const dropdown = menuToggle.parentElement;

            menuToggle.addEventListener("click", function (event) {
                event.preventDefault();
                dropdown.classList.toggle("active");
            });

            document.addEventListener("click", function (event) {
                if (!dropdown.contains(event.target) && !menuToggle.contains(event.target)) {
                    dropdown.classList.remove("active");
                }
            });

            // Display error or success messages in alert
            const errorMessage = "<%= (request.getSession().getAttribute("error") != null) ? request.getSession().getAttribute("error") : "" %>";
            const successMessage = "<%= (request.getSession().getAttribute("message") != null) ? request.getSession().getAttribute("message") : "" %>";

            if (errorMessage !== "") {
                alert(errorMessage);
                <% request.getSession().removeAttribute("error"); %> // Clear after showing
            }

            if (successMessage !== "") {
                alert(successMessage);
                <% request.getSession().removeAttribute("message"); %> // Clear after showing
            }
        });
    </script>
</body>
</html>
