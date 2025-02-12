CREATE OR REPLACE WAREHOUSE fuel_warehouse
WITH WAREHOUSE_SIZE = 'XSMALL'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE;

CREATE OR REPLACE STORAGE INTEGRATION fuel_s3_integration
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = 'S3'
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::503561416775:role/SnowflakeS3Role'
STORAGE_ALLOWED_LOCATIONS = ('s3://bucket-fuel-analysis-2019-2024-zs/');

CREATE OR REPLACE STAGE fuel_stage
URL = 's3://bucket-fuel-analysis-2019-2024-zs/'
STORAGE_INTEGRATION = fuel_s3_integration
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"');

LIST @fuel_stage;
SHOW STAGES;
SHOW STAGES LIKE 'fuel_stage';

LIST @fuel_stage



CREATE OR REPLACE SCHEMA fuel;
CREATE OR REPLACE SCHEMA inflation;
CREATE OR REPLACE SCHEMA currency;
CREATE OR REPLACE SCHEMA oil;

-- For the fuel schema (matches fuel_prices_cleaned.csv → 5 columns)
CREATE OR REPLACE TABLE fuel.fuel (
    Date DATE,  -- Date
    ULSP_Price FLOAT,  -- ULSP Price
    ULSD_Price FLOAT,  -- ULSD Price
    ULSP_Duty FLOAT,  -- ULSP Duty
    ULSD_Duty FLOAT  -- ULSD Duty
);

-- For the oil schema (matches filtered_oil_price.csv → 2 columns)
CREATE OR REPLACE TABLE oil.oil (
    Date DATE,  -- Date
    Price FLOAT  -- Oil Price
);

-- For the currency schema (matches cleaned_currency.csv → 6 columns)
CREATE OR REPLACE TABLE currency.currency (
    Date DATE,  -- Date
    Price FLOAT,  -- Currency Price
    Open FLOAT,  -- Currency Opening Price
    High FLOAT,  -- Currency High Price
    Low FLOAT,  -- Currency Low Price
    Change_Percentage FLOAT  -- Currency Change Percentage
);

-- For the inflation schema (matches inflation_cleaned.csv → 2 columns)
CREATE OR REPLACE TABLE inflation.inflation (
    Date DATE,  -- Date
    Inflation_Rate FLOAT  -- Inflation Rate
);

-- Load inflation data
COPY INTO inflation.inflation
FROM @fuel_stage/inflation_cleaned.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- Load fuel data
COPY INTO fuel.fuel
FROM @fuel_stage/fuel_prices_cleaned.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- Load oil data
COPY INTO oil.oil
FROM @fuel_stage/filtered_oil_prices.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- Load currency data
COPY INTO currency.currency
FROM @fuel_stage/cleaned_currency.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

SELECT * FROM inflation.inflation LIMIT 5;
SELECT * FROM fuel.fuel LIMIT 5;
SELECT * FROM oil.oil LIMIT 5;
SELECT * FROM currency.currency LIMIT 5;

-- Create a stage for accessing S3 data
CREATE OR REPLACE STAGE fuel_stage
URL = 's3://bucket-fuel-analysis-2019-2024-zs/'
STORAGE_INTEGRATION = fuel_s3_integration
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"');

-- Create a CSV file format for loading data
CREATE OR REPLACE FILE FORMAT csv_format
TYPE = 'CSV'
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
SKIP_HEADER = 1;  -- Skipping the header row if present

-- Load inflation data into the inflation table
COPY INTO inflation.inflation
FROM @fuel_stage/inflation_cleaned.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- Load fuel data into the fuel table
COPY INTO fuel.fuel
FROM @fuel_stage/fuel_prices_cleaned.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- Load oil data into the oil table
COPY INTO oil.oil
FROM @fuel_stage/filtered_oil_prices.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- Load currency data into the currency table
COPY INTO currency.currency
FROM @fuel_stage/cleaned_currency.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- Show existing pipes
SHOW PIPES;  

-- Show existing stages
SHOW STAGES;

-- List files in the fuel_stage S3 bucket
LIST @fuel_stage;  

-- Show existing integrations
SHOW INTEGRATIONS;  

-- Create Snowpipe for automatic data loading
CREATE OR REPLACE PIPE fuel_pipe
AUTO_INGEST = TRUE
AS 
COPY INTO fuel.fuel
FROM @fuel_stage/fuel_prices_cleaned.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"')
ON_ERROR = 'CONTINUE';

-- Check if Snowpipe has been created
SHOW PIPES;