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

@WebServlet("/user/ContactServlet")
public class ContactServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String name=req.getParameter("name");
		String email=req.getParameter("email");
		String subject=req.getParameter("subject");
		String message=req.getParameter("message");
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection c=DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_db","root","root");
			PreparedStatement ps=c.prepareStatement("Insert into contact_messages(name,email,subject,message)values(?,?,?,?)");
			ps.setString(1, name);
			ps.setString(2,email);
			ps.setString(3,subject);
			ps.setString(4, message);
			
			int rowsInserted=ps.executeUpdate();
			if(rowsInserted>0) {
				resp.getWriter().println("<script>alert('Message Submitted Successfully..!');window.location='contact.jsp';</script>");
			}else {
                resp.getWriter().println("<script>alert('Failed to send message!');window.location='contact.jsp';</script>");
            }
		
		
			c.close();
		}catch(Exception e){
			 e.printStackTrace();
	            resp.getWriter().println("<script>alert('Failed to send message!');window.location='contact.jsp';</script>");
	        } 
		
	}

}
