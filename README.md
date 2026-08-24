LOGISTICS DELIVERY PARTNER PERFORMANCE ANALYSIS


BUSINESS PROBLEM

A retail business is looking to select a delivery partner capable of providing a consistently high-quality delivery experience to its customers. The business is willing to pay 
a premium for superior service, so the analysis prioritizes customer satisfaction, delivery reliability, punctuality, and performance under adverse weather conditions.



OBJECTIVE 

The objective of this analysis is to evaluate delivery partners across three key performance indicators and determine which providers demonstrate the strongest overall service quality.

1. Customer Rating
2. Overall Delivery Performance
3. Rainy-Day Delivery Performance



DATASET

This delivery logistics dataset contains 25,000 rows and 15 columns tracking package deliveries across multiple logistics partners including 
Delhivery, FedEx, DHL, Blue Dart, Amazon Logistics, and others. The dataset captures comprehensive delivery attributes such as 
package types (electronics, groceries, documents, fragile items, etc.), vehicle types (bikes, scooters, vans, trucks, including electric variants), 
delivery modes (same-day, express, two-day, standard), geographic regions, weather conditions, distance, package weight, and cost metrics. 
It also includes performance indicators like delivery status (delivered, delayed, failed), customer ratings (1-5 scale), and timeliness comparisons between 
actual and expected delivery times.



TOOLS

MySQL / MySQL Workbench — Primary tool used for data preparation, cleaning, validation and analysis. 
SQL was used to investigate data quality, create a unique record identifier, standardize the dataset and calculate the four delivery-performance KPIs.

Kaggle — Source of the logistics dataset.



DATA CLEANING AND PREPARATION

1. Inspected the dataset structure and available fields.
2. Verified the dataset contained 25,000 records.
3. Performed a NULL-value assessment across relevant analytical fields.
4. Investigated delivery_id uniqueness and determined that it could not uniquely identify individual records.
5. Created a new record_id using an auto-incrementing primary key to uniquely identify each observation.
6. Removed delivery_time and expected_time because the fields contained identical/default values and could not support meaningful delivery-time analysis.
7. Reviewed distinct categorical values to identify potential inconsistencies that could affect analysis.
8. Validated the cleaned dataset by Rechecking the cleaned dataset after completing the cleaning process and confirming that the expected 25,000 records were retained.


KPI ANALYSIS


KPI 1: CUSTOMER RATING 

Objective: Identify which delivery partner provides the highest customer experience based on average delivery ratings.

The average customer rating was calculated for each delivery partner using all available delivery ratings in the dataset. 
The results show that FedEx recorded the highest average customer rating at 3.70/5, followed closely by Delhivery (3.69) then DHL (3.69) and Blue Dart(3.68)


KPI 2: OVERALL DELIVERY PERFOMANCE

Objective: Evaluate delivery partners based on the proportion of deliveries that were successfully completed, delayed, or failed.

For this KPI, A comparison was made between each delivery partner’s delivered, delayed, and failed percentages. Rather than focusing only on the number of deliveries, 
the analysis uses percentages to provide a fair comparison between partners handling different volumes of orders.

Key Results

Highest Delivered Rate

1. Delhivery — 75.2%
2. FedEx — 74.8%
3. DHL — 73.7%
4. Ecom Express - 73.4%


Lowest Delayed Rate

1. Delhivery — 19.8%
2. FedEx — 20.4%
3. DHL — 20.4%
4. Blue Dart - 21.2%


Lowest Failed Rate

1. Ecom Express — 4.4%
2. FedEx — 4.8%
3. Shadowfax — 4.9%
4. Delhivery - 5.0%


 KPI 3: RAINY DAY DELIVERY PERFORMANCE
 
Objective : Evaluate the top-performing delivery partners based on the proportion of rain-affected deliveries that were successfully completed, delayed, or failed.

For this KPI, delivered, delayed, and failed percentages during rain-affected deliveries were compared across partners.Percentages (rather than raw counts) were used to ensure 
a fair comparison between partners handling different delivery volumes. The analysis below focuses on the four strongest performers by delivered rate.

Key Results

Highest Delivered Rate

 1  Delhivery  65.7% 
 2  Ecom Express  64.2% 
 3  Amazon Logistics 63.9% 
 4  DHL  63.5% 

Lowest Delayed Rate

 1  Delhivery  27.7% 
 2  DHL  29.7% 
 3  Ecom Express  29.9% 
 4  Amazon Logistics 31.2% 

Lowest Failed Rate

 1  Amazon Logistics  5.0% 
 2  Ecom Express  5.9% 
 3  Delhivery  6.6% 
 4  DHL  6.8% 


KEY FINDINGS

FedEx recorded the highest customer rating at 3.70/5.
Delhivery recorded the highest delivered rate at 75.2%.
Delhivery also had the lowest delayed rate at 19.8%.
Ecom Express recorded the lowest failed rate at 4.4%.
Delhivery recorded the highest rainy day delivered rate at 65.7%.
Delhivery recorded the lowest rainy day delayed rate at 27.7%.
Amazon Logistics recorded the lowest rainy day failed rate at  5.0% 



BUSINESS RECOMMENDATION

Based on the 3 KPIs analyzed, Delhivery emerges as the strongest overall delivery partner for the store. It achieved the highest customer delivery completion rate (75.2%), 
the lowest overall delay rate (19.8%), and the highest rainy-day delivered rate (65.7%), Even while also ranking 4th-lowest in failed deliveries (5.0%), 
and FedEx recording the highest customer rating (3.70/5), Delhivery came in a close second at (3.69), While Amazon Logistics had the lowest rainy-day failure rate (5.0%), 
It does not reduces delhivery dominance in both the highest rainy day delivery rate at 65.7%, and the lowest rainy day delayed rate at 27.7%. 
Delhivery demonstrates the most consistent overall combination of customer experience, delivery reliability, and resilience in adverse weather.


ANALYTICAL LIMITATIONS

The dataset contained several limitations that affected the analysis. delivery_id was not completely unique, so a separate record_id was created for row-level identification. 
The delivery_time and expected_time fields contained identical values and were therefore excluded from delivery-time analysis. Additionally Delivery cost analysis was also excluded 
as a primary KPI because the available dataset does not give sufficient controlled information for a balanced comparison. 
Finally, delivery partners handled different volumes of orders, so percentages were prioritized over raw counts.
