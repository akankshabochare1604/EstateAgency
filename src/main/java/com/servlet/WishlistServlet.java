package com.servlet;



import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.db.DBConnect;

@WebServlet("/user/WishlistServlet")
public class WishlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        String propertyIdStr = request.getParameter("property_id");
        if (propertyIdStr == null) {
            response.sendRedirect("user_properties.jsp?error=Invalid property ID");
            return;
        }

        int propertyId = Integer.parseInt(propertyIdStr);

        try {
            Connection conn = DBConnect.getConnection();

            // Check if property is already in wishlist
            PreparedStatement checkStmt = conn.prepareStatement(
                    "SELECT * FROM wishlist WHERE user_id = ? AND property_id = ?");
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, propertyId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Remove from wishlist
                PreparedStatement deleteStmt = conn.prepareStatement(
                        "DELETE FROM wishlist WHERE user_id = ? AND property_id = ?");
                deleteStmt.setInt(1, userId);
                deleteStmt.setInt(2, propertyId);
                deleteStmt.executeUpdate();
                response.sendRedirect("wishlist.jsp?message=Removed from wishlist");
            } else {
                // Add to wishlist
                PreparedStatement insertStmt = conn.prepareStatement(
                        "INSERT INTO wishlist (user_id, property_id) VALUES (?, ?)");
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, propertyId);
                insertStmt.executeUpdate();
                response.sendRedirect("wishlist.jsp?message=Added to wishlist");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user_properties.jsp?error=Database error");
        }
    }
}
