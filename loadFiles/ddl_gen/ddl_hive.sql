create external table tera_import.area
     (
      n_nationkey int,
      n_name char(25),
      n_regionkey int,
      n_comment varchar(152)) 
row format delimited fields terminated by '|';
create external table tera_import.client
     (
      c_custkey int,
      c_name varchar(25),
      c_address varchar(40),
      c_nationkey int,
      c_phone char(15),
      c_acctbal decimal(15,2),
      c_mktsegment char(10),
      c_comment varchar(117)) 
row format delimited fields terminated by '|';
create external table tera_import.contract
     (
      o_orderkey int,
      o_custkey int,
      o_orderstatus char(1),
      o_totalprice decimal(15,2),
      o_orderdate string,
      o_orderpriority varchar(15),
      o_clerk varchar(15),
      o_shippriority int,
      o_comment varchar(79)) 
row format delimited fields terminated by '|';
create external table tera_import.employee
     (
      empno varchar(15),
      name varchar(18),
      address varchar(40),
      phone char(15),
      deptno smallint,
      salary decimal(8,2),
      yrsexp tinyint,
      dob string,
      medstat char(1),
      edlev tinyint,
      note varchar(79)) 
row format delimited fields terminated by '|';
create external table tera_import.item
     (
      l_orderkey int,
      l_partkey int,
      l_suppkey int,
      l_linenumber int,
      l_quantity decimal(15,2),
      l_extendedprice decimal(15,2),
      l_discount decimal(15,2),
      l_tax decimal(15,2),
      l_returnflag char(1),
      l_linestatus char(1),
      l_shipdate string,
      l_commitdate string,
      l_receiptdate string,
      l_shipinstruct char(25),
      l_shipmode char(10),
      l_comment varchar(44)) 
row format delimited fields terminated by '|';
create external table tera_import.itemppi
     (
      l_orderkey int,
      l_partkey int,
      l_suppkey int,
      l_linenumber int,
      l_quantity decimal(15,2),
      l_extendedprice decimal(15,2),
      l_discount decimal(15,2),
      l_tax decimal(15,2),
      l_returnflag char(1),
      l_linestatus char(1),
      l_shipdate string,
      l_commitdate string,
      l_receiptdate string,
      l_shipinstruct char(25),
      l_shipmode char(10),
      l_comment varchar(44)) 
row format delimited fields terminated by '|';
create external table tera_import.product
     (
      p_partkey int,
      p_name varchar(55),
      p_mfgr char(25),
      p_brand char(10),
      p_type varchar(25),
      p_size int,
      p_container char(10),
      p_retailprice decimal(15,2),
      p_comment varchar(23)) 
row format delimited fields terminated by '|';
create external table tera_import.provider
     (
      s_suppkey int,
      s_name char(25),
      s_address varchar(40),
      s_nationkey int,
      s_phone char(15),
      s_acctbal decimal(15,2),
      s_comment varchar(101)) 
row format delimited fields terminated by '|';
create external table tera_import.region
     (
      r_regionkey int,
      r_name char(25),
      r_comment varchar(152)) 
row format delimited fields terminated by '|';
