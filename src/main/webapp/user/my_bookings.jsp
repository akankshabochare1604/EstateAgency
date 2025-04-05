<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.db.DBConnect, jakarta.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp?error=Please login first");
        return;
    }

    int userId = (int) userSession.getAttribute("user_id");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings</title>
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
                    <li><a href="my_booking.jsp">Bookings</a></li>
                    <li><a href="wishlist.jsp">Wishlist</a></li>
                </ul>
            </li>

            <li><a href="contact.jsp">Contact</a></li>
        </ul>
    </div>
    <div class="container mt-4">
        <h2>My Bookings</h2>

        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Property</th>
                    <th>Booking Date</th>
                    <th>Payment Method</th>
                    <th>Payment Status</th>
                    <th>Transaction ID</th>
                    <th>Payment Proof</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection conn = DBConnect.getConnection();
                        PreparedStatement stmt = conn.prepareStatement(
                            "SELECT p.title, b.booking_date, b.payment_method, b.payment_status, b.transaction_id, b.payment_proof " +
                            "FROM bookings b " +
                            "JOIN properties p ON b.property_id = p.property_id " +
                            "WHERE b.user_id = ? " +
                            "ORDER BY b.booking_date DESC");
                        stmt.setInt(1, userId);
                        ResultSet rs = stmt.executeQuery();

                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getTimestamp("booking_date") %></td>
                    <td><%= rs.getString("payment_method") %></td>
                    <td><%= rs.getString("payment_status") %></td>
                    <td><%= rs.getString("transaction_id") %></td>
                    <td>
                        <% if (rs.getString("payment_proof") != null) { %>
                            <a href="<%= request.getContextPath() %>/<%= rs.getString("payment_proof") %>" target="_blank">View</a>
                        <% } else { %>
                            No proof uploaded
                        <% } %>
                    </td>
                </tr>
                <%
                        }
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>

        <a href="dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
    </div>
</body>
</html>
