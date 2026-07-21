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

-- =====================================================
-- Table: marketing_campaign
-- Purpose: Stores marketing campaigns used to generate leads.
-- =====================================================

CREATE TABLE marketing_campaign (
    campaign_id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_name VARCHAR(150) NOT NULL,
    campaign_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    budget DECIMAL(12,2) NOT NULL,
    target_audience VARCHAR(100),
    status ENUM(
        'Planned',
        'Active',
        'Completed',
        'Paused'
    ) DEFAULT 'Planned',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Table: leads
-- Purpose: Stores potential customers generated through marketing campaigns.
-- =====================================================

CREATE TABLE leads (
    lead_id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    company_name VARCHAR(150),
    lead_source VARCHAR(50) NOT NULL,
    lead_status ENUM(
        'New',
        'Contacted',
        'Qualified',
        'Lost'
    ) DEFAULT 'New',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_leads_campaign
        FOREIGN KEY (campaign_id)
        REFERENCES marketing_campaign(campaign_id)
);


-- =====================================================
-- Table: opportunity
-- Purpose: Stores qualified sales opportunities created from leads.
-- =====================================================

CREATE TABLE opportunity (
    opportunity_id INT AUTO_INCREMENT PRIMARY KEY,
    lead_id INT NOT NULL,
    company_id INT NOT NULL,
    opportunity_name VARCHAR(150) NOT NULL,
    stage ENUM(
        'Qualification',
        'Proposal',
        'Negotiation',
        'Won',
        'Lost'
    ) DEFAULT 'Qualification',
    expected_value DECIMAL(12,2) NOT NULL,
    expected_close_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_opportunity_lead
        FOREIGN KEY (lead_id)
        REFERENCES leads(lead_id),

    CONSTRAINT fk_opportunity_company
        FOREIGN KEY (company_id)
        REFERENCES company(company_id)
);


-- =====================================================
-- Table: subscription
-- Purpose: Stores customer subscription details.
-- =====================================================

CREATE TABLE subscription (
    subscription_id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT NOT NULL,
    plan_name VARCHAR(100) NOT NULL,
    billing_cycle ENUM(
        'Monthly',
        'Quarterly',
        'Yearly'
    ) NOT NULL,
    subscription_amount DECIMAL(10,2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status ENUM(
        'Active',
        'Expired',
        'Cancelled'
    ) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_subscription_company
        FOREIGN KEY (company_id)
        REFERENCES company(company_id)
);


-- =====================================================
-- Table: subscription
-- Purpose: Stores customer subscription details.
-- =====================================================

CREATE TABLE subscription (
    subscription_id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT NOT NULL,
    plan_name VARCHAR(100) NOT NULL,
    billing_cycle ENUM(
        'Monthly',
        'Quarterly',
        'Yearly'
    ) NOT NULL,
    subscription_amount DECIMAL(10,2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status ENUM(
        'Active',
        'Expired',
        'Cancelled'
    ) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_subscription_company
        FOREIGN KEY (company_id)
        REFERENCES company(company_id)
);


-- =====================================================
-- Table: payment
-- Purpose: Stores payment transactions for subscriptions.
-- =====================================================

CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    subscription_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM(
        'Credit Card',
        'Debit Card',
        'UPI',
        'Bank Transfer'
    ) NOT NULL,
    payment_status ENUM(
        'Success',
        'Pending',
        'Failed',
        'Refunded'
    ) DEFAULT 'Success',
    transaction_id VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payment_subscription
        FOREIGN KEY (subscription_id)
        REFERENCES subscription(subscription_id)
);
