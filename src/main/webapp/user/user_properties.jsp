<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.db.DBConnect" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Properties</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
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
    <style>
        .card {
            transition: 0.3s;
            border-radius: 10px;
        }
        .card img {
            height: 200px;
            object-fit: cover;
            border-radius: 10px 10px 0 0;
        }
        .wishlist-btn {
            color: red;
            cursor: pointer;
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
        <h2 class="mb-3">Available Properties</h2>
        <div class="row">
            <%
                try {
                    Connection conn = DBConnect.getConnection();
                    String sql = "SELECT * FROM properties WHERE status='available'";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery();
                    
                    while (rs.next()) {
                        int propertyId = rs.getInt("property_id");
                        String title = rs.getString("title");
                        String location = rs.getString("location");
                        String price = rs.getString("price");
                        String type = rs.getString("type");
                        String image1 = rs.getString("image1");
            %>
            <div class="col-md-4 mb-4">
                <div class="card shadow">
                    <img src="../images/properties/<%= image1 %>" class="card-img-top" alt="Property Image">
                    <div class="card-body">
                        <h5 class="card-title"><%= title %></h5>
                        <p class="card-text">📍 <%= location %></p>
                        <p class="card-text"><b>₹ <%= price %></b> | <%= type %></p>
                        <a href="property_details.jsp?property_id=<%= propertyId %>" class="btn btn-primary btn-sm">View Property</a>
                        <a href="WishlistServlet?property_id=<%= propertyId %>" class="btn btn-outline-danger btn-sm">❤️ Wishlist</a>
                        <a href="booking.jsp?property_id=<%= propertyId %>" class="btn btn-success btn-sm">Book Now</a>
                    </div>
                </div>
            </div>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>
</body>
</html>
