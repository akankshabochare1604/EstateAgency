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

@WebServlet("/TotalPaymentsServlet")
public class TotalPaymentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, Object>> payments = new ArrayList<>();

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM bookings WHERE payment_status = 'completed'");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> payment = new HashMap<>();
                payment.put("booking_id", rs.getInt("booking_id"));
                payment.put("user_id", rs.getInt("user_id"));
                payment.put("property_id", rs.getInt("property_id"));
                payment.put("payment_method", rs.getString("payment_method"));
                payment.put("transaction_id", rs.getString("transaction_id"));
                payment.put("total_amount", rs.getBigDecimal("total_amount"));
                payment.put("amount_paid", rs.getBigDecimal("amount_paid"));
                
                payments.add(payment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("payments", payments);
        request.getRequestDispatcher("total_payments.jsp").forward(request, response);
    }
}
