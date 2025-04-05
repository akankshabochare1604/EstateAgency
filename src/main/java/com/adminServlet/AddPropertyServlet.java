package com.adminServlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/Admin/AddPropertyServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, 
    maxFileSize = 1024 * 1024 * 10,     
    maxRequestSize = 1024 * 1024 * 50    
)
public class AddPropertyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        int area = Integer.parseInt(request.getParameter("area"));
        int beds = Integer.parseInt(request.getParameter("beds"));
        String type = request.getParameter("type");
        String status = request.getParameter("status");
        double price = Double.parseDouble(request.getParameter("price"));
        String mapLocation = request.getParameter("map_location");

        // ✅ FIXED UPLOAD PATH
        String uploadPath = "D:/RentEasy/RentEasy/src/main/webapp/images/properties/";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); 
        }

        // ✅ SAVE IMAGES CORRECTLY
        Part part1 = request.getPart("image1");
        Part part2 = request.getPart("image2");
        Part part3 = request.getPart("image3");

        String image1 = saveFile(part1, uploadPath);
        String image2 = saveFile(part2, uploadPath);
        String image3 = saveFile(part3, uploadPath);

        Connection con = null;
        PreparedStatement stmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_db", "root", "root");

            String sql = "INSERT INTO properties (title, description, location, area, beds, type, status, price, map_location, image1, image2, image3) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            stmt = con.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setString(3, location);
            stmt.setInt(4, area);
            stmt.setInt(5, beds);
            stmt.setString(6, type);
            stmt.setString(7, status);
            stmt.setDouble(8, price);
            stmt.setString(9, mapLocation);
            stmt.setString(10, image1);
            stmt.setString(11, image2);
            stmt.setString(12, image3);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("view_properties.jsp");
            } else {
                response.sendRedirect("AddProperty.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    // ✅ SAVE FILE WITHOUT `tmp0/`
    private String saveFile(Part part, String uploadPath) throws IOException {
        String fileName = null;
        if (part != null && part.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + part.getSubmittedFileName();
            File file = new File(uploadPath, fileName);
            try (InputStream fileContent = part.getInputStream();
                 FileOutputStream fos = new FileOutputStream(file)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fileContent.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
                System.out.println("✅ File saved at: " + file.getAbsolutePath());
            }
        } else {
            System.out.println("❌ No file selected or empty file.");
        }
        return fileName;
    }
}
