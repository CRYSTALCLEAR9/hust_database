use fib;
drop procedure if exists sp_fibonacci;
delimiter $$
create procedure sp_fibonacci(in m int)
begin
declare i int default 2;
declare a int default 1;
declare b int default 0;
declare tmp int;
if m>=1 then insert into fibonacci values(0,0);
end if;
if m>=2 then insert into fibonacci values(1,1);
end if;
while i<m do 
    set tmp=a;
    set a=a+b;
    set b=tmp;
    insert into fibonacci values(i,a);
    set i=i+1;
end WHILE;
end $$
delimiter;