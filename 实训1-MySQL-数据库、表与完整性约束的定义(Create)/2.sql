create database if not exists TestDb;
use TestDb;
drop table if exists t_emp;
create table t_emp(
    id int,
    name varchar(32),
    deptId int,
    salary float,
    constraint PK_t_emp primary key(id)
);