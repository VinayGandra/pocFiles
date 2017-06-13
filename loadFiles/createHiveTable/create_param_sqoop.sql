create table param_sqoop
(id INT, logical_table_name STRING, table_name STRING, param_name STRING, param_val STRING, job_type STRING, table_type string)
row format delimited fields terminated by ',';
