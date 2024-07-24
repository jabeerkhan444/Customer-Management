<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Customer</title>
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
            background: rgba(0, 0, 0, 0.6);
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

        .nav-buttons a {
            color: #fff;
            text-decoration: none;
            background: #007bff;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            font-size: 1rem;
            margin: 1 0.5rem;
            transition: background-color 0.3s;
        }

        .nav-buttons a:hover {
            background: #0056b3;
        }

        .container {
            margin-top: 7rem;
            padding: 2rem;
        }

        .form-container {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            padding: 2rem;
            border-radius: 5px;
            color: #000;
        }

        .form-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .form-row div {
            width: 48%;
        }

        .form-row input, .form-row select {
            width: 100%;
            padding: 0.75rem;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 1rem;
        }

        .form-row input[type="submit"] {
            background: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
        }

        .form-row input[type="submit"]:hover {
            background: #0056b3;
        }

        .form-row input[type="submit"]:disabled {
            background: #ccc;
            cursor: not-allowed;
        }

        .form-container h2 {
            margin-top: 0;
        }

        .back-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 20px;
            transition: background-color 0.3s;
        }

        .back-button:hover {
            background-color: #0056b3;
        }

        .nav-buttons {
            margin-right: 5%;
        }
    </style>
</head>
<body>
    <header>
        <h1>Customer Management</h1>
    </header>

    <div class="container">
    <div class="form-container">
        <div class="nav-buttons">
            <a href="customers" class="back-button">Back to Customer List</a>
        </div>
        <h2>Add New Customer</h2>
        <form action="addCustomerServlet" method="post">
            <div class="form-row">
                    <div>
                        <label for="first_name">First Name</label>
                        <input type="text" id="first_name" name="first_name" required>
                    </div>
                    <div>
                        <label for="last_name">Last Name</label>
                        <input type="text" id="last_name" name="last_name" required>
                    </div>
                </div>
                <div class="form-row">
                    <div>
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" required>
                    </div>
                    <div>
                        <label for="city">City</label>
                        <input type="text" id="city" name="city" required>
                    </div>
                </div>
                <div class="form-row">
                    <div>
                        <label for="state">State</label>
                        <input type="text" id="state" name="state" required>
                    </div>
                    <div>
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                </div>
                <div class="form-row">
                    <div>
                        <label for="phone">Phone</label>
                        <input type="text" id="phone" name="phone" required>
                    </div>
                </div>
                <div class="form-row">
                    <input type="submit" value="Add Customer">
                </div>
        </form>
        </div>
    </div>
</body>
</html>
