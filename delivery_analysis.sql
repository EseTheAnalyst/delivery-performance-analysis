
-- Create DB, 
USE logistics

-- Table and columns

CREATE TABLE logistics_details (
    delivery_id INT,
    delivery_partner VARCHAR(50),
    package_type VARCHAR(50),
    vehicle_type VARCHAR(50),
    delivery_mode VARCHAR(50),
    region VARCHAR(50),
    weather_condition VARCHAR(50),
    distance_km INT,
    package_weight INT,
    delivery_time DATETIME,
    expected_time DATETIME,
    delay VARCHAR(50),
    delivery_status VARCHAR(50),
    delivery_rating INT,
    delivery_cost INT
);

-- Input Values BY Using MySQL Workbench Import Wizard On raw data gotten from kaggle.

-- Duplicated data before commencing cleaning and exploration
CREATE TABLE logistics_details_cleaned AS
SELECT *
FROM logistics_details;

-- *******************
-- DATA CLEANING
-- *******************

-- 1. Inspect the dataset
SELECT *
FROM logistics_details_cleaned;

-- 2. Check number of records
SELECT COUNT(*) AS total_records
FROM logistics_details_cleaned;

-- 3. Check for NULL values
SELECT
    COUNT(*) AS total_records,
     SUM(record_id IS NULL) AS missing_record_id,
    SUM(delivery_id IS NULL) AS missing_delivery_id,
    SUM(delivery_partner IS NULL) AS missing_partner,
     SUM(package_type IS NULL) AS missing_package_type,
    SUM(vehicle_type IS NULL) AS missing_vehicle_type,
    SUM(delivery_mode IS NULL) AS missing_delivery_mode,
    SUM(region IS NULL) AS missing_region,
     SUM(weather_condition IS NULL) AS missing_weather,
     SUM(distance_km IS NULL) AS missing_distance_km,
    SUM(package_weight IS NULL) AS missing_package_weight,
    SUM(delay IS NULL) AS missing_delay,
    SUM(delivery_status IS NULL) AS missing_status,
    SUM(delivery_rating IS NULL) AS missing_rating,
    SUM(delivery_cost IS NULL) AS missing_delivery_cost
FROM logistics_details_cleaned;

-- 4. Check duplicate delivery IDs knowing the total number should be 25,000

    SELECT COUNT(DISTINCT delivery_id) AS Unique_delivery_id
    FROM logistics_details_cleaned;
    

-- 5. Create unique record identifier
ALTER TABLE logistics_details_cleaned
ADD COLUMN record_id INT;

ALTER TABLE logistics_details_cleaned
MODIFY COLUMN record_id INT FIRST;

ALTER TABLE logistics_details_cleaned
MODIFY COLUMN record_id INT AUTO_INCREMENT PRIMARY KEY FIRST;

-- 6. Remove unusable columns
ALTER TABLE logistics_details_cleaned
DROP COLUMN delivery_time,
DROP COLUMN expected_time;

-- 7. Check For inconsistent values
SELECT DISTINCT delivery_partner AS Unique_delivery_partner
    FROM logistics_details_cleaned;

 SELECT DISTINCT package_type AS Unique_package_type
    FROM logistics_details_cleaned;

 SELECT DISTINCT vehicle_type AS Unique_vehicle_type
    FROM logistics_details_cleaned;
    
SELECT DISTINCT delivery_mode AS Unique_delivery_mode
    FROM logistics_details_cleaned;
    
SELECT DISTINCT region AS Unique_region
    FROM logistics_details_cleaned;
    
  SELECT DISTINCT weather_condition AS Unique_weather_condition
    FROM logistics_details_cleaned;  
    
 SELECT DISTINCT delay AS Unique_delay
    FROM logistics_details_cleaned;   
    
SELECT DISTINCT delivery_status AS Unique_delivery_status
    FROM logistics_details_cleaned;
    
    
-- 8. Validate cleaned dataset
SELECT *
FROM logistics_details_cleaned;

SELECT COUNT(*)
FROM logistics_details_cleaned;

-- *******************
-- DATA QUALITY CHECK
-- *******************
SELECT *
FROM logistics_details_cleaned;

-- ROW COUNT
SELECT COUNT(*) AS total_records
FROM logistics_details_cleaned;

-- UNIQUE RECORDS ID
SELECT COUNT(DISTINCT record_id) AS Unique_record_id
FROM logistics_details_cleaned;

-- *******************
-- KPI 1: CUSTOMER EXPERIENCE
-- Business Question : 
-- Delivery partners customer rating (where highest customer rating is 5)
-- *******************

SELECT DISTINCT delivery_partner , ROUND(AVG(delivery_rating),2) AS avg_rating
FROM logistics_details_cleaned
GROUP BY delivery_partner 
ORDER BY avg_rating DESC;

-- *******************
-- KPI 2: DELIVERY RELIABILITY
-- Business Question : 
-- Evaluate delivery partners based on the proportion of deliveries that were successfully completed, delayed, or failed.
-- *******************

