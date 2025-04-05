package com.servlet;

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

@WebServlet("/UserRegisterServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB limit
public class UserRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String useremail = request.getParameter("useremail");
        String password = request.getParameter("password");
        Part filePart = request.getPart("profileImage");

        // Define folder path to store the image
        String uploadPath = "D:/RentEasy/RentEasy/src/main/webapp/uploads"; // Change this to your desired folder path
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
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
            String checkQuery = "SELECT * FROM users WHERE username = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, username);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Email already exists
                request.setAttribute("message", "User with this email already exists!");
                request.setAttribute("redirect", "register.jsp");
            } else {
                // Insert new user
                String insertQuery = "INSERT INTO users (username,email, password, profile_image) VALUES (?,?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, username);
                insertStmt.setString(2, useremail);
                insertStmt.setString(3, password);
                insertStmt.setString(4, fileName);

                int result = insertStmt.executeUpdate();
                if (result > 0) {
                    request.setAttribute("message", "Registration Successful! Redirecting to Login...");
                    request.setAttribute("redirect", "login.jsp");
                } else {
                    request.setAttribute("message", "Registration Failed! Please try again.");
                    request.setAttribute("redirect", "register.jsp");
                }
                insertStmt.close();
            }
            checkStmt.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred! Please try again.");
            request.setAttribute("redirect", "register.jsp");
        }

        // Forward to message.jsp to display the popup and handle redirection
        RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
        dispatcher.forward(request, response);
    }
}