<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.db.DBConnect" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Get property_id from URL
    String propertyIdStr = request.getParameter("property_id");
    int propertyId = 0;

    if (propertyIdStr != null) {
        try {
            propertyId = Integer.parseInt(propertyIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("user_properties.jsp?error=Invalid Property ID");
            return;
        }
    } else {
        response.sendRedirect("user_properties.jsp?error=Property ID Missing");
        return;
    }

    // Initialize property details
    String title = "", description = "", location = "", type = "", price = "", status = "", mapLocation = "";
    String image1 = "", image2 = "", image3 = "";
    int area = 0, beds = 0;

    try {
        Connection conn = DBConnect.getConnection();
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM properties WHERE property_id = ?");
        stmt.setInt(1, propertyId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            description = rs.getString("description");
            location = rs.getString("location");
            area = rs.getInt("area");
            beds = rs.getInt("beds");
            type = rs.getString("type");
            status = rs.getString("status");
            price = rs.getString("price");
            mapLocation = rs.getString("map_location");
            image1 = rs.getString("image1");
            image2 = rs.getString("image2");
            image3 = rs.getString("image3");
        } else {
            response.sendRedirect("user_properties.jsp?error=Property Not Found");
            return;
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("user_properties.jsp?error=Database Error");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= title %> - Property Details</title>
    
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="../css/styles.css">
<!-- Font Awesome CDN -->
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        .property-images img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 10px;
        }
        .quick-summary {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
        }
        iframe {
            width: 100%;
            height: 300px;
            border-radius: 10px;
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
    <div class="container mt-4">
        <h2><%= title %></h2>

        <!-- Property Images -->
       <!-- Property Images -->
<div id="carouselExampleRide" class="carousel slide" data-bs-ride="true">
  <div class="carousel-inner">
    <% if (image1 != null && !image1.isEmpty()) { %>
      <div class="carousel-item active">
        <img src="<%= request.getContextPath() %>/images/properties/<%= image1 %>" class="d-block w-100" alt="Property Image 1">
      </div>
    <% } %>
    <% if (image2 != null && !image2.isEmpty()) { %>
      <div class="carousel-item">
        <img src="<%= request.getContextPath() %>/images/properties/<%= image2 %>" class="d-block w-100" alt="Property Image 2">
      </div>
    <% } %>
    <% if (image3 != null && !image3.isEmpty()) { %>
      <div class="carousel-item">
        <img src="<%= request.getContextPath() %>/images/properties/<%= image3 %>" class="d-block w-100" alt="Property Image 3">
      </div>
    <% } %>
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

        <!-- Actions -->
        <div class="mt-4">
           <a href="WishlistServlet?property_id=<%= propertyId %>" class="btn btn-outline-danger btn-sm">❤️ Wishlist</a>
                       <a href="booking.jsp?property_id=<%= propertyId %>" class="btn btn-success">Book Now</a>
</div>
       <!-- Description & Quick Summary Side by Side -->
<div class="row mt-4">
    <!-- Description Section -->
    <div class="col-md-6">
        <div class="p-3" style="background: #f8f9fa; border-radius: 10px;">
            <h4>Description</h4>
            <p><%= description %></p>
        </div>
    </div>

    <!-- Quick Summary Section -->
    <div class="col-md-6">
        <div class="quick-summary p-3">
            <h4>Quick Summary</h4>
            <p><strong>Location:</strong> <%= location %></p>
            <p><strong>Area:</strong> <%= area %> sq. ft.</p>
            <p><strong>Beds:</strong> <%= beds %></p>
            <p><strong>Type:</strong> <%= type %></p>
            <p><strong>Status:</strong> <%= status %></p>
            <p><strong>Price:</strong> ₹<%= price %></p>
        </div>
    </div>
</div>



        <!-- Map -->
        <div class="mt-4">
            <h4>Location</h4>
            <% if (mapLocation != null && !mapLocation.isEmpty()) { %>
                <iframe src="<%= mapLocation %>" frameborder="0"></iframe>
            <% } else { %>
                <p>No map available</p>
            <% } %>
        </div>

    </div>
    
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
