package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RemoveWishlistServlet")
public class RemoveWishlistServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        String propertyIdStr = request.getParameter("property_id");

        if (userId == null || propertyIdStr == null) {
            response.sendRedirect("login.jsp?error=Unauthorized access.");
            return;
        }

        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            Connection conn = DBConnect.getConnection();
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM wishlist WHERE user_id = ? AND property_id = ?");
            stmt.setInt(1, userId);
            stmt.setInt(2, propertyId);
            stmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("my_wishlist.jsp?message=Property removed from wishlist.");
    }
}
