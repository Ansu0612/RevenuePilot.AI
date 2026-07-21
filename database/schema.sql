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


-- =====================================================
-- Table: contact
-- Purpose: Stores contacts associated with customer companies.
-- =====================================================

CREATE TABLE contact (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    job_title VARCHAR(100),
    department VARCHAR(100),
    is_primary_contact BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_contact_company
        FOREIGN KEY (company_id)
        REFERENCES company(company_id)
);
