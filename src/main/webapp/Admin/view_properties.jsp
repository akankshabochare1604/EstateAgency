<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.db.DBConnect"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Properties</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/AdminStyles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
body {
	font-family: Arial, sans-serif;
}

table {
	width: 100%;
}

img {
	width: 80px;
	height: 60px;
	object-fit: cover;
	border-radius: 5px;
}

iframe {
	width: 100px;
	height: 80px;
	border-radius: 5px;
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
	<div class="container mt-4" style="margin-left:20%;">
		<h2 class="mb-3">All Properties</h2>

		<table class="table table-bordered">
			<thead class="table-dark">
				<tr>
					<th>ID</th>
					<th>Title</th>
					<th>Location</th>
					<th>Price</th>
					<th>Type</th>
					<th>Status</th>
					
					<th>Images</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
				try {
					Connection conn = DBConnect.getConnection();
					String sql = "SELECT * FROM properties";
					PreparedStatement stmt = conn.prepareStatement(sql);
					ResultSet rs = stmt.executeQuery();

					while (rs.next()) {
						int propertyId = rs.getInt("property_id");
						String title = rs.getString("title");
						String location = rs.getString("location");
						String price = rs.getString("price");
						String type = rs.getString("type");
						String status = rs.getString("status");
						
						String image1 = rs.getString("image1");
				%>
				<tr>
					<td><%=propertyId%></td>
					<td><%=title%></td>
					<td><%=location%></td>
					<td><%=price%></td>
					<td><%=type%></td>
					<td><%=status%></td>
				

					<td>
						<%
						if (image1 != null && !image1.isEmpty()) {
						%> <img src="../images/properties/<%=image1%>" alt="Property Image">
						<%
						}
						%>
					</td>
					<td><a href="edit_property.jsp?id=<%=propertyId%>"
						class="btn btn-warning btn-sm">Edit</a> <a
						href="DeletePropertyServlet?id=<%=propertyId%>"
						class="btn btn-danger btn-sm"
						onclick="return confirm('Are you sure you want to delete this property?');">Delete</a>
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
	</div>
</body>
</html>
