package com.controllers;

import com.jdbc.JDBC_Connection;
import com.model.Customer;

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

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String criteria = request.getParameter("criteria");
        String searchTerm = request.getParameter("searchTerm");

        List<Customer> customers = searchCustomers(criteria, searchTerm);

        request.setAttribute("customers", customers);
        request.getRequestDispatcher("allCustomers.jsp").forward(request, response);
    }

    private List<Customer> searchCustomers(String criteria, String searchTerm) throws ServletException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customer WHERE " + criteria + " LIKE ?";

        try (Connection connection = JDBC_Connection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + searchTerm + "%");
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Customer customer = new Customer();
                customer.setId(resultSet.getInt("id"));  // Ensure your Customer class has an id field
                customer.setFirstName(resultSet.getString("first_name"));
                customer.setLastName(resultSet.getString("last_name"));
                customer.setAddress(resultSet.getString("address"));
                customer.setCity(resultSet.getString("city"));
                customer.setState(resultSet.getString("state"));
                customer.setEmail(resultSet.getString("email"));
                customer.setPhone(resultSet.getString("phone"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
        return customers;
    }
}
