package com.controllers;

import com.jdbc.JDBC_Connection;
import com.model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/CustomerSyncServlet")
public class CustomerSyncServlet extends HttpServlet {
    
    private static final String AUTH_URL = "https://qa.sunbasedata.com/sunbase/portal/api/assignment_auth.jsp";
    private static final String CUSTOMER_LIST_URL = "https://qa.sunbasedata.com/sunbase/portal/api/assignment.jsp?cmd=get_customer_list";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session=request.getSession();
    	Integer orgId = (Integer) session.getAttribute("orgId");
    	String token = authenticateAndGetToken();
        if (token == null) {
            response.sendRedirect("login.jsp?error=Unable to authenticate");
            return;
        }
        
        List<Customer> remoteCustomers = fetchRemoteCustomers(token);
        updateDatabase(remoteCustomers,orgId);

        response.sendRedirect("customers");
    }

    private String authenticateAndGetToken() throws IOException {
        String authUrl = "https://qa.sunbasedata.com/sunbase/portal/api/assignment_auth.jsp";
        String loginId = "test@sunbasedata.com";
        String password = "Test@123";
        
        URL url = new URL(authUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json; utf-8");
        connection.setDoOutput(true);

        // JSON request payload
        String jsonInputString = "{ \"login_id\": \"" + loginId + "\", \"password\": \"" + password + "\" }";

        try (OutputStream os = connection.getOutputStream()) {
            byte[] input = jsonInputString.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        int code = connection.getResponseCode();
        if (code != HttpURLConnection.HTTP_OK) {
            throw new RuntimeException("Failed : HTTP error code : " + code);
        }

        BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
        StringBuilder response = new StringBuilder();
        String responseLine;
        while ((responseLine = br.readLine()) != null) {
            response.append(responseLine.trim());
        }

        connection.disconnect();

        // Parse the JSON response to get the access token
        JSONObject jsonResponse = new JSONObject(response.toString());
        if (jsonResponse.has("access_token")) {
            return jsonResponse.getString("access_token");
        } else {
            throw new RuntimeException("Token not found in response");
        }
    }

    private List<Customer> fetchRemoteCustomers(String token) throws IOException {
        URL url = new URL(CUSTOMER_LIST_URL);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Authorization", "Bearer " + token);

        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            response.append(line);
        }
        reader.close();
        connection.disconnect();

        JSONArray jsonArray = new JSONArray(response.toString());
        List<Customer> customers = new ArrayList<>();

        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonCustomer = jsonArray.getJSONObject(i);
            Customer customer = new Customer();
//            customer.setId(Integer.parseInt(jsonCustomer.getString("uuid"))); // Assuming 'uuid' is mapped to 'id'
            customer.setFirstName(jsonCustomer.getString("first_name"));
            customer.setLastName(jsonCustomer.getString("last_name"));
            customer.setAddress(jsonCustomer.getString("address"));
            customer.setCity(jsonCustomer.getString("city"));
            customer.setState(jsonCustomer.getString("state"));
            customer.setEmail(jsonCustomer.getString("email"));
            customer.setPhone(jsonCustomer.getString("phone"));
            customers.add(customer);
        }
        return customers;
    }

    private void updateDatabase(List<Customer> customers,Integer orgId) throws ServletException {
        try (Connection connection = JDBC_Connection.getConnection()) {
            String sql = "INSERT INTO customer (first_name, last_name, address, city, state, email, phone, orgId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)" +
                         "ON DUPLICATE KEY UPDATE first_name = VALUES(first_name), last_name = VALUES(last_name), " +
                         "address = VALUES(address), city = VALUES(city), " +
                         "state = VALUES(state), email = VALUES(email), phone = VALUES(phone), orgId=VALUES(orgId)";
            PreparedStatement statement = connection.prepareStatement(sql);

            for (Customer customer : customers) {
//                statement.setInt(1, customer.getId());
                statement.setString(1, customer.getFirstName());
                statement.setString(2, customer.getLastName());
                statement.setString(3, customer.getAddress());
                statement.setString(4, customer.getCity());
                statement.setString(5, customer.getState());
                statement.setString(6, customer.getEmail());
                statement.setString(7, customer.getPhone());
                statement.setInt(8, orgId);
                statement.addBatch();
            }
            statement.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
