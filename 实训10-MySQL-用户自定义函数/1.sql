use finance1;
set global log_bin_trust_function_creators=1;
drop function if exists get_deposit;
delimiter $$
create function get_deposit(client_id int)
returns numeric(10,2) 
begin
    declare deposit numeric(10,2) default 0;
	select sum(b_balance) into deposit 
    from bank_card
    where b_c_id = client_id and b_type='储蓄卡';
    return deposit;
end$$
delimiter;
select c_id_card,c_name,get_deposit(c_id) as total_deposit
from client
where get_deposit(c_id)>=1000000
order by get_deposit(c_id) desc;