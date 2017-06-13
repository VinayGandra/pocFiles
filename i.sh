#!/bin/sh

#impala-shell -f select_query.sql -B  -o output_query

awk '{table[$1 $3]=table[$1 $3] " --" $4 " " $5;}
  END {for (key in table)
          print "sqoop import jdbc:teradata://10.1.50.198/DATABASE=retail --table " key table[key];}' output_query >> input

sed -i 's/^[0-9]\+/sqoop import --connect jdbc:teradata:\/\/10.1.50.198\/DATABASE=retail --username dbc --password dbc --table /' input
