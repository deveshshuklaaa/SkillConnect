-- SkillConnect Database Schema

CREATE DATABASE IF NOT EXISTS skillconnect;
USE skillconnect;

-- Users table (for customers and workers)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role ENUM('customer', 'worker') NOT NULL,
    location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Worker skills table
CREATE TABLE worker_skills (
    worker_id INT,
    skill_name VARCHAR(50),
    PRIMARY KEY (worker_id, skill_name),
    FOREIGN KEY (worker_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Services table
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    worker_id INT,
    service_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2),
    status ENUM('active', 'inactive') DEFAULT 'active',
    FOREIGN KEY (worker_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Bookings table
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    worker_id INT,
    service_id INT,
    booking_date DATE NOT NULL,
    booking_time TIME NOT NULL,
    status ENUM('pending', 'confirmed', 'completed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (worker_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE
);

-- Ratings table
CREATE TABLE ratings (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    customer_id INT,
    worker_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    feedback TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (worker_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Admin table
CREATE TABLE admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample data
INSERT INTO admin (username, password) VALUES ('admin@skillconnect.com', 'admin123'); -- Note: In production, hash passwords

INSERT INTO users (name, email, password, phone, role, location) VALUES
('John Doe', 'john@example.com', 'password123', '1234567890', 'customer', 'Delhi'),
('Jane Smith', 'jane@example.com', 'password123', '0987654321', 'worker', 'Mumbai'),
('Bob Johnson', 'bob@example.com', 'password123', '1122334455', 'worker', 'Bangalore');

INSERT INTO worker_skills (worker_id, skill_name) VALUES
(2, 'Electrician'),
(2, 'Plumber'),
(3, 'Carpenter');

INSERT INTO services (worker_id, service_name, price, status) VALUES
(2, 'Electrical Repair', 50.00, 'active'),
(2, 'Plumbing Fix', 40.00, 'active'),
(2, 'Wiring Installation', 70.00, 'active'),
(2, 'Pipe Repair', 45.00, 'active'),
(3, 'Woodwork', 60.00, 'active'),
(3, 'Furniture Assembly', 30.00, 'active'),
(3, 'Cabinet Installation', 80.00, 'active');

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Add category_id to services table
ALTER TABLE services 
ADD COLUMN category_id INT AFTER status,
ADD FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL;

-- Sample categories
INSERT INTO categories (category_name, description) VALUES
('Electrical', 'Electrical services like wiring and repairs'),
('Plumbing', 'Plumbing and pipe services'),
('Carpentry', 'Woodwork and furniture services');

-- Update sample services with category_ids
UPDATE services SET category_id = 1 WHERE service_name IN ('Electrical Repair', 'Wiring Installation');
UPDATE services SET category_id = 2 WHERE service_name IN ('Plumbing Fix', 'Pipe Repair');
UPDATE services SET category_id = 3 WHERE service_name IN ('Woodwork', 'Furniture Assembly', 'Cabinet Installation');
