CREATE TABLE param_sqoop (
  id INT,
  logical_table_name STRING,
  table_name STRING,
  param_name STRING,
  param_val STRING,
  job_type STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';
