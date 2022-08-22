drop database if exists quiz1;
create database quiz1;
use quiz1;
create table datatable1
(
 id int auto_increment comment 'id'
 primary key,
 data1 varchar(45) null comment 'data1',
 data2 varchar(45) null comment 'data2',
 data3 varchar(45) null comment 'data3'quiz1scott
)
 comment 'datatable1';
insert into datatable1 (id, data1, data2, data3)
values (1, 'aaa1', 'aaa2', 'aaa3'),
 (2, 'bbb1', 'bbb2', 'bbb3'),
 (3, 'ccc1', 'ccc2', 'ccc3');
select * from datatable1;
