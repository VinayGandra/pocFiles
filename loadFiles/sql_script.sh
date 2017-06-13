#!/bin/sh

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "Please provide either [table] or [type] or [all] arguments followed by options [tablename] or [sub type name] or [tables] respectively"
    exit 1
fi

if [ $1 = "table" ]; then
  query=$"select concat(table_name, group_concat(con, '')) from (select table_name, concat(\" --\", param_name, \" \", param_val) as con from param_sqoop) qr where table_name=\"$2\" group by table_name"
elif [ $1 = "type" ]; then
  query=$"select concat(table_name, group_concat(con, '')) from (select table_name, job_type, concat(\" --\", param_name, \" \", param_val) as con from param_sqoop) qr where job_type=\"$2\" group by table_name"
elif [ $1 = "all" ]; then
  query=$"select concat(table_name, group_concat(con, '')) from (select table_name, concat(\" --\", param_name, \" \", param_val) as con from param_sqoop) qr group by table_name"
else
  echo "Incorrect argument, use [table] or [type] or [all]"
  exit 1
fi

hostIP=10.1.50.198
dbName=retail
username=dbc
password=dbc
prefixString="job=import --connect jdbc:teradata://$hostIP/DATABASE=$dbName --username $username --password $password --table "

impala-shell -q "$query" -B |

awk -v var="$prefixString" '{print var $0}' |

while read lines
do
 echo "oozie job -oozie http://vm-hadoop-s2:11000/oozie -config ./oozie_sqoop/job.properties -D ${lines} -submit"
 #echo $(oozie job -oozie http://vm-hadoop-s2:11000/oozie -config ./oozie_sqoop/job.properties -D "${lines}" -submit)
 echo $(oozie job -oozie http://vm-hadoop-s2:11000/oozie -config ./oozie_sqoop/job.properties -D "${lines}" -run)
 #break
done 
