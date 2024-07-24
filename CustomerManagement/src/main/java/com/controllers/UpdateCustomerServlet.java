package com.controllers;

import com.jdbc.JDBC_Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/updateCustomer")
public class UpdateCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        try (Connection connection = JDBC_Connection.getConnection()) {
            String sql = "SELECT * FROM customer WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                request.setAttribute("customer", rs);
                request.getRequestDispatcher("updateCustomer.jsp").forward(request, response);
            } else {
                response.sendRedirect("customers?action=list&error=Customer not found");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("customers?action=list&error=Database error occurred");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session=request.getSession();
    	int id = Integer.parseInt(request.getParameter("id"));
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int orgId = (int)session.getAttribute("orgId");

        try (Connection connection = JDBC_Connection.getConnection()) {
            String sql = "UPDATE customer SET first_name = ?, last_name = ?, address = ?, city = ?, state = ?, email = ?, phone = ?, orgId = ? WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, firstName);
            statement.setString(2, lastName);
            statement.setString(3, address);
            statement.setString(4, city);
            statement.setString(5, state);
            statement.setString(6, email);
            statement.setString(7, phone);
            statement.setInt(8, orgId);
            statement.setInt(9, id);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("customers?action=list");
    }
}
