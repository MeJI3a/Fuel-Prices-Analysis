# Step 6: Snowflake - Data Integration and Setup

## Overview
This step involved integrating **Snowflake** with **Amazon S3** and setting up the necessary structures for data storage and analysis, including the creation of an **automated pipeline** for continuous data loading.

## Objectives
- Configured the **Snowflake warehouse** and established an **integration with S3**.
- Created schemas for structured **data storage**.
- Established a **secure connection** between **Snowflake** and **S3**.
- Set up an **automated data pipeline** for seamless data loading from S3 to Snowflake.
- Validated and cleaned the data before further processing.
- Connected **Snowflake** to **Power BI** for dynamic data analysis and visualization.

## Steps

### 1. Snowflake Warehouse Setup
A **Snowflake warehouse** was created to efficiently handle queries. It was configured to automatically suspend after **60 seconds** of inactivity to optimize costs.

### 2. Configuring Storage Integration with S3
A **storage integration** was successfully established between Snowflake and **Amazon S3**. This allowed Snowflake to securely access data stored in an S3 bucket without requiring manual file transfers.

### 3. Creating a Stage for S3 Data
A **stage** was set up in Snowflake to load files directly from the designated S3 bucket. This stage acted as a bridge between **S3 and Snowflake**, enabling seamless data retrieval.

### 4. Defining Database Schemas
Multiple **schemas** were created to logically separate different categories of data. The following schemas were established:
- **Fuel** – stored fuel price and related information.
- **Inflation** – contained inflation rate data.
- **Currency** – stored historical exchange rate data.
- **Oil** – included crude oil price data.

### 5. Creating an Automated Snowpipe Pipeline
An **automated Snowpipe pipeline** was set up for continuous and seamless data loading from **S3 to Snowflake**. The pipeline monitors the **S3 bucket** for new files and automatically loads them into the appropriate tables in Snowflake as soon as they arrive. This eliminates the need for manual file loading, ensuring real-time data availability for analysis.

### 6. Exploratory Data Analysis (EDA)
A total of **21 SQL queries** were executed to analyze fuel prices, oil prices, inflation, and currency exchange rates. The analysis included:
- **Yearly and monthly trends** – Calculating average fuel prices, inflation rates, and oil price fluctuations.
- **Price variations and outliers** – Identifying price spikes and unusual deviations.
- **Seasonal effects** – Analyzing fuel price changes across different seasons.
- **Comparisons and correlations** – Evaluating relationships between fuel prices, oil prices, and inflation.
- **Rolling averages and percentage changes** – Tracking long-term trends and short-term volatility.

### 7. Power BI Integration
After setting up Snowflake and loading data, a **connection was established between Snowflake and Power BI**. This allows for dynamic and interactive visualizations:
- Power BI was configured to connect to the Snowflake data warehouse, pulling real-time data for analysis.
- Queries were executed to load data from Snowflake directly into Power BI for reporting and visualization.
- The **direct connection** allows seamless updates to dashboards and reports as new data arrives in Snowflake via the Snowpipe pipeline.

## Next Steps
- Uploading and validating additional data from **S3 to Snowflake**.
- Monitoring the automated **Snowpipe pipeline** for continuous data loading.
- Continue developing **Power BI visualizations** and reports based on the latest data.

---
This README provides a structured overview of the **Snowflake + S3 integration**, including the creation of an automated pipeline for real-time data loading and **Power BI integration** for reporting and visualization. It serves as a reference for the next phases of the project.

---
**Author:** Z.Simanel  
**Date:** February 11, 2025
