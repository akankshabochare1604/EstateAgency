<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String propertyId = request.getParameter("property_id");
    String userId = request.getParameter("user_id");
    String price = request.getParameter("price");
    String paymentMethod = request.getParameter("payment_method");

    if (propertyId == null || userId == null || price == null || paymentMethod == null) {
        response.sendRedirect("booking.jsp?error=Invalid Payment Details");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Processing</title>
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
        <h2>Payment Details</h2>
        <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
        <p><strong>Amount:</strong> ₹<%= price %></p>

        <%
            if ("cash".equals(paymentMethod)) {
        %>
            <div class="alert alert-warning">
                Please visit our admin office to make an advance payment for booking confirmation.
            </div>
            <a href="booking.jsp?property_id=<%= propertyId %>" class="btn btn-secondary">Back</a>
        <%
            } else if ("upi".equals(paymentMethod)) {
        %>
            <h4>Scan the QR Code to Pay</h4>
            <img src="path_to_qr_code_image.png" alt="UPI QR Code" width="200">
        <%
            } else if ("netbanking".equals(paymentMethod)) {
        %>
            <h4>Bank Transfer Details</h4>
            <p>Bank: XYZ Bank</p>
            <p>Account No: 1234567890</p>
            <p>IFSC Code: XYZB0001234</p>
        <%
            }
        %>

        <% if (!"cash".equals(paymentMethod)) { %>
           <form id="paymentForm" action="BookingServlet" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="property_id" value="<%= propertyId %>">
    <input type="hidden" name="user_id" value="<%= userId %>">
    
    <div class="mb-3">
        <label for="paymentMethod" class="form-label">Select Payment Method</label>
        <select id="paymentMethod" name="payment_method" class="form-control" onchange="handlePaymentChange()" required>
            <option value="">-- Select --</option>
            <option value="cash">Cash</option>
            <option value="upi">UPI</option>
            <option value="netbanking">Net Banking</option>
        </select>
    </div>

    <div class="mb-3">
        <label for="amountPaid" class="form-label">Enter Amount to Pay</label>
        <input type="number" id="amountPaid" name="amount_paid" class="form-control" min="1000" required>
    </div>

    <div id="cashNotice" class="alert alert-warning d-none">
        Please visit our admin office to make an advance payment for booking confirmation.
    </div>

    <div id="upiSection" class="d-none">
        <h4>Scan the QR Code to Pay</h4>
        <img src="path_to_qr_code_image.png" alt="UPI QR Code" width="200">
    </div>

    <div id="netBankingSection" class="d-none">
        <h4>Bank Details for Net Banking</h4>
        <p>Bank: XYZ Bank</p>
        <p>Account No: 1234567890</p>
        <p>IFSC Code: XYZB0001234</p>
    </div>

    <div id="proofSection" class="d-none">
        <label for="proof" class="form-label">Upload Payment Proof</label>
        <input type="file" id="proof" name="payment_proof" class="form-control">
    </div>

    <button type="submit" id="submitButton" class="btn btn-success mt-3">Confirm Booking</button>
</form>

        <% } %>
    </div>
</body>
</html>
