
-- 1. Yearly Average Inflation
SELECT EXTRACT(YEAR FROM Date) AS Year, AVG(Inflation_Rate) AS Average_Inflation
FROM inflation.inflation
GROUP BY Year
ORDER BY Year;

-- 2. Max and Min Price for Each Month (Fuel Data)

SELECT EXTRACT(MONTH FROM Date) AS Month, MAX(Price) AS Max_Price, MIN(Price) AS Min_Price
FROM fuel.fuel
GROUP BY Month
ORDER BY Month;


-- 3. Percentage Change in Oil Prices
SELECT DATE, 
       PRICE, 
       LAG(PRICE) OVER (ORDER BY DATE) AS Previous_Price, 
       ((PRICE - LAG(PRICE) OVER (ORDER BY DATE)) / LAG(PRICE) OVER (ORDER BY DATE)) * 100 AS Percentage_Change
FROM oil.oil
LIMIT 10;

-- 4. Total Fuel Price Per Month
SELECT EXTRACT(MONTH FROM Date) AS Month, SUM(Price) AS Total_Fuel_Price
FROM fuel.fuel
GROUP BY Month
ORDER BY Month;


-- 5. Standard Deviation of Inflation
SELECT 
    EXTRACT(YEAR FROM DATE) AS Year, 
    AVG(Inflation_Rate) AS Average_Inflation, 
    STDDEV(Inflation_Rate) AS Inflation_Volatility
FROM inflation.inflation
GROUP BY Year
ORDER BY Year;

-- 6. Coefficient of Variation
SELECT 
    EXTRACT(YEAR FROM DATE) AS Year, 
    AVG(Inflation_Rate) AS Average_Inflation, 
    STDDEV(Inflation_Rate) AS Inflation_Volatility,
    (STDDEV(Inflation_Rate) / NULLIF(AVG(Inflation_Rate), 0)) * 100 AS Coefficient_of_Variation
FROM inflation.inflation
GROUP BY Year
ORDER BY Year;

-- 7. Yearly Inflation Growth
SELECT 
    EXTRACT(YEAR FROM DATE) AS Year, 
    AVG(Inflation_Rate) AS Average_Inflation, 
    LAG(AVG(Inflation_Rate)) OVER (ORDER BY EXTRACT(YEAR FROM DATE)) AS Previous_Year_Inflation,
    (AVG(Inflation_Rate) - LAG(AVG(Inflation_Rate)) OVER (ORDER BY EXTRACT(YEAR FROM DATE))) / 
    LAG(AVG(Inflation_Rate)) OVER (ORDER BY EXTRACT(YEAR FROM DATE)) * 100 AS Inflation_Growth_Percentage
FROM inflation.inflation
GROUP BY Year
ORDER BY Year;

--8. Seasonal Trends in Fuel Prices
SELECT 
    CASE 
        WHEN EXTRACT(MONTH FROM Date) IN (12, 1, 2) THEN 'Winter'
        WHEN EXTRACT(MONTH FROM Date) IN (3, 4, 5) THEN 'Spring'
        WHEN EXTRACT(MONTH FROM Date) IN (6, 7, 8) THEN 'Summer'
        WHEN EXTRACT(MONTH FROM Date) IN (9, 10, 11) THEN 'Fall'
    END AS Season,
    AVG(Price) AS Average_Price
FROM fuel.fuel
GROUP BY Season
ORDER BY Season;


-- 9. Average Duty Rate for Oil and ULSP
SELECT 
    f.DATE, 
    AVG(f.Price) AS Average_Fuel_Price,
    AVG(o.PRICE) AS Average_Oil_Price
FROM fuel.fuel f
JOIN oil.oil o ON f.DATE = o.DATE
GROUP BY f.DATE
ORDER BY f.DATE;


-- 10. Price Difference Between ULSP and ULSD

SELECT DATE, 
       ULSP_Price, 
       ULSD_Price,
       (ULSP_Price - ULSD_Price) AS Price_Difference
FROM fuel.fuel;

DESC TABLE fuel.fuel;


-- 11. Price Outliers in Fuel Data
WITH PriceStats AS (
    SELECT AVG(ULSP_Price) AS Mean_Price, 
           STDDEV(ULSP_Price) AS StdDev_Price
    FROM fuel.fuel
)
SELECT Date, ULSP_Price
FROM fuel.fuel, PriceStats
WHERE ULSP_Price > Mean_Price + 2 * StdDev_Price
   OR ULSP_Price < Mean_Price - 2 * StdDev_Price;


