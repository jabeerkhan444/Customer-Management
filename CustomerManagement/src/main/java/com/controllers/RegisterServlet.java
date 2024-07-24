package com.controllers;

import com.jdbc.JDBC_Connection;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginId = request.getParameter("login_id");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");

        // Validate password confirmation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("loginOrRegister.jsp").forward(request, response);
            return;
        }

        // Check if the login_id already exists
        try (Connection connection = JDBC_Connection.getConnection()) {
            String checkSql = "SELECT COUNT(*) FROM organization WHERE loginId = ?";
            try (PreparedStatement checkStatement = connection.prepareStatement(checkSql)) {
                checkStatement.setString(1, loginId);
                ResultSet resultSet = checkStatement.executeQuery();
                if (resultSet.next() && resultSet.getInt(1) > 0) {
                    request.setAttribute("error", "Email already registered.");
                    request.getRequestDispatcher("loginOrRegister.jsp").forward(request, response);
                    return;
                }
            }

            // Hash the password
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            // Insert into the database
            String insertSql = "INSERT INTO organization (loginId, password) VALUES (?, ?)";
            try (PreparedStatement insertStatement = connection.prepareStatement(insertSql)) {
                insertStatement.setString(1, loginId);
                insertStatement.setString(2, hashedPassword); // Store hashed password
                insertStatement.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred.");
            request.getRequestDispatcher("loginOrRegister.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("loginOrRegister.jsp?message1=Registration successful. Please log in.");
    }
}
