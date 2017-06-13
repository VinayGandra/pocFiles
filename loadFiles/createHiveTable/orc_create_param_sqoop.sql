create table param_sqoop_orc 
(id INT, logical_table_name STRING, table_name STRING, param_name STRING, param_val STRING, job_type STRING, table_type string)
clustered by (job_type) into 3 buckets stored as orc;

insert into table param_sqoop_orc select * from param_sqoop;

