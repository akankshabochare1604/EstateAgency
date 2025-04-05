<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.db.DBConnect, jakarta.servlet.http.HttpSession" %>

<%
    // Ensure user is logged in
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp?error=Please login first");
        return;
    }
    
    int userId = (int) userSession.getAttribute("user_id");
    String propertyIdStr = request.getParameter("property_id");
    int propertyId = 0;
    String title = "";
    double price = 0.0;

    if (propertyIdStr != null) {
        try {
            propertyId = Integer.parseInt(propertyIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("user_properties.jsp?error=Invalid Property ID");
            return;
        }
    } else {
        response.sendRedirect("user_properties.jsp?error=Property ID Missing");
        return;
    }

    try {
        Connection conn = DBConnect.getConnection();
        PreparedStatement stmt = conn.prepareStatement("SELECT title, price FROM properties WHERE property_id = ?");
        stmt.setInt(1, propertyId);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            title = rs.getString("title");
            price = rs.getDouble("price");
        } else {
            response.sendRedirect("user_properties.jsp?error=Property Not Found");
            return;
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("user_properties.jsp?error=Database Error");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Payment</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script>
        function handlePaymentChange() {
            const method = document.getElementById('paymentMethod').value;
            const proofSection = document.getElementById('proofSection');
            const submitButton = document.getElementById('submitButton');

            document.getElementById('cashNotice').classList.add('d-none');
            document.getElementById('upiSection').classList.add('d-none');
            document.getElementById('netBankingSection').classList.add('d-none');
            proofSection.classList.add('d-none');
            submitButton.disabled = true;
            
            if (method === 'cash') {
                document.getElementById('cashNotice').classList.remove('d-none');
            } else if (method === 'upi') {
                document.getElementById('upiSection').classList.remove('d-none');
                proofSection.classList.remove('d-none');
            } else if (method === 'netbanking') {
                document.getElementById('netBankingSection').classList.remove('d-none');
                proofSection.classList.remove('d-none');
            }

            if (method === 'upi' || method === 'netbanking') {
                proofSection.classList.remove('d-none');
                submitButton.disabled = false;
            } else if (method === 'cash') {
                submitButton.disabled = true;
            }
        }

        function validateAmount() {
            const totalAmount = <%= price %>;
            const advanceAmount = parseFloat(document.getElementById("advanceAmount").value);
            const submitButton = document.getElementById("submitButton");

            if (advanceAmount > 0 && advanceAmount <= totalAmount) {
                submitButton.disabled = false;
            } else {
                submitButton.disabled = true;
                alert("Advance amount must be between ₹1 and ₹" + totalAmount);
            }
        }
    </script>
</head>
<body>

<div class="container mt-4">
    <h2>Booking: <%= title %></h2>
    <p><strong>Total Price:</strong> ₹<%= price %></p>
    
    <form id="paymentForm" action="BookingServlet" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="property_id" value="<%= propertyId %>">
        <input type="hidden" name="user_id" value="<%= userId %>">
        <input type="hidden" name="total_amount" value="<%= price %>">
        
        <div class="mb-3">
            <label for="advanceAmount" class="form-label">Enter Advance Amount</label>
            <input type="number" id="advanceAmount" name="amount_paid" min="1" max="<%= price %>" class="form-control" oninput="validateAmount()" required>
        </div>

        <div class="mb-3">
            <label for="paymentMethod" class="form-label">Select Payment Method</label>
            <select id="paymentMethod" name="payment_method" class="form-control" onchange="handlePaymentChange()" required>
                <option value="">-- Select --</option>
                <option value="cash">Cash</option>
                <option value="upi">UPI</option>
                <option value="netbanking">Net Banking</option>
            </select>
        </div>
        
        <!-- Cash Payment Notice -->
        <div id="cashNotice" class="alert alert-warning d-none">
            Please visit our admin office to make an advance payment for booking confirmation.
        </div>
        
        <!-- UPI QR Code -->
        <div id="upiSection" class="d-none">
            <h4>Scan the QR Code to Pay</h4>
            <img src="path_to_qr_code_image.png" alt="UPI QR Code" width="200">
        </div>
        
        <!-- Net Banking Details -->
        <div id="netBankingSection" class="d-none">
            <h4>Bank Details for Net Banking</h4>
            <p>Bank: XYZ Bank</p>
            <p>Account No: 1234567890</p>
            <p>IFSC Code: XYZB0001234</p>
        </div>
        
        <!-- Proof of Transaction Upload -->
        <div id="proofSection" class="d-none">
            <label for="proof" class="form-label">Upload Payment Proof</label>
            <input type="file" id="proof" name="payment_proof" class="form-control" required>
        </div>
        
        <button type="submit" id="submitButton" class="btn btn-success mt-3" disabled>Confirm Booking</button>
    </form>
</div>

</body>
</html>
