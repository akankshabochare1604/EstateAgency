<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.db.DBConnect, jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession();
    Integer userId = (Integer) sessionObj.getAttribute("user_id");

    if (userId == null) {
        response.sendRedirect("login.jsp?error=Please login first.");
        return;
    }

    Connection conn = DBConnect.getConnection();
    PreparedStatement stmt = conn.prepareStatement(
        "SELECT p.* FROM wishlist w JOIN properties p ON w.property_id = p.property_id WHERE w.user_id = ?");
    stmt.setInt(1, userId);
    ResultSet rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Wishlist</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
        .property-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
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
        <h2>My Wishlist</h2>
        <% if (request.getParameter("message") != null) { %>
            <div class="alert alert-success"><%= request.getParameter("message") %></div>
        <% } %>

        <div class="row">
            <% while (rs.next()) { %>
                <div class="col-md-4">
                    <div class="property-card">
                        <img src="<%= request.getContextPath() %>/images/properties/<%= rs.getString("image1") %>" class="img-fluid" alt="<%= rs.getString("title") %>">
                        <h4><%= rs.getString("title") %></h4>
                        <p><strong>Location:</strong> <%= rs.getString("location") %></p>
                        <p><strong>Price:</strong> ₹<%= rs.getString("price") %></p>
                        <a href="WishlistServlet?property_id=<%= rs.getInt("property_id") %>" class="btn btn-danger">Remove</a>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
