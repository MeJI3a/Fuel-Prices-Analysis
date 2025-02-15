# Fuel Prices Analysis (UK) – Data Pipeline, Dashboard, ML, Deployment & Analytics

## Project Overview
This project analyzes UK fuel prices from **2019 to 2024**, focusing on external factors such as inflation, oil prices, and currency exchange rates. It includes **data collection, cleaning, statistical analysis, visualization, and machine learning** to predict future trends.

---

## **Completed Steps**

### **1-4. Data Collection & Cleaning**
- **Datasets collected & processed**:
  - **Fuel Prices** (ULSP, ULSD) – `df_fuel`
  - **Oil Prices** – `df_oil`
  - **Currency Exchange Rates** – `df_currency`
  - **Inflation Rates** – `df_inflation`
- **Merged datasets** by `Year-Month` into `df_merged`
- **Outlier detection** using **Z-score** and **IQR**
- **Rolling mean trends** applied for smoothing

### **5. Preliminary Analysis**
- Conducted **Exploratory Data Analysis (EDA)**  
- Examined **correlations** between fuel prices, oil prices, inflation, and currency exchange rates  
- Visualized initial findings using **histograms, scatter plots, and boxplots**  
- Identified **trends, seasonality, and anomalies** in the dataset  

### **6-7. AWS S3 + Snowflake Pipeline**
- **AWS S3 bucket** created for data storage (`bucket-fuel-analysis-2019-2024-zs`)
- **IAM Roles & Policies** configured for secure access
- **Snowflake Integration** set up:
  - Created schemas: `fuel`, `inflation`, `currency`, `oil`
  - Configured **Snowpipe** for automated data ingestion

### **8. Deep Analysis (Completed)**
- **Step 8.1 - Data Validation & Cleaning**  
  - Ensured data consistency, handled missing values  
- **Step 8.2 - Snowflake Connection & Queries**  
  - Extracted and structured data from Snowflake  
- **Step 8.3 - Merging Key Variables**  
  - Aligned datasets (Fuel, Oil, Currency, Inflation) into a unified structure  
- **Step 8.4 - Normalization (2019 = 100%)**  
  - Scaled all values relative to 2019 to detect trends  
- **Step 8.5 - Statistical Summary & Outlier Detection**  
  - Identified anomalies in fuel prices, oil prices, and exchange rates  
- **Step 8.6 - Economic Event Correlation Analysis**  
  - Measured impact of major geopolitical events (sanctions, inflation, war)  

### **Findings from Deep Analysis**
- **Fuel prices became highly sensitive to oil prices post-2020**
- **Inflation had a weaker direct impact than supply chain disruptions**
- **The Russia-Ukraine War was the largest fuel price shock**
- **Fuel price fluctuations increased 4x after 2020**
- **Lag analysis confirmed a 33-day delay in fuel prices reacting to oil changes**

### 9. Power BI Dashboard

#### **Development & Features**
- Created an **interactive Power BI dashboard** for fuel price analysis.
- **Analyzed correlations** between **fuel prices, inflation, and oil**.
- **Five-year price trends** visualized with dynamic filtering options.
- **Implemented date selection filters** for enhanced user interactivity.

#### **Integration Pipeline: AWS S3 → Snowflake → Power BI**
- **Data stored in AWS S3** and loaded into **Snowflake**.
- **Snowpipe automates real-time data ingestion** into Snowflake.
- **Power BI connects to Snowflake** via **ODBC & DirectQuery**, ensuring **live updates**.
- **Published dashboard to Power BI Service** for accessibility.
- **Published to Power BI Service**  
  - [Power BI Report Link](https://app.powerbi.com/groups/me/reports/d9e87e16-b1a0-4204-9f23-495a027f9fb8/76a4473d01533534e860?experience=power-bi)

## Next Steps

### **10. Machine Learning**
- Build predictive models for fuel price forecasting
- Train regression models using **historical data**
- Evaluate performance with **RMSE, MAPE**

### **11. Plotly Dash**
- Develop an **interactive web app** for fuel price insights

### **12. Testing**
- Validate **entire pipeline**:
  - **Unit Tests** for data cleaning & processing
  - **Model performance tests** for ML

### **13. Deployment**
- Deploy **Plotly Dash app** using **Heroku** or **AWS EC2**
- Publish final results in **Power BI** & **Plotly Dash**
- Document findings in **report & LinkedIn post**

---

## Repository Structure
├── 1.Fuel ├── 2.Inflation ├── 3.Currency ├── 4.Oil ├── 5.S3 ├── 6.Snowflake_Pipeline ├── 7.Power_BI ├── 8.Deep_Analysis ├── 9.Machine_Learning ├── 10.Plotly ├── 11.Testing ├── 12.Deployment ├── images


---

## Author
 **Z. Simanel**  
 **February 2025**  
