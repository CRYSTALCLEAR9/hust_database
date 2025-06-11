create database if not exists MyDb;
use MyDb;
drop table if exists hr;
create table hr(
    id char(10) primary key,
    name varchar(32) not null,
    mz char(16) default '汉族'
);