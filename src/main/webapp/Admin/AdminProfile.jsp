<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.db.DBConnect" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    // Fetch the logged-in admin details from the session
    HttpSession sessionObj = request.getSession(false);
    Integer adminId = (Integer) sessionObj.getAttribute("admin_id");

    if (adminId == null) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }

    Connection conn = DBConnect.getConnection();
    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM admins WHERE admin_id = ?");
    stmt.setInt(1, adminId);
    ResultSet rs = stmt.executeQuery();

    String adminName = "", adminEmail = "", adminContact = "", adminImage = "default.png";

    if (rs.next()) {
        adminName = rs.getString("admin_name");
        adminEmail = rs.getString("admin_email");
        adminContact = rs.getString("admin_contact_no");
        adminImage = rs.getString("admin_image");
    }

    rs.close();
    stmt.close();
    conn.close();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/AdminStyles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
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
        <div class="profile-container">
            <h2>Admin Profile</h2>
            <form action="AdminProfileServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="admin_id" value="<%= adminId %>">
                
                <div class="mb-3 text-center">
                <img src="<%= request.getContextPath() %>/uploads/<%= (adminImage == null || adminImage.isEmpty()) ? "default.jpg" : adminImage %>" 
     alt="Admin Image" width="100" height="100" class="rounded-circle">

</div>

                <div class="mb-3">
                    <label>Name</label>
                    <input type="text" name="admin_name" class="form-control" value="<%= adminName %>" required>
                </div>

                <div class="mb-3">
                    <label>Email</label>
                    <input type="email" name="admin_email" class="form-control" value="<%= adminEmail %>" required>
                </div>

                <div class="mb-3">
                    <label>Contact</label>
                    <input type="text" name="admin_contact" class="form-control" value="<%= adminContact %>" required>
                </div>

                <div class="mb-3">
                    <label>Password</label>
                    <input type="password" name="admin_password" class="form-control">
                </div>

                <div class="mb-3">
                    <label>Profile Image</label>
                    <input type="file" name="admin_image" class="form-control">
                </div>

                <button type="submit" name="action" value="update" class="btn btn-primary">Update Profile</button>
                <button type="submit" name="action" value="delete" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete your profile?')">Delete Profile</button>
            </form>
        </div>
    </div>
</body>
</html>
