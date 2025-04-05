package com.adminServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Admin/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String adminEmail = request.getParameter("admin_email");
        String adminPassword = request.getParameter("admin_password");

        // Validate input
        if (adminEmail == null || adminEmail.trim().isEmpty() || adminPassword == null || adminPassword.trim().isEmpty()) {
            response.getWriter().println("<script>alert('Email and Password cannot be empty!'); window.location='AdminLogin.jsp';</script>");
            return;
        }

        try (Connection conn = DBConnect.getConnection()) {
            // Check if email exists
            String checkEmailQuery = "SELECT * FROM admins WHERE admin_email = ?";
            try (PreparedStatement checkEmailStmt = conn.prepareStatement(checkEmailQuery)) {
                checkEmailStmt.setString(1, adminEmail);
                try (ResultSet emailRs = checkEmailStmt.executeQuery()) {
                    if (!emailRs.next()) {
                        response.getWriter().println("<script>alert('No account found with this email. Please register!'); window.location='AdminRegister.jsp';</script>");
                        return;
                    }
                }
            }

            // Validate password
            String query = "SELECT * FROM admins WHERE admin_email = ? AND admin_password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, adminEmail);
                stmt.setString(2, adminPassword);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // Create session for the admin
                        HttpSession session = request.getSession();
                        session.setAttribute("admin_id", rs.getInt("admin_id"));
                        session.setAttribute("admin_name", rs.getString("admin_name"));
                        session.setAttribute("admin_email", rs.getString("admin_email"));

                        response.sendRedirect("AdminProfile.jsp");
                    } else {
                        response.getWriter().println("<script>alert('Incorrect password. Please try again!'); window.location='AdminLogin.jsp';</script>");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred! Please try again.'); window.location='AdminLogin.jsp';</script>");
        }
    }
}
