select a.pro_purchase_time as pro_purchase_time,a.total_amount as total_amount
from(
    select pro_purchase_time,sum(f_amount*pro_quantity) as total_amount,date_add(pro_purchase_time,interval if(dayofweek(pro_purchase_time)=6,3,1)day) as nextday
    from property join fund on f_id=pro_pif_id
    where pro_purchase_time between '2022-02-07' and '2022-02-28'  
    group by pro_purchase_time
    having sum(f_amount * pro_quantity)>=1000000
) as a
join (
    select pro_purchase_time,sum(f_amount*pro_quantity) as total_amount,date_add(pro_purchase_time,interval if(dayofweek(pro_purchase_time)=6,3,1)day) as nextday
    from property join fund on f_id=pro_pif_id
    where pro_purchase_time between '2022-02-07' and '2022-02-28'  
    group by pro_purchase_time
    having sum(f_amount * pro_quantity)>=1000000  
) as b
join(
    select pro_purchase_time,sum(f_amount*pro_quantity) as total_amount
    from property join fund on f_id=pro_pif_id
    where pro_purchase_time between '2022-02-07' and '2022-02-28'  
    group by pro_purchase_time
    having sum(f_amount * pro_quantity)>=1000000  
) as c
where a.nextday=b.pro_purchase_time and b.nextday=c.pro_purchase_time
union
select b.pro_purchase_time as pro_purchase_time,b.total_amount as total_amount
from(
    select pro_purchase_time, sum(f_amount*pro_quantity) as total_amount,date_add(pro_purchase_time,interval if(dayofweek(pro_purchase_time)=6,3,1)day) as nextday
    from property join fund on f_id=pro_pif_id
    where pro_purchase_time between '2022-02-07' and '2022-02-28'  
    group by pro_purchase_time
    having sum(f_amount*pro_quantity)>=1000000
) as a
join(
    select pro_purchase_time, sum(f_amount*pro_quantity) as total_amount,date_add(pro_purchase_time,interval if(dayofweek(pro_purchase_time)=6,3,1)day) as nextday
    from property join fund on f_id=pro_pif_id
    where pro_purchase_time between '2022-02-07' and '2022-02-28'  
    group by pro_purchase_time
    having sum(f_amount*pro_quantity)>=1000000  
) as b
join (
    select pro_purchase_time, sum(f_amount * pro_quantity) as total_amount
    from property join fund on f_id=pro_pif_id
    where pro_purchase_time between '2022-02-07' and '2022-02-28'  
    group by pro_purchase_time
    having sum(f_amount*pro_quantity)>=1000000  
) as c
where a.nextday=b.pro_purchase_time and b.nextday=c.pro_purchase_time
union
select c.pro_purchase_time as pro_purchase_time,c.total_amount as total_amount
from(
    select pro_purchase_time, sum(f_amount*pro_quantity) as total_amount ,date_add(pro_purchase_time,interval if(dayofweek(pro_purchase_time)=6,3,1)day) as nextday
    from property join fund on f_id=pro_pif_id
    where pro_purchase_time between '2022-02-07' and '2022-02-28'  
    group by pro_purchase_time
    having sum(f_amount * pro_quantity)>=1000000
) as a
join(
    select pro_purchase_time, sum(f_amount * pro_quantity) as total_amount,date_add(pro_purchase_time,interval if(dayofweek(pro_purchase_time)=6,3,1)day) as nextday
    from property join fund on f_id=pro_pif_id
    where pro_purchase_time between '2022-02-07' and '2022-02-28'  
    group by pro_purchase_time
    having sum(f_amount * pro_quantity)>=1000000  
) as b
join (
    select pro_purchase_time,sum(f_amount*pro_quantity) as total_amount
    from property join fund on f_id=pro_pif_id
    where pro_purchase_time between '2022-02-07' and '2022-02-28'  
    group by pro_purchase_time
    having sum(f_amount * pro_quantity)>=1000000  
) as c
where a.nextday=b.pro_purchase_time and b.nextday=c.pro_purchase_time;