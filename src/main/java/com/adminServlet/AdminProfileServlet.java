package com.adminServlet;

import java.io.File;
import java.io.IOException;
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
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/Admin/AdminProfileServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10, // 10MB
                 maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AdminProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        Integer adminId = (Integer) session.getAttribute("admin_id");

        if (adminId == null) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }

        try (Connection conn = DBConnect.getConnection()) {
            if ("update".equals(action)) {
                // Fetch form data
                String adminName = request.getParameter("admin_name");
                String adminEmail = request.getParameter("admin_email");
                String adminContact = request.getParameter("admin_contact");
                String adminPassword = request.getParameter("admin_password");

                // File Upload
                Part filePart = request.getPart("admin_image");
                String fileName = filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";


                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs(); // Create folder if not exists
                
                if (!fileName.isEmpty()) {
                    filePart.write(uploadPath + File.separator + fileName);
                } else {
                    // Fetch existing image name if no new file is uploaded
                    PreparedStatement stmt = conn.prepareStatement("SELECT admin_image FROM admins WHERE admin_id = ?");
                    stmt.setInt(1, adminId);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) fileName = rs.getString("admin_image");
                    rs.close();
                    stmt.close();
                }

                // Update query
                String updateQuery = "UPDATE admins SET admin_name=?, admin_email=?, admin_contact_no=?, admin_image=?"
                        + (adminPassword.isEmpty() ? "" : ", admin_password=?") + " WHERE admin_id=?";
                PreparedStatement stmt = conn.prepareStatement(updateQuery);
                stmt.setString(1, adminName);
                stmt.setString(2, adminEmail);
                stmt.setString(3, adminContact);stmt.setString(4, fileName); // Store only the filename
                if (!adminPassword.isEmpty()) {
                    stmt.setString(5, adminPassword);
                    stmt.setInt(6, adminId);
                } else {
                    stmt.setInt(5, adminId);
                }
                stmt.executeUpdate();
                stmt.close();

                response.sendRedirect("AdminProfile.jsp");
            } else if ("delete".equals(action)) {
                PreparedStatement stmt = conn.prepareStatement("DELETE FROM admins WHERE admin_id=?");
                stmt.setInt(1, adminId);
                stmt.executeUpdate();
                stmt.close();

                session.invalidate();
                response.sendRedirect("AdminLogin.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred! Please try again.'); window.location='AdminProfile.jsp';</script>");
        }
    }
}
