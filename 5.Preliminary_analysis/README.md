### 5 **Preliminary Analysis Report – Fuel Prices Analysis (United Kingdom Data)**

#### **Objective**
Create a combined dataset including fuel, oil, exchange rates and inflation data (2019-2024). Identify initial patterns, identify possible anomalies and prepare the basis for Deep Analysis.



#### **Stages of Work**

##### **1. Data Collection and Combination**
- Datasets:
- `df_fuel`: Average monthly fuel prices (ULSP, ULSD).
- `df_oil`: Average oil price per month.
- `df_currency`: Average GBP/USD exchange rate.
- `df_inflation`: Average inflation by month.
- Data loaded and merged by `Year-Month` (in `df_merged`).
- Duplicates and null values ​​checked.

##### **2. Descriptive statistics and correlation analysis**
- Means, medians, standard deviations, minimums and maximums were calculated.
- Correlation analysis showed:
- **Strong correlation** between fuel prices and inflation (**0.87-0.92**).
- **Notable dependence** between oil and fuel prices (**0.68-0.71**).
- **Inverse dependence** between the exchange rate and fuel prices (**-0.45 to -0.55**).
- Boxplots were constructed to detect outliers.

##### **3. Identifying outliers**
- Outliers were detected using **Z-score** and **IQR**.
- Largest anomalies in **April - August 2022**.
- **Highest inflation rate (9.6%) – October 2022**
- **Sharp jumps in fuel and oil prices coincide with global economic shocks.**

##### **4. Rolling Mean Analysis**
- 3-month and 6-month averages smooth out sharp fluctuations.
- **Peak prices** were recorded in 2022.
- By 2024, prices began to decline, but remain above 2019-2020 levels.

##### **5. Visualization**
- **Line chart:** Fuel and oil price dynamics.
- **Bar chart:** Average fuel price by year (2022 is the most expensive year).
- **Scatter plot:** Oil and fuel price correlation.

##### **6. Oil Price Outlier Analysis (Oil Price > 0.16)**
- **Anomaly Period: April - August 2022.**
- During this period, the following was observed:
- **Inflation peak (7.8% - 8.8%)**.
- **Fuel price spike (ULSP and ULSD)**.
- **Oil price highs (> 0.16 - 0.22)**.
- **Cases were found where the oil price exceeded the fuel price**, which is an atypical situation.

##### **7. Timeline Event Check**
- Anomalous dates were checked with real economic events.
- Confirmed coincidence with global economic crises (sanctions, energy crisis, supply imbalance).


#### **Preliminary Analysis Conclusions**
- 2022 is the **most unstable year** with sharp jumps in oil and fuel prices and inflation.
- There are **anomalies that violate the standard correlation** between oil and fuel.
- **The long-term impact of economic crises** can be seen even in 2023-2024.
- For accurate conclusions, **it is necessary to bring all data to a single base (2019 = 100%)**.



#### **Next Steps in Deep Analysis**
- **Bringing all variables to a single scale (2019 = 100%)** for a fair comparison.
- **Deep analysis of the dependence of fuel, oil and inflation prices after normalization.**
- **Comparison of the obtained data with key historical events (sanctions, crises, supply chain).**

This Preliminary Analysis **is the basis** for further deep analysis of data with Python, AWS S3 and Snowflake.