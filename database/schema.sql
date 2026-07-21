-- =====================================================
-- RevenuePilot AI Database Schema
-- =====================================================

CREATE DATABASE IF NOT EXISTS revenuepilot;
USE revenuepilot;

-- =====================================================
-- Table: company
-- Description: Stores customer organizations using RevenuePilot AI
-- =====================================================

CREATE TABLE company (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(150) NOT NULL,
    industry VARCHAR(100) NOT NULL,
    company_size ENUM('Startup','SMB','Mid-Market','Enterprise') NOT NULL,
    country VARCHAR(100) NOT NULL,
    website VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);
