package com.adminServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.db.DBConnect;

@WebServlet("/TotalBookingsServlet")
public class TotalBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, Object>> bookings = new ArrayList<>();

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM bookings");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> booking = new HashMap<>();
                booking.put("booking_id", rs.getInt("booking_id"));
                booking.put("user_id", rs.getInt("user_id"));
                booking.put("property_id", rs.getInt("property_id"));
                booking.put("booking_date", rs.getTimestamp("booking_date"));
                booking.put("status", rs.getString("status"));
                booking.put("payment_status", rs.getString("payment_status"));
                booking.put("payment_method", rs.getString("payment_method"));
                booking.put("transaction_id", rs.getString("transaction_id"));
                booking.put("payment_proof", rs.getString("payment_proof"));
                booking.put("total_amount", rs.getBigDecimal("total_amount"));
                booking.put("amount_paid", rs.getBigDecimal("amount_paid"));
                bookings.add(booking);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("total_bookings.jsp").forward(request, response);
    }
}
