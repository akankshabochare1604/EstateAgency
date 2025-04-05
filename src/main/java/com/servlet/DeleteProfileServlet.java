package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/DeleteProfileServlet")
public class DeleteProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String useremail = request.getParameter("useremail");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_db", "root", "root");

            // Delete User
            PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE email=?");
            ps.setString(1, useremail);
            int result = ps.executeUpdate();

            conn.close();

            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); // Logout user
            }

            if (result > 0) {
                // Redirect to homepage after deletion
                response.sendRedirect("/Home.jsp?message=Profile Deleted Successfully");
            } else {
                response.sendRedirect("dashboard.jsp?error=Deletion Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=Server Error");
        }
    }
}

