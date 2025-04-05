package com.servlet;

import java.io.File;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;


@WebServlet("/EditProfileServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class EditProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String oldUsername = request.getParameter("username");
        String newUsername = request.getParameter("new_username");
        String newUserEmail = request.getParameter("new_useremail");
        String contactNo = request.getParameter("contact_no");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        Part filePart = request.getPart("profile_image");
        String fileName = (filePart != null && filePart.getSize() > 0) ? filePart.getSubmittedFileName() : "";
      
        // Define upload directory
        String uploadDir = "D:/RentEasy/RentEasy/src/main/webapp/uploads/";
        String filePath = uploadDir + fileName;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_db", "root", "root");

            // Construct the update query dynamically
            StringBuilder query = new StringBuilder("UPDATE users SET username=?, email=?");
            if (!password.isEmpty()) {
                query.append(", password=?");
            }
            if (!fileName.isEmpty()) {
                query.append(", profile_image=?");
                filePart.write(filePath); // Save the file
            }
            if (!fileName.isEmpty()) {
                session.setAttribute("profile_image", fileName);
            }

            query.append(" WHERE username=?");

            PreparedStatement ps = conn.prepareStatement(query.toString());
            ps.setString(1, newUsername);
            ps.setString(2, newUserEmail);

            int index = 3;
            if (!password.isEmpty()) {
                ps.setString(index++, password);
            }
            if (!fileName.isEmpty()) {
                ps.setString(index++, fileName);
            }
            ps.setString(index, oldUsername);

            int result = ps.executeUpdate();
            conn.close();

            if (result > 0) {
                // Update session attributes
                session.setAttribute("username", newUsername);
                session.setAttribute("useremail", newUserEmail);
                if (!fileName.isEmpty()) {
                    session.setAttribute("profile_image", fileName);
                }
                response.sendRedirect("dashboard.jsp?success=Profile Updated");
            } else {
                response.sendRedirect("dashboard.jsp?error=Update Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=An error occurred");
        }
    }
}