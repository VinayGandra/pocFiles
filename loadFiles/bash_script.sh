#!/bin/sh

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "Please provide either [table] or [type] or [all] arguments followed by options [tablename] or [sub type name] or [tables] respectively"
    exit 1
fi

if [ $1 = "table" ]; then
  #echo "select * from param_sqoop where table_name=\"$2\" order by id"
  query=$"select * from param_sqoop where table_name=\"$2\" order by id"
elif [ $1 = "type" ]; then
  #echo "select * from param_sqoop where job_type=\"$2\" order by id"
  query=$"select * from param_sqoop where job_type=\"$2\" order by id"
elif [ $1 = "all" ]; then
  #echo "select * from param_sqoop order by id"
  query=$"select * from param_sqoop order by id"
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

awk -v var="$prefixString" '{table[$3]=table[$3] " --" $4 " " $5;}
  END{for (key in table)
       print var key table[key];}' |

while read lines
do
 echo "oozie job -oozie http://vm-hadoop-s2:11000/oozie -config ./oozie_sqoop/job.properties -D ${lines} -submit"
 #echo $(oozie job -oozie http://vm-hadoop-s2:11000/oozie -config ./oozie_sqoop/job.properties -D "${lines}" -submit)
 echo $(oozie job -oozie http://vm-hadoop-s2:11000/oozie -config ./oozie_sqoop/job.properties -D "${lines}" -run)
 #break
done 
