# Customer-Management
## Overview
- This project provides a simple User Management System with functionalities for user registration and login. It is built using Java Servlets, JSP, and MySQL. The system allows users to register an account and log in using their credentials.

## Project Structure
The project consists of the following components:

- Servlets: Java classes handling HTTP requests and responses.
- JSP Pages: HTML pages with embedded Java code for dynamic content.
- Database: MySQL database with tables for user data.
- Configuration: Settings and properties files for database connection and other configurations.

## Database Setup
1. Database Schema
Create a database named 'customers'. Use the following SQL queries to set up the required tables:

- Table for Organization </br>

    CREATE TABLE 'organization' ( </br>
        'orgId' INT AUTO_INCREMENT PRIMARY KEY, </br>
        'login_id' VARCHAR(255) UNIQUE NOT NULL, </br>
        'password' VARCHAR(255) NOT NULL </br>
    ); </br>

- Table for Customers </br>
    CREATE TABLE customer ( </br>
        'id' INT AUTO_INCREMENT PRIMARY KEY, </br>
        'first_name' VARCHAR(50) NOT NULL, </br>
        'last_name' VARCHAR(50) NOT NULL, </br>
        'address' VARCHAR(100),</br>
        'city' VARCHAR(50),</br>
        'state' VARCHAR(100),</br>
        'email' VARCHAR(100) UNIQUE NOT NULL,</br>
        'phone' VARCHAR(20),</br>
        'orgId' INT,</br>
        FOREIGN KEY (orgId) REFERENCES organization(id)</br>
    );</br>
## Eclipse Setup
1. Create a New Dynamic Web Project:

- Open Eclipse.
- Go to File > New > Dynamic Web Project.
- Enter the project name and configure the settings (target runtime, etc.), then click Finish.
2. Add Required JARs to the Project:
  Jar downloaded from https://mvnrepository.com/ </br>
      1. mysql-connector-j-8.3.0
  2. jbcrypt-0.4
  3. json-20210307
  4. jjwt-0.9.1
  5. jaxb-runtime-2.3.1
  6. jaxb-api-2.3.1
  7. javax.mail-1.6.0
  8. jackson-databind-2.13.3
  9. jackson-core-2.13.3
  10. jackson-annotations-2.13.3
  11. activation-1.1

## JSON Web Token(JWT)
- https://jwt.io/ website to get secret key.

