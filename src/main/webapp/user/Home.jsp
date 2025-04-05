<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="../css/styles.css">
<!-- Font Awesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style type="text/css">
    /* Navbar styles */
.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #fff;
    padding: 10px 20px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

/* Logo styling */
.logo {
    font-size: 24px;
    font-weight: bold;
}

.logo span {
    color: green;
}

/* Navigation links */
.nav-links {
    list-style: none;
    display: flex;
    gap: 20px;
    position: relative;
}

.nav-links li {
    font-weight: normal;
    position: relative;
}

.nav-links a {
    text-decoration: none;
    color: #333;
    padding: 10px;
    display: block;
}

.nav-links a:hover {
    color: green;
}

/* Dropdown menu - Hidden by default */
.dropdown {
    list-style: none;
    position: absolute;
    top: 100%;
    left: 0;
    background: #fff;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    display: none; /* Hidden initially */
    padding: 0;
    min-width: 150px;
    z-index: 1000;
}

.dropdown li {
    width: 100%;
}

.dropdown li a {
    padding: 8px 15px;
    display: block;
    white-space: nowrap;
}

.dropdown li a:hover {
    background: lightgray;
}

/* Show dropdown when active */
.menu-dropdown.active .dropdown {
    display: block;
}
    </style>
   
</head>
<body>
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
<!-- section 1 -->
<div id="carouselExampleRide" class="carousel slide" data-bs-ride="true">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="../images/property1.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="../images/property2.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="../images/property3.jpg" class="d-block w-100" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleRide" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleRide" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
<!-- section 2 -->
<div class="container-fluid">
  <h2>Our Services</h2>
  <p>Find, list, and manage properties effortlessly—your perfect rental is just a click away!</p>
  
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
        <h3 class="service-title"> Hassle-Free Bookings</h3>
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

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const menuToggle = document.getElementById("menu-toggle");
    const dropdown = menuToggle.parentElement; // Get the <li> element

    menuToggle.addEventListener("click", function (event) {
        event.preventDefault(); // Prevent default link behavior

        // Toggle the active class
        dropdown.classList.toggle("active");
    });

    // Close dropdown when clicking outside
    document.addEventListener("click", function (event) {
        if (!dropdown.contains(event.target) && !menuToggle.contains(event.target)) {
            dropdown.classList.remove("active");
        }
    });
});
</script>

</body>
</html>