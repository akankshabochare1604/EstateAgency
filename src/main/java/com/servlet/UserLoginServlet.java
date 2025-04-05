package com.servlet;

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

@WebServlet("/user/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String useremail = request.getParameter("useremail");
        String password = request.getParameter("password");
        String redirectURL = request.getParameter("redirect");  // Get redirect URL
        HttpSession session = request.getSession();

        try {
            Connection conn = DBConnect.getConnection();

            // Check if email exists
            String checkEmailQuery = "SELECT * FROM users WHERE email=?";
            PreparedStatement checkEmailPs = conn.prepareStatement(checkEmailQuery);
            checkEmailPs.setString(1, useremail);
            ResultSet emailRs = checkEmailPs.executeQuery();

            if (!emailRs.next()) {
                session.setAttribute("error", "No user exists with these credentials!");
                response.sendRedirect("login.jsp");
                return;
            }

            // Check password
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, useremail);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("user_id", rs.getInt("user_id"));
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("useremail", rs.getString("email"));
                session.setAttribute("profile_image", rs.getString("profile_image"));

                session.setAttribute("message", "Login successful!");

                // If a redirect URL exists, send the user there
                if (redirectURL != null && !redirectURL.isEmpty()) {
                    response.sendRedirect(redirectURL);
                } else {
                    response.sendRedirect("dashboard.jsp");
                }
            } else {
                session.setAttribute("error", "Invalid password!");
                response.sendRedirect("login.jsp");
            }

            rs.close();
            ps.close();
            checkEmailPs.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Something went wrong! Try again.");
            response.sendRedirect("login.jsp");
        }
    }
}
