<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer List</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #ff6f61, #de64a7);
            color: #fff;
        }

        header {
            position: fixed;
            top: 0;
            width: 100%;
            background: #263238;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1000;
        }

        header h1 {
            margin: 0;
            font-size: 2rem;
        }

        .nav-buttons {
            display: flex;
            align-items: center;
        }

        .nav-buttons .search-container {
            display: flex;
            align-items: center;
            margin-right: 1rem;
        }

        .search-container input, .search-container select {
            padding: 0.75rem;
            border-radius: 5px 0 0 5px;
            border: none;
            font-size: 1rem;
            outline: none;
        }

        .search-container select {
            margin-right: 5px;
        }

        .search-container input::placeholder {
            color: #999;
        }

        .search-container button {
            background: #007bff;
            border: none;
            padding: 0.75rem;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search-container button:hover {
            background: #0056b3;
        }

        .search-container button i {
            color: #fff;
            font-size: 1rem;
        }

        .nav-buttons a {
            color: #fff;
            text-decoration: none;
            background: #007bff;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            font-size: 1rem;
            margin: 0 0.5rem;
            transition: background-color 0.3s;
        }

        .nav-buttons a:hover {
            background: #0056b3;
        }

        .container {
            margin-top: 7rem;
            padding: 2rem;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .table-header h2 {
            margin: 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            color: #000;
            border-radius: 5px;
            overflow: hidden;
        }

        table th, table td {
            padding: 1rem;
            text-align: left;
        }

        table th {
            background: #007bff;
            color: #fff;
        }

        table tr:nth-child(even) {
            background: #f2f2f2;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .action-buttons a {
            text-decoration: none;
            color: #fff;
            padding: 0.5rem 1rem;
            border-radius: 5px;
        }

        .edit-button {
            background: #ffc107;
        }

        .delete-button {
            background: #dc3545;
        }

        .add-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .add-button:hover {
            background-color: #218838;
        }

        .sync-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .sync-button:hover {
            background-color: #0056b3;
        }

        .nav-buttons {
            margin-right: 5%;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <header>
        <h1>Customer Management</h1>
        <div class="nav-buttons">
            <div class="search-container">
                <form action="SearchServlet" method="get">
                    <select name="criteria">
                        <option value="first_name">First Name</option>
                        <option value="city">City</option>
                        <option value="email">Email</option>
                        <option value="phone">Phone</option>
                    </select>
                    <input type="text" name="searchTerm" placeholder="Search..." required>
                    <button type="submit"><i class="fas fa-search"></i></button>
                </form>
            </div>
            <a href="addCustomer.jsp" class="add-button">Add New Customer</a>
            <a href="CustomerSyncServlet" class="sync-button">Sync</a>
            <a href="index.jsp">Logout</a>
        </div>
    </header>

    <div class="container">
        <div class="table-header">
            <h2>All Customers</h2>
        </div>
        <table>
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Address</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                    if (customers != null && !customers.isEmpty()) {
                        for (Customer customer : customers) {
                %>
                    <tr>
                        <td><%= customer.getFirstName() %></td>
                        <td><%= customer.getLastName() %></td>
                        <td><%= customer.getAddress() %></td>
                        <td><%= customer.getCity() %></td>
                        <td><%= customer.getState() %></td>
                        <td><%= customer.getEmail() %></td>
                        <td><%= customer.getPhone() %></td>
                        <td class="action-buttons">
                            <a href="updateCustomer.jsp?id=<%= customer.getId() %>" class="edit-button">Edit</a>
                            <a href="deleteCustomer?id=<%= customer.getId() %>" class="delete-button">Delete</a>
                        </td>
                    </tr>
                <% 
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="8" style="text-align: center;">No customers found</td>
                    </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
