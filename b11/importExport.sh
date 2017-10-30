###########################CREATE TABLE##############################
mysql -h 10.10.15.13 -usql1 -psql1 test << END_MYSQL

drop table if exists studlog;

create table studlog(id int,name varchar(10),book varchar(25));

desc studlog;

insert into studlog values(1,"ABC","Java Complete Reference");
insert into studlog values(2,"XYZ","Let Us C");

select * from studlog;

END_MYSQL

printf "\n\nTable created\n\n\n"

########################### IMPORT From MySQL ##########################

printf "Delete directories if they exist on hdfs\n\n\n"

hadoop dfs -rm /user/root/studlog/*
hadoop dfs -rmdir /user/root/studlog

printf "\n\nStart Import Job\n\n"

sqoop import --connect jdbc:mysql://10.10.15.13/test --table studlog --m 1 --driver com.mysql.jdbc.Driver --username sql1 --password sql1

printf "\n\n\nOutput of ls in root directory\n\n"
hadoop dfs -ls /user/root

printf "\n\n\nOutput of ls in studlog directory\n\n"
hadoop dfs -ls /user/root/studlog

printf "\n\n\nImported Data:\n\n\n"
hadoop dfs -cat /user/root/studlog/part-m-00000

printf "\n\nImported Successfully\n\n\n"

########################## Create Table to Hold Exported Data#############

mysql -h 10.10.15.13 -usql1 -psql1 test << END_MYSQL

drop table if exists exportedTable;

create table exportedTable(id int,name varchar(10),book varchar(25));

desc exportedTable;

END_MYSQL

printf "\n\nTable created\n\n\n"

########################## Exporting Data from hdfs #######################

printf "Exporting Now\n\n\n"

sqoop export --connect jdbc:mysql://10.10.15.13/test --table exportedTable --driver com.mysql.jdbc.Driver --export-dir /user/root/studlog --username sql1 --password sql1

printf "\n\n\nDone Exporting\n\n\n"

########################## Show Contents of exportedTable ##################

printf "Showing contents of exportedTable:\n\n"
mysql -h 10.10.15.13 -usql1 -psql1 test << END_MYSQL

select * from exportedTable;

END_MYSQL

printf "\n\nDone\n\n\n"
