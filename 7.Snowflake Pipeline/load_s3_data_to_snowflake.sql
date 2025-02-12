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

CREATE OR REPLACE SCHEMA fuel;
CREATE OR REPLACE SCHEMA inflation;
CREATE OR REPLACE SCHEMA currency;
CREATE OR REPLACE SCHEMA oil;

LIST @fuel_stage;
SHOW STAGES;

SHOW STAGES LIKE 'fuel_stage';
CREATE OR REPLACE STAGE fuel_stage
URL = 's3://bucket-fuel-analysis-2019-2024-zs/'
STORAGE_INTEGRATION = fuel_s3_integration
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"');

LIST @fuel_stage;


-- For fuel schema (matches fuel_prices_cleaned.csv → 5 columns)
CREATE OR REPLACE TABLE fuel.fuel (
    Date DATE,
    Price FLOAT,
    Open FLOAT,
    High FLOAT,
    Low FLOAT
);

-- For oil schema (matches filtered_oil_price.csv → 2 columns)
CREATE OR REPLACE TABLE oil.oil (
    Date DATE,
    Price FLOAT
);

-- For currency schema (matches cleaned_currency.csv → 6 columns)
CREATE OR REPLACE TABLE currency.currency (
    Date DATE,
    Col1 FLOAT,
    Col2 FLOAT,
    Col3 FLOAT,
    Col4 FLOAT,
    Col5 FLOAT
);

-- For inflation schema (matches inflation_cleaned.csv → 2 columns)
CREATE OR REPLACE TABLE inflation.inflation (
    Date DATE,
    Inflation_Rate FLOAT
);


LIST @fuel_stage;
DESC TABLE fuel.fuel;
DESC TABLE oil.oil;
DESC TABLE currency.currency;
DESC TABLE inflation.inflation;





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

ALTER TABLE fuel.fuel RENAME COLUMN PRICE TO ULSP_Price;
ALTER TABLE fuel.fuel RENAME COLUMN OPEN TO ULSD_Price;
ALTER TABLE fuel.fuel RENAME COLUMN HIGH TO ULSP_Duty;
ALTER TABLE fuel.fuel RENAME COLUMN LOW TO ULSD_Duty;

ALTER TABLE currency.currency RENAME COLUMN COL1 TO Price;
ALTER TABLE currency.currency RENAME COLUMN COL2 TO Open;
ALTER TABLE currency.currency RENAME COLUMN COL3 TO High;
ALTER TABLE currency.currency RENAME COLUMN COL4 TO Low;
ALTER TABLE currency.currency RENAME COLUMN COL5 TO Change_Percentage;


-- Pipelines
SHOW PIPES;
SHOW STAGES;
LIST @fuel_stage;
SHOW INTEGRATIONS;

-- Create Snowpipe for automatic data loading
CREATE OR REPLACE PIPE fuel_pipe
AUTO_INGEST = TRUE
AS 
COPY INTO fuel.fuel
FROM @fuel_stage/fuel_prices_cleaned.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"')
ON_ERROR = 'CONTINUE';


-- Checking if Snowpipe has appeared
SHOW PIPES;