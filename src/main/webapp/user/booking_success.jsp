<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.db.DBConnect, jakarta.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp?error=Please login first");
        return;
    }

    int userId = (int) userSession.getAttribute("user_id");
    String message = request.getParameter("message");

    // Fetch latest booking details
    String title = "", paymentMethod = "", transactionId = "", paymentProof = "";
    
    try {
        Connection conn = DBConnect.getConnection();
        PreparedStatement stmt = conn.prepareStatement(
            "SELECT p.title, b.payment_method, b.transaction_id, b.payment_proof FROM bookings b " +
            "JOIN properties p ON b.property_id = p.property_id WHERE b.user_id = ? ORDER BY b.booking_date DESC LIMIT 1");
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            title = rs.getString("title");
            paymentMethod = rs.getString("payment_method");
            transactionId = rs.getString("transaction_id");
            paymentProof = rs.getString("payment_proof");
        }
        
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
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
    <div class="container mt-4 text-center">
        <h2 class="text-success">Booking Confirmed!</h2>
        
        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>

        <div class="card p-3 mt-3">
            <h4>Property: <%= title %></h4>
            <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
            <p><strong>Transaction ID:</strong> <%= transactionId %></p>

            <% if (paymentProof != null && !paymentProof.isEmpty()) { %>
                <h5>Payment Proof:</h5>
                <img src="<%= request.getContextPath() %>/<%= paymentProof %>" alt="Payment Proof" width="300">
            <% } else { %>
                <p>No payment proof uploaded.</p>
            <% } %>
        </div>

        <a href="user_dashboard.jsp" class="btn btn-primary mt-3">Go to Dashboard</a>
    </div>
</body>
</html>
