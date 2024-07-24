package com.controllers;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.Claims;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Date;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.jdbc.JDBC_Connection;
import com.util.JwtAuthentication;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginId = request.getParameter("login_id");
        String password = request.getParameter("password");

        try (Connection connection = JDBC_Connection.getConnection()) {
            String sql = "SELECT password, orgId FROM organization WHERE loginId = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, loginId);
                ResultSet rs = statement.executeQuery();

                if (rs.next()) {
                    String hashedPassword = rs.getString("password");
                    int orgId = rs.getInt("orgId");

                    if (BCrypt.checkpw(password, hashedPassword)) {
                        JwtAuthentication jwtAuth = new JwtAuthentication();
                        String token = jwtAuth.generateToken(loginId);
                        HttpSession session = request.getSession();
                        session.setAttribute("token", token);
                        session.setAttribute("orgId", orgId);
                        response.sendRedirect("customers?action=list");
                    } else {
                        response.sendRedirect("loginOrRegister.jsp?error1=Wrong Email or Password");
                    }
                } else {
                    response.sendRedirect("loginOrRegister.jsp?error1=User not found");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("loginOrRegister.jsp?error1=Database error occurred.");
        }
    }
}
