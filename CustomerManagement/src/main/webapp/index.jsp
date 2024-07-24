<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
    <style>
        /* General Styles */
        body {
            margin: 0;
            background: linear-gradient(135deg, #ff6f61, #de64a7);
            color: #fff;
        }

        header {
            position: fixed;
            width: 100%;
            background: #263238;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            margin: 0;
            font-size: 2rem;
        }

        .nav-buttons {
            display: flex;
            align-items: center;
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

        .search-container {
            margin: 0 2rem;
        }

        .search-container input {
            width: 200px;
            padding: 0.75rem;
            border-radius: 5px 0 0 5px;
            border: none;
            font-size: 1rem;
            outline: none;
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
        }

        .search-container button:hover {
            background: #0056b3;
        }

        .search-container button i {
            color: #fff;
            font-size: 1rem;
        }

        .start-button-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 5rem);
        }

        .start-button {
            background: #28a745;
            color: #fff;
            padding: 1rem 2rem;
            border-radius: 5px;
            font-size: 1.5rem;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .start-button:hover {
            background: #218838;
        }

        .quotes {
            margin-top: 2rem;
            font-size: 1.25rem;
            text-align: center;
        }

        .quotes blockquote {
            margin: 0;
            padding: 1rem;
            border-left: 5px solid #ff6f61;
            background: rgba(0, 0, 0, 0.4);
            border-radius: 5px;
        }

        .nav-buttons{
        	margin-right: 5%;
        }
    </style>
    <!-- Add Font Awesome for search icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <header>
        <h1>My Application</h1>
        <div class="nav-buttons">
            <div class="search-container">
                <input type="text" placeholder="Search...">
                <button><i class="fas fa-search"></i></button>
            </div>
            <a href="loginOrRegister.jsp">Register / Login</a>
        </div>
    </header>

    <div class="start-button-container">
        <button class="start-button">Get Started</button>
        <div class="quotes">
            <blockquote>"The best way to predict the future is to invent it." - Alan Kay</blockquote>
            <blockquote>"Success is not the key to happiness. Happiness is the key to success." - Albert Schweitzer</blockquote>
        </div>
    </div>
</body>
</html>
