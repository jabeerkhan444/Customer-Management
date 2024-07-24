package com.controllers;

import com.model.Customer;
import com.util.JwtAuthentication;
import com.jdbc.JDBC_Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/customers")
public class CustomerListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String token = (String) session.getAttribute("token");
        Integer orgId = (Integer) session.getAttribute("orgId");

        JwtAuthentication jwtUtil = new JwtAuthentication();
        String username = jwtUtil.validateToken(token);

        if (username == null || jwtUtil.isTokenExpired(token)) {
            response.sendRedirect("login.jsp?error=Unauthorized");
            return;
        }

        List<Customer> customers = new ArrayList<>();

        try (Connection connection = JDBC_Connection.getConnection()) {
            String sql = "SELECT * FROM customer WHERE orgId = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, orgId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Customer customer = new Customer();
                customer.setId(resultSet.getInt("id"));
                customer.setFirstName(resultSet.getString("first_name"));
                customer.setLastName(resultSet.getString("last_name"));
                customer.setAddress(resultSet.getString("address"));
                customer.setCity(resultSet.getString("city"));
                customer.setState(resultSet.getString("state"));
                customer.setEmail(resultSet.getString("email"));
                customer.setPhone(resultSet.getString("phone"));
                customer.setOrganizationId(resultSet.getInt("orgId")); // Set organizationId
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        }

        request.setAttribute("customers", customers);
        request.getRequestDispatcher("allCustomers.jsp").forward(request, response);
    }
}
