<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register and Login</title>
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

        .container {
            margin-top: 7rem;
            padding: 2rem;
            display: flex;
            justify-content: space-around;
            gap: 2rem;
        }

        .form-container {
            background: #fff;
            padding: 2rem;
            border-radius: 5px;
            color: #000;
            width: 45%;
        }

        .form-container h2 {
            margin-top: 0;
            text-align: center;
        }

        .input-group {
            margin-bottom: 1rem;
        }

        .input-group label {
            display: block;
            margin-bottom: 0.5rem;
        }

        .input-group input {
            width: 100%;
            padding: 0.75rem;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 1rem;
        }

        .input-group .input-highlight {
            display: none; /* For highlighting purposes, can be styled if needed */
        }

        .form-container button {
            background: #007bff;
            color: #fff;
            padding: 1rem;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
        }

        .form-container button:hover {
            background: #0056b3;
        }

        .error-message, .message {
            color: red;
            margin-top: 1rem;
            text-align: center;
        }

        .success {
            color: green;
        }

        .or-divider {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 2rem 0;
            position: relative;
        }

        .or-divider::before, .or-divider::after {
            content: "";
            flex: 1;
            height: 1px;
            background: #ddd;
        }

        .or-divider::before {
            margin-right: 1rem;
        }

        .or-divider::after {
            margin-left: 1rem;
        }

        .or-divider span {
            background: #fff;
            padding: 1rem;
            font-weight: bold;
    		border-radius: 30px;
            font-size: 1.2rem;
            color: #000;
        }
    </style>
</head>
<body>
    <header>
        <h1>User Management</h1>
    </header>

    <div class="container">
        <!-- Registration Form -->
        <div class="form-container">
            <h2>Register</h2>
            <form action="RegisterServlet" method="post">
                <div class="input-group">
                    <label for="register_email">Email:</label>
                    <input type="email" id="register_email" name="login_id" required>
                    <div class="input-highlight"></div>
                </div>
                <div class="input-group">
                    <label for="register_password">Password:</label>
                    <input type="password" id="register_password" name="password" required>
                    <div class="input-highlight"></div>
                </div>
                <div class="input-group">
                    <label for="confirm_password">Confirm Password:</label>
                    <input type="password" id="confirm_password" name="confirm_password" required>
                    <div class="input-highlight"></div>
                </div>
                <button type="submit">Register</button>
                <div class="error-message">
                    <% String error = (String) request.getAttribute("error");
                       if (error != null) { %>
                           <%= error %>
                    <% } %>
                </div>
            </form>
        </div>

        <!-- OR Divider -->
        <div class="or-divider">
            <span>OR</span>
        </div>

        <!-- Login Form -->
        <div class="form-container">
            <h2>Login</h2>
            <form action="LoginServlet" method="post">
                <div class="input-group">
                    <label for="login_email">Email:</label>
                    <input type="email" id="login_email" name="login_id" required>
                    <div class="input-highlight"></div>
                </div>
                <div class="input-group">
                    <label for="login_password">Password:</label>
                    <input type="password" id="login_password" name="password" required>
                    <div class="input-highlight"></div>
                </div>
                <button type="submit">Login</button>
                <div class="message">
                    <% String error1 = request.getParameter("error1");
                       String message = request.getParameter("message1");
                       if (error1 != null) { %>
                           <span class="error"><%= error1 %></span>
                    <% } else if (message != null) { %>
                           <span class="success"><%= message %></span>
                    <% } %>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
