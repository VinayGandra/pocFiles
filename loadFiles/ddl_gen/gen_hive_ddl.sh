#!/bin/sh

HDFS_PATH=/user/vinay/retaildb/

DBNAME=tera_import

impala-shell -q "drop database if exists ${DBNAME} cascade"

impala-shell -q "create database if not exists ${DBNAME}"

rm -f ddl_hive.sql 2> /dev/null
rm -f alter_table.sql 2> /dev/null

sed -e 's/ ,NO FALLBACK ,\|NO BEFORE JOURNAL,\|NO AFTER JOURNAL,\|CHECKSUM = DEFAULT,\|DEFAULT MERGEBLOCKRATIO\| CHARACTER SET LATIN NOT CASESPECIFIC\| NOT NULL//g' ddl_teradata.txt |

sed -e 's/^CREATE SET/CREATE EXTERNAL/g' |

sed -e "s/retail\./${DBNAME}\./g" |

sed -e 's/PRIMARY INDEX.*\|UNIQUE PRIMARY INDEX.*\|INDEX.*\|PARTITION BY.*//g' |

#sed -e "s/DATE FORMAT 'YYYY-MM-DD'/DATE/g" |

sed -e "s/DATE FORMAT 'YYYY-MM-DD'/STRING/g" |

sed -e "s/BYTEINT,/TINYINT,/g" |

sed -e "s/BYTEINT)/TINYINT)/g" |

sed -e "s:)\n*$:) \nROW FORMAT DELIMITED FIELDS TERMINATED BY '|';:g" |

sed -e '/^\s*$/d' |

sed -e 's/INTEGER/int/g' |

sed -E 's/([[:upper:]])/\L\1/g' >> ddl_hive.sql

#hive -f ddl_hive.sql

impala-shell -q "invalidate metadata"

#Prefer impala-shell if no date format
impala-shell -f ddl_hive.sql --quiet

impala-shell -B -q "select concat(\"alter table \", '${DBNAME}.',table_name, \" set location \'${HDFS_PATH}\", table_name, \"\';\") from (select distinct(table_name) from param_sqoop) qr;" >> alter_table.sql

impala-shell -f alter_table.sql
