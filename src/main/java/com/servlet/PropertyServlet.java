package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.db.DBConnect;

@WebServlet("/PropertyServlet")
public class PropertyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<HashMap<String, String>> properties = new ArrayList<>();

        try {
            Connection conn = DBConnect.getConnection();
            String sql = "SELECT * FROM properties WHERE status='available'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                HashMap<String, String> property = new HashMap<>();
                property.put("property_id", String.valueOf(rs.getInt("property_id")));
                property.put("title", rs.getString("title"));
                property.put("location", rs.getString("location"));
                property.put("price", rs.getString("price"));
                property.put("type", rs.getString("type"));
                property.put("image1", rs.getString("image1"));

                properties.add(property);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("properties", properties);
        request.getRequestDispatcher("user_properties.jsp").forward(request, response);
    }
}
