###########################CREATE TABLE##############################
mysql -uroot -pbigbang123 test << END_MYSQL

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

hadoop dfs -rm /user/vikram2401/studlog/*
hadoop dfs -rmdir /user/vikram2401/studlog

printf "\n\nStart Import Job\n\n"

sqoop import --username root --password bigbang123 --connect jdbc:mysql://localhost/test --table studlog --m 1 --direct

printf "\n\n\nOutput of ls in root directory\n\n"
hadoop dfs -ls /user/vikram2401

printf "\n\n\nOutput of ls in studlog directory\n\n"
hadoop dfs -ls /user/vikram2401/studlog

printf "\n\n\nImported Data:\n\n\n"
hadoop dfs -cat /user/vikram2401/studlog/part-m-00000

printf "\n\nImported Successfully\n\n\n"

########################## Create Table to Hold Exported Data#############

mysql -uroot -pbigbang123 test << END_MYSQL

drop table if exists hdfsfiledata;

create table hdfsfiledata(id int,name varchar(10),book varchar(25));

desc hdfsfiledata;

END_MYSQL

printf "\n\nTable created\n\n\n"

########################## Exporting Data from hdfs #######################

printf "Exporting Now\n\n\n"

sqoop export --username root --password bigbang123 --connect jdbc:mysql://localhost:3306/test?useSSL=false --table hdfsfiledata --m 1 --direct --export-dir /user/vikram2401/studlog/part-m-00000

#sqoop export --username root --password bigbang123 --driver com.mysql.jdbc.Driver --connect jdbc:mysql://localhost:3306/test --table studlog --m 1 --export-dir /user/vikram2401/studlog

#sqoop export --username root --password bigbang123 --connect jdbc:mysql://localhost/test --table exportedTable --export-dir /user/vikram2401/studlog

printf "\n\n\nDone Exporting\n\n\n"

########################## Show Contents of exportedTable ##################

printf "Showing contents of exportedTable:\n\n"
mysql  -uroot -pbigbang123 test << END_MYSQL

select * from hdfsfiledata;

END_MYSQL

printf "\n\nDone\n\n\n"
