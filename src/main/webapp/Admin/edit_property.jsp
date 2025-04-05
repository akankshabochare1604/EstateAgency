<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.db.DBConnect" %>

<%
    int propertyId = 0;
    String title = "", location = "", price = "", type = "", status = "", mapLocation = "", image1 = "", image2 = "", image3 = "";

    try {
        propertyId = Integer.parseInt(request.getParameter("id")); // Get property ID from URL
        Connection conn = DBConnect.getConnection();
        String sql = "SELECT * FROM properties WHERE property_id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, propertyId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            location = rs.getString("location");
            price = rs.getString("price");
            type = rs.getString("type");
            status = rs.getString("status");
            mapLocation = rs.getString("map_location");
            image1 = rs.getString("image1");
            image2 = rs.getString("image2");
            image3 = rs.getString("image3");
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
    <title>Edit Property</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/AdminStyles.css"> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { font-family: Arial, sans-serif; }
        .container { max-width: 600px; margin-top: 20px; background: white; padding: 20px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); border-radius: 8px; }
        img { max-width: 100px; border-radius: 5px; margin-top: 10px; }
    </style>
</head>
<body>

<!-- Sidebar -->
<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <div class="logo">Estate<span>Agency</span></div>

    <a href="AdminProfile.jsp"><i class="fas fa-user"></i> Profile</a>
    <a href="AddProperty.jsp"> <i class="fas fa-building"></i> Add Properties</a>
    <a href="view_properties.jsp"> <i class="fas fa-building"></i> Total Properties</a>
    <a href="total_bookings.jsp"><i class="fas fa-book"></i> Total Bookings</a>
    <a href="total_payments.jsp"><i class="fas fa-credit-card"></i> Payments</a>
    <a href="pending_payments.jsp"><i class="fas fa-hourglass-half"></i> Pending Payments</a>
	<a href="ViewUsers.jsp"><i class="fas fa-users"></i> View Users</a>
    <a href="AdminLogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>

</div>

<div class="container">
    <h2 class="mb-3">Edit Property</h2>

    <form action="../EditPropertyServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="property_id" value="<%= propertyId %>">

        <label class="form-label">Title:</label>
        <input type="text" name="title" class="form-control" value="<%= title %>" required>

        <label class="form-label">Location:</label>
        <input type="text" name="location" class="form-control" value="<%= location %>" required>

        <label class="form-label">Price:</label>
        <input type="text" name="price" class="form-control" value="<%= price %>" required>

        <label class="form-label">Type:</label>
        <select name="type" class="form-control">
            <option value="Apartment" <%= type.equals("Apartment") ? "selected" : "" %>>Apartment</option>
            <option value="House" <%= type.equals("House") ? "selected" : "" %>>House</option>
            <option value="Villa" <%= type.equals("Villa") ? "selected" : "" %>>Villa</option>
            <option value="Commercial" <%= type.equals("Commercial") ? "selected" : "" %>>Commercial</option>
        </select>

        <label class="form-label">Status:</label>
        <select name="status" class="form-control">
            <option value="Available" <%= status.equals("Available") ? "selected" : "" %>>Available</option>
            <option value="Rented" <%= status.equals("Rented") ? "selected" : "" %>>Rented</option>
        </select>

        <label class="form-label">Map Location (Google Maps Embed URL):</label>
        <input type="text" name="map_location" class="form-control" value="<%= mapLocation %>">

        <label class="form-label">Property Images:</label><br>
        
        <% if (image1 != null && !image1.isEmpty()) { %>
            <img src="../images/properties/<%= image1 %>" alt="Property Image 1"><br>
        <% } %>
        <input type="file" name="image1" class="form-control">
        <input type="hidden" name="old_image1" value="<%= image1 %>">

        <% if (image2 != null && !image2.isEmpty()) { %>
            <img src="../images/properties/<%= image2 %>" alt="Property Image 2"><br>
        <% } %>
        <input type="file" name="image2" class="form-control">
        <input type="hidden" name="old_image2" value="<%= image2 %>">

        <% if (image3 != null && !image3.isEmpty()) { %>
            <img src="../images/properties/<%= image3 %>" alt="Property Image 3"><br>
        <% } %>
        <input type="file" name="image3" class="form-control">
        <input type="hidden" name="old_image3" value="<%= image3 %>">

        <br>
        <button type="submit" class="btn btn-primary">Update Property</button>
        <a href="view_properties.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>

</body>
</html>
