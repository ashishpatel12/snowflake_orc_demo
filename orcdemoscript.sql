--Author:Ashish Patel
--Snowflake Computing
------------------------------------------------------------------------------------------
--SETUP
------------------------------------------------------------------------------------------
//CREATE DATABASE
CREATE OR REPLACE DATABASE ORC_DEMO_DB;

//CREATE TABLE
CREATE OR REPLACE TABLE "ORC_DEMO_DB"."PUBLIC"."ORC_TEST_TABLE" ("FIRSTNAME" STRING, "LASTNAME" STRING, "EMAIL" STRING, "GENDER" STRING,"COUNTRY" STRING);

//CREATE A FILE FORMAT
CREATE OR REPLACE FILE FORMAT orc_ff TYPE = 'ORC';

------------------------------------------------------------------------------------------
--WORKING WITH THE STAGE
------------------------------------------------------------------------------------------
//QUERY ALL FILES IN STAGE
list @orc_demo_stage;

//LOOK AT DATA IN THE ORC FILE
SELECT t.$1 from @orc_demo_stage (file_format => orc_ff) t;

//QUERY TO GET DESIRED COLUMN NAMES
SELECT t.$1:"_col2",t.$1:"_col3",t.$1:"_col4",t.$1:"_col5",t.$1:"_col8" from @orc_demo_stage (file_format => orc_ff) t;

------------------------------------------------------------------------------------------
--LOADING THE DATA
------------------------------------------------------------------------------------------

//USE SELECT STATEMENT FROM ABOVE TO LOAD INTO TABLE
copy into ORC_TEST_TABLE
from
(
SELECT t.$1:"_col2",t.$1:"_col3",t.$1:"_col4",t.$1:"_col5",t.$1:"_col8" from @orc_demo_stage (file_format => orc_ff) t
);

//CHECK LOADED VALUES
SELECT * FROM ORC_TEST_TABLE;
