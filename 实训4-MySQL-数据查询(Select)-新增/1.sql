select yo.year as pyear,yo.rk as rk,yo.p_id as p_id,yo.sumamount as sumamount
from(
    select year(pro_purchase_time) as year,p_id,
    sum(pro_quantity*p_amount) as sumamount,
    rank() over(partition by year(pro_purchase_time)
    order by sum(pro_quantity*p_amount)desc,p_id ) as rk
    from property
    join finances_product on p_id=pro_pif_id and pro_type=1
    where pro_purchase_time between '2010-1-1' and '2011-12-31'
    group by year(pro_purchase_time),p_id
) as yo
where rk<=3;