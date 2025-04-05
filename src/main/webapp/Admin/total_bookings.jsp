<!DOCTYPE html>
<html>
<head>
<title>Total Bookings</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/AdminStyles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style type="text/css">
body {
	font-family: Arial, sans-serif;
}

table {
	width: 80%;
	
	margin-left:18%;
}
th, td {
    padding: 10px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #007bff;
    color: white;
    font-weight: bold;
    text-transform: uppercase;
}

tr:nth-child(even) {
    background-color: #f8f9fa;
}

tr:hover {
    background-color: #e9ecef;
    transition: 0.3s ease-in-out;
}

td {
    color: #333;
    font-size: 14px;
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
h1{
margin-top:15px;
text-align:center;
font-weight:bold;
}
</style>
</head>

<body>
	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<div class="logo">
			Estate<span>Agency</span>
		</div>

		<a href="AdminProfile.jsp"><i class="fas fa-user"></i> Profile</a> <a
			href="AddProperty.jsp"> <i class="fas fa-building"></i> Add
			Properties
		</a> <a href="view_properties.jsp"> <i class="fas fa-building"></i>
			Total Properties
		</a> <a href="total_bookings.jsp"><i class="fas fa-book"></i> Total
			Bookings</a> <a href="total_payments.jsp"><i
			class="fas fa-credit-card"></i> Payments</a> <a
			href="pending_payments.jsp"><i class="fas fa-hourglass-half"></i>
			Pending Payments</a> <a href="ViewUsers.jsp"><i class="fas fa-users"></i>
			View Users</a> <a href="AdminLogoutServlet"><i
			class="fas fa-sign-out-alt"></i> Logout</a>

	</div>
	<h1 >Total Bookings</h1>
	<table border="1">
		<tr>
			<th>Booking ID</th>
			<th>User ID</th>
			<th>Property ID</th>
			<th>Booking Date</th>
			<th>Status</th>
			<th>Payment Status</th>
			<th>Payment Method</th>
			<th>Transaction ID</th>
			<th>Total Amount</th>
			<th>Amount Paid</th>
		</tr>
		<c:forEach var="booking" items="${bookings}">
			<tr>
				<td>${booking.booking_id}</td>
				<td>${booking.user_id}</td>
				<td>${booking.property_id}</td>
				<td>${booking.booking_date}</td>
				<td>${booking.status}</td>
				<td>${booking.payment_status}</td>
				<td>${booking.payment_method}</td>
				<td>${booking.transaction_id}</td>
				<td>${booking.total_amount}</td>
				<td>${booking.amount_paid}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
