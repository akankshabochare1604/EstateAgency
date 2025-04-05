package com.servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/user/BookingServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("user_id"));
        int propertyId = Integer.parseInt(request.getParameter("property_id"));
        String paymentMethod = request.getParameter("payment_method");
        double amountPaid = Double.parseDouble(request.getParameter("amount_paid"));

        String transactionId = "TXN" + System.currentTimeMillis(); // Simulated transaction ID
        String paymentProofPath = null;
        double propertyPrice = 0;

        try {
            Connection conn = DBConnect.getConnection();

            // Get full property price
            PreparedStatement priceStmt = conn.prepareStatement("SELECT price FROM properties WHERE property_id = ?");
            priceStmt.setInt(1, propertyId);
            ResultSet rs = priceStmt.executeQuery();
            if (rs.next()) {
                propertyPrice = rs.getDouble("price");
            } else {
                response.sendRedirect("payment.jsp?property_id=" + propertyId + "&error=Property not found");
                return;
            }

            // Handle proof of payment for UPI/Net Banking
            if ("upi".equals(paymentMethod) || "netbanking".equals(paymentMethod)) {
                Part filePart = request.getPart("payment_proof");

                if (filePart == null || filePart.getSize() == 0) {
                    response.sendRedirect("payment.jsp?property_id=" + propertyId + "&error=Payment proof is required");
                    return;
                }

                // Save uploaded file
                String uploadDir = getServletContext().getRealPath("") + File.separator + "payment_proofs";
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdirs(); // Create directory if not exists
                }

                String fileName = userId + "_" + System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                File proofFile = new File(uploadDir, fileName);
                Files.copy(filePart.getInputStream(), proofFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                paymentProofPath = "payment_proofs/" + fileName;
            }

            // Determine payment status
            String paymentStatus = "pending";
            if (amountPaid == 0) {
                paymentStatus = "pending";
            } else if (amountPaid < propertyPrice) {
                paymentStatus = "processing";
            } else {
                paymentStatus = "completed";
            }

            // Insert booking with payment details
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO bookings (user_id, property_id, status, payment_status, payment_method, transaction_id, payment_proof, amount_paid) VALUES (?, ?, 'pending', ?, ?, ?, ?, ?)");
            stmt.setInt(1, userId);
            stmt.setInt(2, propertyId);
            stmt.setString(3, paymentStatus);
            stmt.setString(4, paymentMethod);
            stmt.setString(5, transactionId);
            stmt.setString(6, paymentProofPath);
            stmt.setDouble(7, amountPaid);
            stmt.executeUpdate();

            // If full payment is made, mark property as booked
            if (amountPaid >= propertyPrice) {
                PreparedStatement updateStmt = conn.prepareStatement(
                    "UPDATE properties SET status = 'booked' WHERE property_id = ?");
                updateStmt.setInt(1, propertyId);
                updateStmt.executeUpdate();
            }

            conn.close();
            response.sendRedirect("booking_success.jsp?message=Payment Successful, Booking Confirmed!");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("payment.jsp?property_id=" + propertyId + "&error=Payment Processing Failed");
        }
    }
}
