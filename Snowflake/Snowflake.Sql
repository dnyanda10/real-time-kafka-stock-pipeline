-- Step 1: Create a database (only once)
CREATE OR REPLACE DATABASE kafka_project;

-- Step 2: Create a schema inside it
CREATE OR REPLACE SCHEMA kafka_s3_schema;

-- Step 3: Use the new database and schema
USE DATABASE kafka_project;
USE SCHEMA kafka_s3_schema;

CREATE OR REPLACE STORAGE INTEGRATION my_s3_integration
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = 'S3'
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::021375251070:role/snowflake-s3-connection'
STORAGE_ALLOWED_LOCATIONS = ('s3://dnyan-kafka-stock-project/');

DESC INTEGRATION my_s3_integration;

CREATE OR REPLACE STAGE kafka_s3_stage
URL='s3://dnyan-kafka-stock-project/'
STORAGE_INTEGRATION = my_s3_integration
FILE_FORMAT = (TYPE = JSON);

LIST @kafka_s3_stage;

CREATE OR REPLACE TABLE stock_data (
  Index_name STRING,
  Date DATE,
  Open FLOAT,
  High FLOAT,
  Low FLOAT,
  Close FLOAT,
  Adj_Close FLOAT,
  Volume FLOAT,
  CloseUSD FLOAT
);

CREATE OR REPLACE FILE FORMAT json_format
TYPE = 'JSON';

COPY INTO stock_data
FROM @kafka_s3_stage
FILE_FORMAT = json_format
PATTERN = '.*[.]json';

CREATE OR REPLACE TABLE stock_market_stage (
    data VARIANT
);

CREATE OR REPLACE PIPE stock_pipe
AUTO_INGEST = TRUE
AS
COPY INTO stock_data
FROM (
    SELECT
        $1:Index::STRING,
        TO_DATE($1:Date::STRING, 'YYYY-MM-DD'),
        $1:Open::FLOAT,
        $1:High::FLOAT,
        $1:Low::FLOAT,
        $1:Close::FLOAT,
        $1:Adj_Close::FLOAT,
        $1:Volume::FLOAT,
        $1:CloseUSD::FLOAT
    FROM @kafka_s3_stage
)
FILE_FORMAT = (FORMAT_NAME = json_format);

SELECT * FROM stock_data ORDER BY Date DESC LIMIT 10;