SELECT
    delivery_partner,
     total_deliveries,
    delivered_count,  ROUND((delivered_count / total_deliveries) * 100, 1) AS delivered_percent,
    delayed_count, ROUND((delayed_count / total_deliveries) * 100, 1) AS delayed_percent,
    failed_count, ROUND((failed_count / total_deliveries) * 100, 1) AS failed_percent
FROM (SELECT
    delivery_partner,
    COUNT(*) AS total_deliveries,
    SUM(CASE 
        WHEN delivery_status = 'delivered' THEN 1 
        ELSE 0
    END) AS delivered_count,
    SUM(CASE 
        WHEN delivery_status = 'delayed' THEN 1 
        ELSE 0
    END) AS delayed_count,
    SUM(CASE 
        WHEN delivery_status = 'failed' THEN 1 
        ELSE 0
    END) AS failed_count
    FROM logistics_details_cleaned
    GROUP BY delivery_partner) AS delivery_summary
    ORDER BY delivered_percent DESC;


-- *******************
-- KPI 3: WEATHER RESILIENCE
-- Business Question : 
-- Delivery partner performance during rainy weather
-- *******************

SELECT
    delivery_partner,
     total_rain_deliveries,
    delivered_rain_count,  ROUND((delivered_rain_count / total_rain_deliveries) * 100, 1) AS delivered_rain_percent,
    delayed_rain_count, ROUND((delayed_rain_count / total_rain_deliveries) * 100, 1) AS delayed_rain_percent,
    failed_rain_count, ROUND((failed_rain_count / total_rain_deliveries) * 100, 1) AS failed_rain_percent
FROM (SELECT
    delivery_partner,
    SUM(CASE 
        WHEN weather_condition = 'rainy' THEN 1 
        ELSE 0
    END) AS total_rain_deliveries,
    SUM(CASE 
        WHEN delivery_status = 'delivered' AND weather_condition = 'rainy' THEN 1 
        ELSE 0
    END) AS delivered_rain_count,
    SUM(CASE 
        WHEN delivery_status = 'delayed' AND weather_condition = 'rainy' THEN 1 
        ELSE 0
    END) AS delayed_rain_count,
    SUM(CASE 
        WHEN delivery_status = 'failed' AND weather_condition = 'rainy' THEN 1 
        ELSE 0
    END) AS failed_rain_count
    FROM logistics_details_cleaned
    GROUP BY delivery_partner) AS delivery_rain_summary
    ORDER BY delivered_rain_count DESC;

-- *********************************************************
-- FINAL DELIVERY PARTNER PERFORMANCE COMPARISON

-- Compare delivery partners based on:
-- 1. Average customer rating
-- 2. Overall delivery outcome percentages
-- 3. Rainy-weather delivery performance
-- Cost is excluded because the business prioritizes service
-- quality and reliability over minimizing delivery cost.
-- *********************************************************

SELECT delivery_partner,
		avg_rating,
	ROUND((delivered_count / total_deliveries) * 100, 1) AS delivered_percent,
	ROUND((delayed_count / total_deliveries) * 100, 1) AS delayed_percent,
	ROUND((failed_count / total_deliveries) * 100, 1) AS failed_percent,
    ROUND((delivered_rain_count / total_rain_deliveries) * 100, 1) AS delivered_rain_percent,
	ROUND((delayed_rain_count / total_rain_deliveries) * 100, 1) AS delayed_rain_percent,
	ROUND((failed_rain_count / total_rain_deliveries) * 100, 1) AS failed_rain_percent
    FROM
     (SELECT
    delivery_partner,
    AVG(delivery_rating) AS avg_rating,
    COUNT(*) AS total_deliveries,
    SUM(CASE 
        WHEN delivery_status = 'delivered' THEN 1 
        ELSE 0
    END) AS delivered_count,
    SUM(CASE 
        WHEN delivery_status = 'delayed' THEN 1 
        ELSE 0
    END) AS delayed_count,
    SUM(CASE 
        WHEN delivery_status = 'failed' THEN 1 
        ELSE 0
    END) AS failed_count,
    SUM(CASE 
        WHEN weather_condition = 'rainy' THEN 1 
        ELSE 0
    END) AS total_rain_deliveries,
    SUM(CASE 
        WHEN delivery_status = 'delivered' AND weather_condition = 'rainy' THEN 1 
        ELSE 0
    END) AS delivered_rain_count,
    SUM(CASE 
        WHEN delivery_status = 'delayed' AND weather_condition = 'rainy' THEN 1 
        ELSE 0
    END) AS delayed_rain_count,
    SUM(CASE 
        WHEN delivery_status = 'failed' AND weather_condition = 'rainy' THEN 1 
        ELSE 0
    END) AS failed_rain_count
    FROM logistics_details_cleaned
    GROUP BY delivery_partner) AS delivery_rain_summary;



