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

## Screen Shots
- Registration

  ![Screenshot 2024-07-21 231031](https://github.com/user-attachments/assets/cabed7dd-2d8e-41e7-91f8-bba41095891d)

- Login
  
  ![Screenshot 2024-07-21 231302](https://github.com/user-attachments/assets/1b8cc5ef-c8bd-48bf-ac91-de49173df003)

- Add Customer

  ![Screenshot 2024-07-24 150630](https://github.com/user-attachments/assets/62b5489e-cb49-4f80-8a36-b6d4a5bd7125)

- After adding one customer

  ![Screenshot 2024-07-24 150757](https://github.com/user-attachments/assets/4c5f6ea6-4a8b-4ed6-89ae-75cc6b90416e)

- Update Customer

  ![Screenshot 2024-07-24 151225](https://github.com/user-attachments/assets/19ef40f2-7b31-4494-9b00-6a328e233b1d)

- Updated Customer(mail was updated)

  ![Screenshot 2024-07-24 151458](https://github.com/user-attachments/assets/1545af0a-a79f-40dd-bea8-b9c3be099b6b)

- Deleted the above Customer

  ![Screenshot 2024-07-24 152629](https://github.com/user-attachments/assets/9ff350a3-ddaa-4c95-b7af-1f26be831557)

- Synchronized customer list

  ![Screenshot 2024-07-24 152957](https://github.com/user-attachments/assets/98a70dd7-a476-48e3-be62-debd11682220)

- Searched by first name

  ![Screenshot 2024-07-24 153315](https://github.com/user-attachments/assets/59e18e34-5468-4ac6-9e57-b617b85c72f1)

- Searched by city

  ![Screenshot 2024-07-24 153510](https://github.com/user-attachments/assets/aeeecde6-d1d5-495a-9b59-5b95c5d4ec8a)

- Searched by email

  ![Screenshot 2024-07-24 154003](https://github.com/user-attachments/assets/8fa6809c-d723-4ce9-a7c6-85629f74fc40)