-- 12. Comparison of Fuel and Oil Prices with Price Difference
SELECT f.Date, 
       f.ULSP_Price AS Fuel_Price, 
       o.Price AS Oil_Price,
       o.Price - f.ULSP_Price AS Price_Difference
FROM fuel.fuel f
JOIN oil.oil o ON f.Date = o.Date
ORDER BY f.Date;


-- 13. Join Data from Multiple Schemas (Fuel and Inflation)
SELECT f.Date, 
       f.ULSP_Price AS Fuel_Price, 
       i.INFLATION_RATE AS Inflation
FROM fuel.fuel f
JOIN inflation.inflation i 
    ON EXTRACT(MONTH FROM f.Date) = EXTRACT(MONTH FROM i.Date)
WHERE f.Date BETWEEN '2020-01-01' AND '2020-12-31'
ORDER BY f.Date;

-- 14. Average Fuel Price by Month Across Schemas (Fuel and Oil)
SELECT 
    EXTRACT(MONTH FROM f.Date) AS Month,
    AVG(f.ULSP_Price) AS Avg_Fuel_Price,
    AVG(o.Price) AS Avg_Oil_Price
FROM fuel.fuel f
JOIN oil.oil o ON EXTRACT(MONTH FROM f.Date) = EXTRACT(MONTH FROM o.Date)
GROUP BY Month
ORDER BY Month;

-- 15. Correlation Between Fuel Prices and Inflation
SELECT 
    CORR(f.ULSP_Price, i.INFLATION_RATE) AS Fuel_Inflation_Correlation
FROM fuel.fuel f
JOIN inflation.inflation i 
    ON EXTRACT(MONTH FROM f.Date) = EXTRACT(MONTH FROM i.Date)
WHERE f.Date BETWEEN '2019-01-01' AND '2020-12-31';


-- 16. Month with Highest Difference Between ULSP and Fuel Prices
SELECT 
    EXTRACT(MONTH FROM f.Date) AS Month,
    MAX(ABS(f.ULSP_Price - o.Price)) AS Max_Price_Difference
FROM fuel.fuel f
JOIN oil.oil o 
    ON EXTRACT(MONTH FROM f.Date) = EXTRACT(MONTH FROM o.Date)
GROUP BY Month
ORDER BY Max_Price_Difference DESC
LIMIT 1;

-- 17. Monthly Fuel Price for the Highest Inflation Month
WITH Max_Inflation AS (
    SELECT EXTRACT(MONTH FROM Date) AS Month, 
           MAX(INFLATION_RATE) AS Max_Inflation
    FROM inflation.inflation
    GROUP BY Month
    ORDER BY Max_Inflation DESC
    LIMIT 1
)
SELECT f.Date, f.ULSP_Price AS Fuel_Price
FROM fuel.fuel f
JOIN Max_Inflation mi ON EXTRACT(MONTH FROM f.Date) = mi.Month;

-- 18. Difference Between Duty Rates (Fuel vs Oil)
SELECT 
    f.Date, 
    f.ULSP_Duty AS ULSP_Duty_Fuel,
    f.ULSD_Duty AS ULSD_Duty_Fuel,
    o.Price AS Oil_Price
FROM fuel.fuel f
JOIN oil.oil o ON f.Date = o.Date
ORDER BY f.Date;


-- 19. Year-over-Year Fuel Price Change
SELECT 
    EXTRACT(YEAR FROM f.Date) AS Year,
    AVG(f.ULSP_Price) AS Average_Price,
    (AVG(f.ULSP_Price) - LAG(AVG(f.ULSP_Price)) OVER (ORDER BY EXTRACT(YEAR FROM f.Date))) / 
    LAG(AVG(f.ULSP_Price)) OVER (ORDER BY EXTRACT(YEAR FROM f.Date)) * 100 AS Year_Over_Year_Change
FROM fuel.fuel f
GROUP BY Year
ORDER BY Year;

-- 20. Average Fuel Price with Higher Inflation
SELECT AVG(f.ULSP_Price) AS Avg_Fuel_Price
FROM fuel.fuel f
JOIN inflation.inflation i ON EXTRACT(MONTH FROM f.Date) = EXTRACT(MONTH FROM i.Date)
WHERE i.INFLATION_RATE > 2
GROUP BY EXTRACT(MONTH FROM f.Date);


-- 21. Rolling Average of Fuel Prices
SELECT 
    f.Date,
    f.ULSP_Price,
    AVG(f.ULSP_Price) OVER (ORDER BY f.Date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS Rolling_Avg_7_Days
FROM fuel.fuel f
ORDER BY f.Date;