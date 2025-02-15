# Step 8: Deep Analysis: 

## Overview
The **Deep Analysis** phase focuses on an in-depth exploration of fuel price trends, external economic influences, and statistical relationships. This step builds upon the cleaned dataset to uncover key insights.

## Key Objectives
- Identify long-term fuel price trends and anomalies.
- Analyze the correlation between fuel prices, oil prices, inflation, and currency exchange rates.
- Detect significant external events (geopolitical, economic, policy changes) impacting price shifts.
- Perform statistical tests and anomaly detection.
- Visualize trends and dependencies using advanced plotting techniques.

---

## Folder Structure
- **DeepAnalysis.ipynb** → Jupyter Notebook containing the deep analysis workflow.
- **final_cleaned_data.csv** → The fully cleaned dataset used for analysis.
- **merged_data_before_cleaning.csv** → The raw merged dataset before cleaning.

---

## Steps in Deep Analysis
### 1. Data Loading & Preparation
- Load the cleaned dataset (`final_cleaned_data.csv`).
- Ensure all data types are correctly formatted.
- Check for any remaining inconsistencies.

### 2. Exploratory Data Analysis (EDA)
- Generate descriptive statistics (mean, median, standard deviation, min/max values).
- Identify trends in fuel prices over time.
- Compare pre-pandemic and post-pandemic price fluctuations.

### 3. Correlation Analysis
- Compute correlation matrices for:
  - Fuel prices vs. oil prices
  - Fuel prices vs. inflation
  - Fuel prices vs. currency exchange rates
- Identify periods of high sensitivity to external factors.

### 4. Anomaly Detection
- Detect outliers in fuel prices, oil prices, inflation, and exchange rates.
- Identify major economic and geopolitical events correlating with price spikes.
- Highlight unexpected anomalies where fuel prices did not align with oil prices.

### 5. Statistical Tests
- Conduct hypothesis testing on significant price shifts.
- Compare pre- and post-2020 pricing structures.
- Use p-value analysis to confirm statistically significant differences.

### 6. Data Visualization
- Create interactive time-series plots using Plotly.
- Generate heatmaps to visualize correlations.
- Develop scatter plots to explore dependencies.

---

## Key Findings
### 1. Fuel Price Trends
- Fuel prices have increased significantly post-2020, with higher volatility than before.
- The most notable price surges occurred in early 2022 (Russia-Ukraine war impact) and late 2022 (supply chain disruptions and inflation).
- Unlike previous years, fuel prices did not return to pre-pandemic levels, suggesting structural changes in the market.

### 2. Oil Prices and Fuel Prices
- **Pre-2020:** No strong correlation between oil and fuel prices (correlation = 0.00).
- **Post-2020:** Fuel prices became highly sensitive to oil prices (correlation = 0.92).
- Before 2020, government policies and subsidies likely regulated fuel prices.
- After 2020, market forces and global oil prices directly influenced fuel costs, leading to increased price volatility.

### 3. Inflation and Fuel Prices
- Weak negative correlation between fuel prices and inflation (-0.25).
- Fuel prices increased despite stable inflation, indicating other economic forces at play.
- Supply chain disruptions and geopolitical risks contributed more significantly to fuel price fluctuations.

### 4. Geopolitical Events and Anomalies
- Major external events had a direct impact on fuel prices:
  - **COVID-19 (March 2020):** Lockdowns and demand shocks caused temporary price drops.
  - **Oil Price Crash (April 2020):** Short-term decline in fuel prices.
  - **Post-Pandemic Recovery (2021):** Demand surge and inflationary effects.
  - **Russia-Ukraine War (Feb 2022):** Largest fuel price spike due to supply chain disruptions.
  - **Sustained Inflation (2023-Present):** Prices remain high despite economic recovery.
- Statistical tests confirmed that the Russia-Ukraine war had one of the strongest impacts on fuel prices.

### 5. Market Anomalies
- No anomalies detected in oil prices during fuel price spikes.
- A major fuel price anomaly was detected in July 2022, despite stable oil prices.
- Currency exchange rate anomalies occurred in late 2022, possibly due to economic instability.
- Fuel prices appear to react with a **33-day delay** to oil price changes.

### 6. Comparative Analysis: Pre- vs. Post-Pandemic
- Fuel prices post-pandemic are significantly higher than before.
- Price volatility increased fourfold after 2020, with more frequent fluctuations.
- Fuel price sensitivity to external shocks has increased:
  - **Pre-2020:** Prices were stable, regulated by taxes and policies.
  - **Post-2020:** Market-driven fluctuations became the norm.
- Statistical tests confirmed significant differences in pricing structures before and after 2020 (p-value < 0.0001).

---

## Next Steps
With deep analysis complete, the next step involves **predictive modeling** to forecast future fuel prices based on identified patterns and trends.
