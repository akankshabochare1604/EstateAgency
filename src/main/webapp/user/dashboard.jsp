<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%
    // Check if user is logged in
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) userSession.getAttribute("username");
    String email = (String) userSession.getAttribute("useremail");
    String profileImage = (String) userSession.getAttribute("profile_image");
    if (profileImage == null || profileImage.isEmpty()) {
        profileImage = "default.jpg";
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_properties", "root", "password");
        PreparedStatement ps = conn.prepareStatement("SELECT profile_image, email FROM users WHERE username=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            profileImage = rs.getString("profile_image");
            if (profileImage == null || profileImage.isEmpty()) {
                profileImage = "default.jpg";
            }
            email = rs.getString("email");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <link rel="stylesheet" href="../css/dashboard.css">
    <script>
        // Show success message if redirected after login
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('message')) {
                alert(urlParams.get('message')); // Show alert with message
                history.replaceState({}, document.title, "dashboard.jsp"); // Remove message from URL
            }
        };
    </script>
    
    <style>
    
    </style>
</head>
<body>
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
    
    
    
    
    <h2>Welcome, <%= username %>!</h2>

    <!-- Profile Image -->
    <img src="<%= "../uploads/" + profileImage %>" alt="Profile Image" width="100"><br><br>

    <p>Email: <%= (email != null) ? email : "Not Set" %></p>

    <!-- Edit Profile Form -->
    <h3>Edit Profile</h3>
    <form action="/RentEasy/EditProfileServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="username" value="<%= username %>">

        <label>Username:</label>
        <input type="text" name="new_username" value="<%= username %>" required><br><br>

        <label>Email:</label>
        <input type="email" name="new_useremail" value="<%= (email != null) ? email : "" %>" required><br><br>

        <label>New Password:</label>
        <input type="password" name="password" placeholder="Enter new password"><br><br>

        <label>Profile Image:</label>
        <input type="file" name="profile_image"><br>

        <input type="submit" value="Update Profile">
    </form>

    <!-- Delete Profile -->
   <form action="DeleteProfileServlet" method="post" onsubmit="return confirm('Are you sure you want to delete your profile?');">
    <input type="hidden" name="useremail" value="<%= email %>">
    <input type="submit" value="Delete Profile" class="delete-btn">
</form>


    <br>
    <a href="LogoutServlet">Logout</a>
    
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
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const menuToggle = document.getElementById("menu-toggle");
            const dropdown = menuToggle.parentElement; // Get the <li> element

            menuToggle.addEventListener("click", function (event) {
                event.preventDefault(); // Prevent default link behavior
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