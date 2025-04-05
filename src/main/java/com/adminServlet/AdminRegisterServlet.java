package com.adminServlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
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
import jakarta.servlet.RequestDispatcher;

@WebServlet("/Admin/AdminRegisterServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB limit for image uploads
public class AdminRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String adminName = request.getParameter("admin_name");
        String adminEmail = request.getParameter("admin_email");
        String adminContact = request.getParameter("admin_contact_no");
        String adminPassword = request.getParameter("admin_password");
        Part filePart = request.getPart("admin_image");

        // Define folder path to store the image
        String uploadPath = "D:/RentEasy/RentEasy/src/main/webapp/uploads"; // Ensure this folder exists
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fileName = filePart.getSubmittedFileName();
        String filePath = uploadPath + File.separator + fileName;

        // Save file to server
        try (InputStream fileContent = filePart.getInputStream();
             FileOutputStream fos = new FileOutputStream(filePath)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
        }

        // Database operations
        try (Connection conn = DBConnect.getConnection()) {
            // Check if email already exists
            String checkQuery = "SELECT * FROM admins WHERE admin_email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, adminEmail);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Admin email already exists
                request.setAttribute("message", "Admin with this email already exists!");
                request.setAttribute("redirect", "AdminRegister.jsp");
            } else {
                // Insert new admin
                String insertQuery = "INSERT INTO admins (admin_name, admin_email, admin_password, admin_image, admin_contact_no) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, adminName);
                insertStmt.setString(2, adminEmail);
                insertStmt.setString(3, adminPassword);
                insertStmt.setString(4, fileName); // Store only filename, not full path
                insertStmt.setString(5, adminContact);

                int result = insertStmt.executeUpdate();
                if (result > 0) {
                    request.setAttribute("message", "Registration Successful! Redirecting to Login...");
                    request.setAttribute("redirect", "AdminLogin.jsp");
                } else {
                    request.setAttribute("message", "Registration Failed! Please try again.");
                    request.setAttribute("redirect", "AdminRegister.jsp");
                }
                insertStmt.close();
            }
            checkStmt.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred! Please try again.");
            request.setAttribute("redirect", "AdminRegister.jsp");
        }

        // Forward to message.jsp to display alert and handle redirection
        RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
        dispatcher.forward(request, response);
    }
}
