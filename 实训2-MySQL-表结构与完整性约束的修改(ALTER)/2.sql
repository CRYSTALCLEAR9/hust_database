use MyDb;
alter table orderDetail drop orderDate;
alter table orderDetail add unitPrice numeric(10,2);