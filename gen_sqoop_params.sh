#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    echo "Please provide CASE SENSITIVE TABLE NAME to import as argument"
    exit 1
fi

hostIP=10.1.50.198
dbName=retail
username=dbc
password=dbc
prefixString="job=import --connect jdbc:teradata://$hostIP/DATABASE=$dbName --username $username --password $password --table "

rm -r ./oozie_$1
mkdir ./oozie_$1
cp ./oozie_template/* ./oozie_$1/

echo "appRoot=oozie_$1" >> ./oozie_$1/job.properties
echo "oozie.wf.application.path=\${nameNode}/user/\${user.name}/\${appRoot}" >> ./oozie_$1/job.properties

impala-shell -q "select * from param_sqoop where table_name='$1'" -B |

awk -v var="$prefixString" '{table[var $3]=table[var $3] " --" $4 " " $5;} END{print var $3 table[var $3];}' >> ./oozie_$1/job.properties

#awk '{table[$3]=table[$3] " --" $4 " " $5;}
#  END{for (key in table)
#       print "job=import --connect jdbc:teradata://10.1.50.198/DATABASE=retail --username dbc --password dbc --table " key table[key];}' >> ./oozie_$1/job.properties

hadoop fs -rm -r oozie_$1
hadoop fs -put ./oozie_$1
hadoop fs -rm -r retaildb/$1

oozie job -oozie http://vm-hadoop-s2:11000/oozie -config ./oozie_$1/job.properties -run
#oozie job -oozie http://vm-hadoop-s2:11000/oozie -config ./oozie_$1/job.properties -submit

