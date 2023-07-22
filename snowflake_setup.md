-- Use an admin role
USE ROLE ACCOUNTADMIN;

-- Create the `transform` role
CREATE ROLE IF NOT EXISTS transform;
GRANT ROLE TRANSFORM TO ROLE ACCOUNTADMIN;

-- Create the default warehouse if necessary
CREATE WAREHOUSE IF NOT EXISTS COMPUTE_WH;
GRANT OPERATE ON WAREHOUSE COMPUTE_WH TO ROLE TRANSFORM;

-- Create the `dbt` user and assign to role
CREATE USER IF NOT EXISTS dbt
  PASSWORD='dbtPassword123'
  LOGIN_NAME='dbt'
  MUST_CHANGE_PASSWORD=FALSE
  DEFAULT_WAREHOUSE='COMPUTE_WH'
  DEFAULT_ROLE='transform'
  DEFAULT_NAMESPACE='PERRYHEALTH.RAW'
  COMMENT='DBT user used for data transformation';
GRANT ROLE transform to USER dbt;

-- Create our database and schemas
CREATE DATABASE IF NOT EXISTS PERRYHEALTH;
CREATE SCHEMA IF NOT EXISTS PERRYHEALTH.RAW;

-- Set up permissions to role `transform`
GRANT ALL ON WAREHOUSE COMPUTE_WH TO ROLE transform; 
GRANT ALL ON DATABASE PERRYHEALTH to ROLE transform;
GRANT ALL ON ALL SCHEMAS IN DATABASE PERRYHEALTH to ROLE transform;
GRANT ALL ON FUTURE SCHEMAS IN DATABASE PERRYHEALTH to ROLE transform;
GRANT ALL ON ALL TABLES IN SCHEMA PERRYHEALTH.RAW to ROLE transform;
GRANT ALL ON FUTURE TABLES IN SCHEMA PERRYHEALTH.RAW to ROLE transform;


-- Set up the defaults
USE WAREHOUSE COMPUTE_WH;
USE DATABASE perryhealth;
USE SCHEMA RAW;

-- Create our four tables
CREATE OR REPLACE TABLE raw_customers
                    (id integer,
                     sign_up_date datetime,
                     state string);
                    

CREATE OR REPLACE TABLE raw_products
                    (product_id integer,
                     product_category string,
                     unit_price_cents integer);
                    

CREATE OR REPLACE TABLE raw_transactions
                    (transaction_id integer,
                     product_id integer,
                     quantity integer);
                    
CREATE OR REPLACE TABLE raw_transaction_details
                    (transaction_id integer,
                     customer_id integer,
                     transaction_date datetime,
                     payment_method string);
