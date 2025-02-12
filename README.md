# Fuel Prices Analysis (UK) – Data Pipeline & Dashboard & ML & Deployment & Analytics

## Project Overview
This project analyzes UK fuel prices, inflation, oil prices, and currency exchange rates over the period **2019-2024**. It includes data extraction, processing, visualization, and machine learning-based forecasting.

## Completed Steps

### **1-4. Data Collection & Cleaning**
- Collected and cleaned datasets:
  - **Fuel Prices** (ULSP, ULSD) – `df_fuel`
  - **Oil Prices** – `df_oil`
  - **Currency Exchange Rates** – `df_currency`
  - **Inflation Rates** – `df_inflation`
- Merged data by `Year-Month` into `df_merged`
- Identified outliers and anomalies using **Z-score** and **IQR**
- Analyzed **rolling mean** trends for smoothing

### **5-6. AWS S3 + Snowflake Pipeline**
- Set up **AWS S3** bucket for data storage (`bucket-fuel-analysis-2019-2024-zs`)
- Configured **IAM Roles & Policies** for secure access
- Established **Snowflake Integration** with S3:
  - Created schemas: `fuel`, `inflation`, `currency`, `oil`
  - Configured **Snowpipe** for automated data ingestion

### **7. Power BI Dashboard**
- Developed **Preliminary Dashboard** in **Power BI**:
  - Analyzed fuel price correlations
  - Visualized trends over 5 years
  - Added **interactive filters** (date range)
- Published to Power BI Service (**[https://app.powerbi.com/groups/me/reports/d9e87e16-b1a0-4204-9f23-495a027f9fb8/76a4473d01533534e860?experience=power-bi]**)

---

## Next Steps

### **8. Deep Analysis**
- Normalize all values to **2019 = 100%**
- Analyze fuel price dependencies after scaling
- Compare trends with key **economic events** (sanctions, crises)

### **9. Machine Learning**
- Build predictive models for fuel price forecasting
- Train regression models using **historical data**
- Evaluate performance with **RMSE, MAPE**

### **10. Plotly Dash**
- Develop an **interactive web app** for fuel price insights

### **11. Testing**
- Validate **entire pipeline**:
  - **Unit Tests** for data cleaning & processing
  - **Model performance tests** for ML

### **12. Deployment**
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
