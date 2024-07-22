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

CREATE TABLE users ( </br>
    id INT AUTO_INCREMENT PRIMARY KEY, </br>
    login_id VARCHAR(255) UNIQUE NOT NULL, </br>
    password VARCHAR(255) NOT NULL </br>
); </br>



  
CREATE TABLE `organization` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `loginId` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `customerId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `cusId_idx` (`customerId` ASC) VISIBLE,
  CONSTRAINT `cusId`
    FOREIGN KEY (`customerId`)
    REFERENCES `customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

## JSON Web Token(JWT)
- https://jwt.io/ website to get secret key.

