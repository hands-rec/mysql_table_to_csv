#!/bin/bash

user=$1
password=$2
host=$3
database=$4

show_table_file="./tables.csv"

# show tables
echo "show tables"
sql_show_tables="show tables;"
mysql -u${user} -p${password} -h${host} -A ${database} -N -e "${sql_show_tables}" > ${show_table_file}

# show full columns from xxx
dir_tables="tables"
rm -rf ${dir_tables}
mkdir ${dir_tables}
sql_show_full_columns="show full columns from "

for table in `cat ${show_table_file}`
do
  echo ${table}
  mysql -u${user} -p${password} -h${host} -A ${database} -e "${sql_show_full_columns} ${table}" | sed -e 's/,/ /g' | sed -e 's/\t/,/g' > ${dir_tables}/${table}".csv"
done

