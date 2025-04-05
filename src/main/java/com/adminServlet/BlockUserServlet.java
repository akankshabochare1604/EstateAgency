
package com.adminServlet;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.db.DBConnect;

@WebServlet("/Admin/BlockUserServlet")
public class BlockUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("user_id");

        try {
            Connection conn = DBConnect.getConnection();
            String sql = "UPDATE users SET status = 'blocked' WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            int updatedRows = stmt.executeUpdate();
            
            stmt.close();
            conn.close();

            if (updatedRows > 0) {
                response.sendRedirect("ViewUsers.jsp?success=User blocked successfully");
            } else {
                response.sendRedirect("ViewUsers.jsp?error=Failed to block user");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewUsers.jsp?error=An error occurred");
        }
    }
}
