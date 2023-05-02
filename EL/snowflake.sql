// create some structure db, schema, external stage
create or replace warehouse transforming;
create or replace database staging;
create OR REPLACE database analytics;



// create a staging schema to load data into from s3 bucket
create or replace schema staging.dewale_analytics;


// create a staging area to load data into from s3 bucket
create or replace stage aws_stage
url = 's3://d2b-internal-assessment-bucket/orders_data/';

// get description of stage
desc stage aws_stage;


//list all files in the stage
list @aws_stage;


// create a staging area to load data into from s3 bucket
//create or replace stage test
//url = 's3://d2b-internal-assessment-bucket/';

//list all files in the stage
list @test;

// create the default file format to be used
CREATE OR REPLACE FILE FORMAT csv_format
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null')
  EMPTY_FIELD_AS_NULL = true;


// create table for all files in the s3 bucket IN THE PUBLIC SCHEMA

//table 1 - ORDERS			
CREATE OR REPLACE table staging.dewale_analytics.orders_table (
  order_id INT,
  customer_id INT,
  order_date DATE,
  product_id INT, 
  unit_price DOUBLE,
  quantity DOUBLE,
  total_price DOUBLE
  );

//table 2 - REVIEWS
CREATE OR REPLACE table staging.dewale_analytics.reviews_table (
  review INT,
  product_id INT
  );

//table 3  - SHIPMENT DELIVERIES
CREATE OR REPLACE table staging.dewale_analytics.shipment_deliveries_table ( 
 shipment_id INT,
 order_id INT,
 shipment_date DATE,
 delivery_date DATE
  );

 

// COPY FROM THE STAGE TO THE TABLES IN THE PUBLIC SCHEMA

//1. ORDERS
COPY INTO staging.dewale_analytics.ORDERS_TABLE FROM(
    SELECT *    
    FROM @aws_stage/orders.csv
    (file_format => 'csv_format')
)


// TEST TABLE FOR SUCCESSFULLY COPY
SELECT * FROM staging.dewale_analytics.ORDERS_TABLE


//2. REVIEWS
COPY INTO staging.dewale_analytics.REVIEWS_TABLE FROM(
    SELECT *    
    FROM @aws_stage/reviews.csv
    (file_format => 'csv_format')
)

// TEST TABLE FOR SUCCESSFULLY COPY
SELECT * FROM staging.dewale_analytics.REVIEWS_TABLE LIMIT 10



//3. SHIPMENT DELIVERIES
COPY INTO staging.dewale_analytics.SHIPMENT_DELIVERIES_TABLE FROM(
    SELECT *    
    FROM @aws_stage/shipment_deliveries.csv
    (file_format => 'csv_format')
)

// TEST TABLE FOR SUCCESSFULLY COPY
SELECT * FROM staging.dewale_analytics.SHIPMENT_DELIVERIES_TABLE LIMIT 10



////////////////// SUBMISSISON

// unload agg_public_holiday
COPY INTO 's3://d2b-internal-assessment-bucket/analytics_export/dewaleofficial/agg_public_holiday.csv'
FROM (SELECT * FROM staging.dbt_data2bot.agg_public_holiday )
FILE_FORMAT = (
    TYPE=CSV,
    FIELD_DELIMITER=',',
    NULL_IF=('NULL', 'null'),
    COMPRESSION = 'NONE'
)
OVERWRITE=TRUE
single = true;

// unload agg_shipments
COPY INTO 's3://d2b-internal-assessment-bucket/analytics_export/dewaleofficial/agg_shipments.csv'
FROM (SELECT * FROM staging.dbt_data2bot.agg_shipments )
FILE_FORMAT = (
    TYPE=CSV,
    FIELD_DELIMITER=',',
    NULL_IF=('NULL', 'null'),
    COMPRESSION = 'NONE'
)
OVERWRITE=TRUE
single = true;




// unload best performing product
COPY INTO 's3://d2b-internal-assessment-bucket/analytics_export/dewaleofficial/best_performing_product.csv'
FROM (SELECT * FROM staging.dbt_data2bot.best_performing_product )
FILE_FORMAT = (
    TYPE=CSV,
    FIELD_DELIMITER=',',
    NULL_IF=('NULL', 'null'),
    COMPRESSION = 'NONE'
)
OVERWRITE=TRUE
single = true;