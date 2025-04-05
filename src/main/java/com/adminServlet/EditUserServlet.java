package com.adminServlet;



import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/Admin/EditUserServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class EditUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("user_id");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String contactNo = request.getParameter("contact_no");
        String address = request.getParameter("address");

        Part filePart = request.getPart("profile_image");
        String fileName = (filePart != null && filePart.getSize() > 0) ? filePart.getSubmittedFileName() : "";

        // Define upload directory
        String uploadDir = "D:/RentEasy/RentEasy/src/main/webapp/uploads/";
        String filePath = uploadDir + fileName;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_db", "root", "root");

            // Get existing user data
            PreparedStatement psSelect = conn.prepareStatement("SELECT profile_image FROM users WHERE user_id=?");
            psSelect.setString(1, userId);
            ResultSet rs = psSelect.executeQuery();

            String existingImage = "default.jpg";
            if (rs.next()) {
                existingImage = rs.getString("profile_image");
                if (existingImage == null || existingImage.isEmpty()) {
                    existingImage = "default.jpg";
                }
            }
            rs.close();
            psSelect.close();

            // Use existing profile image if no new image is uploaded
            if (fileName.isEmpty()) {
                fileName = existingImage;
            } else {
                filePart.write(filePath); // Save the new profile image
            }

            // Build query dynamically
            String sql = "UPDATE users SET username=?, email=?, contact_no=?, address=?, profile_image=? WHERE user_id=?";
            PreparedStatement psUpdate = conn.prepareStatement(sql);

            psUpdate.setString(1, username);
            psUpdate.setString(2, email);
            psUpdate.setString(3, contactNo);
            psUpdate.setString(4, address);
            psUpdate.setString(5, fileName);
            psUpdate.setString(6, userId);

            int result = psUpdate.executeUpdate();
            conn.close();

            if (result > 0) {
                response.sendRedirect("admin_dashboard.jsp?success=User Updated");
            } else {
                response.sendRedirect("EditUser.jsp?user_id=" + userId + "&error=Update Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("EditUser.jsp?user_id=" + userId + "&error=An error occurred");
        }
    }
}
