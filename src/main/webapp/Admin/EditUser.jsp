<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<%
    // Database connection
    String jdbcURL = "jdbc:mysql://localhost:3306/rental_db";
    String dbUser = "root";
    String dbPassword = "root";

    String userId = request.getParameter("user_id"); // Get user_id from URL
    String username = "", email = "", contactNo = "", address = "", profileImage = "../uploads/default.jpg";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE user_id = ?");
        ps.setString(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            username = rs.getString("username");
            email = rs.getString("email");
            contactNo = rs.getString("contact_no");
            address = rs.getString("address");
            profileImage = rs.getString("profile_image");

            if (profileImage == null || profileImage.isEmpty()) {
                profileImage = "../uploads/default.jpg";
            }
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
    <title>Edit User</title>
    <link rel="stylesheet" href="../css/AdminStyles.css">
    <style type="text/css">
  
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

.container {
    width: 50%;
    max-width: 500px; /* Prevents excessive stretching */
    margin: 50px auto;
    background: white;
    padding: 20px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

form {
    display: flex;
    flex-direction: column;
    gap: 15px;
    align-items: center; /* Center aligns child elements */
}

input, textarea {
    width: 90%; /* Reduced width */
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}

textarea {
    resize: vertical;
    height: 80px;
}

img {
    display: block;
    margin: 10px auto;
    border-radius: 50%;
    border: 2px solid #ddd;
}

button {
    width: 50%; /* Restrict button width */
    background-color: #28a745;
    color: white;
    padding: 10px;
    border: none;
    cursor: pointer;
    border-radius: 5px;
    font-size: 16px;
}

button:hover {
    background-color: #218838;
}

.back-link {
    display: block;
    text-align: center;
    margin-top: 15px;
    text-decoration: none;
    color: #007bff;
    font-weight: bold;
}

.back-link:hover {
    text-decoration: underline;
}

    
    </style>
</head>
<body>
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
        <h2>Edit User Profile</h2>

        <form action="EditUserServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="user_id" value="<%= userId %>">

            <label>Username:</label>
            <input type="text" name="username" value="<%= username %>" required>

            <label>Email:</label>
            <input type="email" name="email" value="<%= email %>">

            <label>Contact No:</label>
            <input type="text" name="contact_no" value="<%= contactNo %>">

            <label>Address:</label>
            <textarea name="address"><%= address %></textarea>

            <label>Profile Image:</label>
            <input type="file" name="profile_image">
            <br>
            
            <img src="<%= request.getContextPath() + "../uploads/" + profileImage %>" 
     alt="Profile" width="50" height="50" style="border-radius: 50%;">


            <br>
            <button type="submit">Update User</button>
        </form>

        <a href="AdminIndex.jsp" class="back-link">Back to Dashboard</a>
    </div>
</body>

</html>
