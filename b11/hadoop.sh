################## Perform mysql operations ###############
mysql -uroot -proot test << END_MYSQL
show tables;
drop table if exists studlog;
create table  studlog(id int, name varchar(20), book varchar(20));

describe studlog;

insert into studlog values(1,'John','Hadoop');
insert into studlog values(2,'Peter','Java');

select * from studlog;

END_MYSQL
echo "Done with mysql operations";


################# Import mysql table into HDFS #####################

echo $SQOOP_HOME
echo "Removing hdfs file if exists "

hadoop fs -rm -r /user/pavan/studlog

sqoop import --username root --password root --connect jdbc:mysql://localhost:3306/test --table studlog --m 1

hadoop fs -ls /user/pavan/

echo "Mysql table imported successfully ";


################# Export file from HDFS to mysql table #####################
# for exporting file, create a empty table first. I have changed table name here
mysql -uroot -proot test << END_MYSQL

drop table if exists hdfsfiledata;
create table hdfsfiledata (id int, name varchar(20), book varchar(20));

descibe hdfsfiledata;

END_MYSQL

sqoop export --connect jdbc:mysql://localhost:3306/test --table hdfsfiledata --m 1 --export-dir /user/pavan/studlog/part-m-00000

echo "Export successful";

# Check the table contents

echo "select * from hdfsfiledata;" | mysql -uroot -proot test;

echo "Congratulations. Import Export done successfully";
