<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <link rel="stylesheet" href="../css/register.css"> <!-- Using the same CSS file as Register -->
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

    <!-- Login Form Container -->
    <div class="form-container">
        <h2>User Login</h2>
<form action="UserLoginServlet" method="post">
    <!-- Capture Redirect Parameter -->
    <input type="hidden" name="redirect" value="<%= request.getParameter("redirect") != null ? request.getParameter("redirect") : "" %>">
    
    <label>UserEmail:</label>
    <input type="email" name="useremail" required>

    <label>Password:</label>
    <input type="password" name="password" required>

    <input type="submit" value="Login">
</form>


    </div>

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
