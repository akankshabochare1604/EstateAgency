<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Property</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/AdminStyles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            background: white;
            padding: 20px;
            margin: 50px auto;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        img {
            max-width: 100px;
            border-radius: 5px;
            margin-top: 10px;
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
        <h2>Add New Property</h2>
        <form action="/RentEasy/Admin/AddPropertyServlet" method="post" enctype="multipart/form-data">
    <label>Property Title:</label>
    <input type="text" name="title" class="form-control" required>

    <label>Description:</label>
    <textarea name="description" class="form-control" required></textarea>

    <label>Location:</label>
    <input type="text" name="location" class="form-control" required>

    <label>Area (sq. ft):</label>
    <input type="number" name="area" class="form-control" required>

    <label>Beds Count:</label>
    <input type="number" name="beds" class="form-control" required>

    <label>Property Type:</label>
    <select name="type" class="form-control">
        <option value="Apartment">Apartment</option>
        <option value="House">House</option>
        <option value="Villa">Villa</option>
        <option value="Commercial">Commercial</option>
    </select>

    <label>Status:</label>
    <select name="status" class="form-control">
        <option value="available">Available</option>
        <option value="booked">Booked</option>
    </select>

    <label>Price (₹):</label>
    <input type="text" name="price" class="form-control" required>

    <label>Google Map Location (Embed URL):</label>
    <input type="text" name="map_location" class="form-control">

    <h5>Upload Property Images</h5>
    <input type="file" name="image1" class="form-control" required>
    <input type="file" name="image2" class="form-control">
    <input type="file" name="image3" class="form-control">

    <br>
    <button type="submit" class="btn btn-success">Add Property</button>
</form>

    </div>
</body>
</html>
