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

@WebServlet("/PropertyDetailsServlet")
public class PropertyDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String propertyIdStr = request.getParameter("property_id");

        if (propertyIdStr == null || propertyIdStr.isEmpty()) {
            response.sendRedirect("user_properties.jsp?error=Property ID Missing");
            return;
        }

        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            Connection conn = DBConnect.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM properties WHERE property_id = ?");
            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("property", rs);
                request.getRequestDispatcher("property_details.jsp").forward(request, response);
            } else {
                response.sendRedirect("user_properties.jsp?error=Property Not Found");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user_properties.jsp?error=Database Error");
        }
    }
}
