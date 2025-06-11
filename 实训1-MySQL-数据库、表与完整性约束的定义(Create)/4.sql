create database if not exists MyDb;
use MyDb;
drop table if exists products;
create table products(
    pid char(10) primary key,
    name varchar(32),
    brand char(10) constraint CK_products_brand check(brand in ('A','B')),
    price int constraint CK_products_price check(price>0)
);