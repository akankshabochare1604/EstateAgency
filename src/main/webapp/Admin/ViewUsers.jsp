<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.db.DBConnect" %>
<%
    Connection conn = DBConnect.getConnection();
    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE status = 'active'");
    ResultSet rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Users</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/AdminStyles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
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

</div>    <div class="container" style="margin-left:18%;">
        <h2 class="mt-4">Manage Users</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Profile</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("user_id") %></td>
                    <td>
                        <% String profileImage = rs.getString("profile_image"); %>
                        <img src="<%= (profileImage != null && !profileImage.isEmpty()) ? "../uploads/" + profileImage : "uploads/default.png" %>" 
                             alt="Profile" width="50" height="50" style="border-radius: 50%;">
                    </td>
                    <td><%= rs.getString("username") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td>
                        <a href="EditUser.jsp?user_id=<%= rs.getInt("user_id") %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="DeleteUserServlet?user_id=<%= rs.getInt("user_id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                        <a href="BlockUserServlet?user_id=<%= rs.getInt("user_id") %>" class="btn btn-dark btn-sm" onclick="return confirm('Block this user permanently?')">Block</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
<%
    rs.close();
    stmt.close();
    conn.close();
%>
