create database if not exists MyDb;
use MyDb;
drop table if exists s;
create table s(
    sno char(10) primary key,
    name varchar(32) not null,
    ID char(18) unique
);