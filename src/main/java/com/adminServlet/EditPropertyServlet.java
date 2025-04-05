package com.adminServlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import com.db.DBConnect;

@WebServlet("/EditPropertyServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10, // 10MB
                 maxRequestSize = 1024 * 1024 * 50) // 50MB

public class EditPropertyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        try {
            int propertyId = Integer.parseInt(request.getParameter("property_id"));
            String title = request.getParameter("title");
            String location = request.getParameter("location");
            String price = request.getParameter("price");
            String type = request.getParameter("type");
            String status = request.getParameter("status");
            String mapLocation = request.getParameter("map_location");

            // Get old image names
            String oldImage1 = request.getParameter("old_image1");
            String oldImage2 = request.getParameter("old_image2");
            String oldImage3 = request.getParameter("old_image3");

            // Set upload path
            String uploadPath = getServletContext().getRealPath("/images/properties");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Handle multiple images
            String[] imageFields = {"image1", "image2", "image3"};
            String[] imageNames = {oldImage1, oldImage2, oldImage3};

            for (int i = 0; i < imageFields.length; i++) {
                Part part = request.getPart(imageFields[i]);
                if (part != null && part.getSize() > 0) {
                    String fileName = System.currentTimeMillis() + "_" + part.getSubmittedFileName();
                    String filePath = uploadPath + File.separator + fileName;
                    part.write(filePath);
                    imageNames[i] = fileName; // Update with new file
                }
            }

            // Update property details in the database
            Connection conn = DBConnect.getConnection();
            String sql = "UPDATE properties SET title=?, location=?, price=?, type=?, status=?, map_location=?, image1=?, image2=?, image3=? WHERE property_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, location);
            stmt.setString(3, price);
            stmt.setString(4, type);
            stmt.setString(5, status);
            stmt.setString(6, mapLocation);
            stmt.setString(7, imageNames[0]); // Image 1
            stmt.setString(8, imageNames[1]); // Image 2
            stmt.setString(9, imageNames[2]); // Image 3
            stmt.setInt(10, propertyId);

            int rowsUpdated = stmt.executeUpdate();
            conn.close();

            if (rowsUpdated > 0) {
                response.sendRedirect("Admin/view_properties.jsp?msg=Property Updated Successfully");
            } else {
                out.println("<h3 style='color:red;'>Update Failed</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
