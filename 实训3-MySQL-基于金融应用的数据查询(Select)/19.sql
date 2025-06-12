select wk-5 as week_of_trading,mon.tot as monday,tue.tot as tuesday,wed.tot as wednesday,thu.tot as thursday,fri.tot as friday
from(
    select sum(pro_quantity*f_amount) as tot,week( pro_purchase_time) as wk
    from property join fund on pro_pif_id=f_id 
    where pro_type=3 and weekday(pro_purchase_time)=0 and pro_purchase_time between '2022-02-07' and '2022-02-28'
    group by pro_purchase_time
) as mon
left join(
    select sum(pro_quantity*f_amount) as tot,week( pro_purchase_time) as wk
    from property join fund on pro_pif_id=f_id 
    where pro_type=3 and weekday(pro_purchase_time)=1 and pro_purchase_time between '2022-02-07' and '2022-02-28'
    group by pro_purchase_time
) as tue using(wk)
left join(
    select sum(pro_quantity*f_amount) as tot,week( pro_purchase_time) as wk
    from property join fund on pro_pif_id=f_id 
    where pro_type=3 and weekday(pro_purchase_time)=2 and pro_purchase_time between '2022-02-07' and '2022-02-28'
    group by pro_purchase_time
) as wed using(wk)
left join (
    select sum(pro_quantity*f_amount) as tot,week( pro_purchase_time) as wk
    from property join fund on pro_pif_id=f_id 
    where pro_type=3 and weekday(pro_purchase_time)=3 and pro_purchase_time between '2022-02-07' and '2022-02-28'
    group by pro_purchase_time
) as thu using(wk)
left join (
    select sum(pro_quantity*f_amount) as tot,week( pro_purchase_time) as wk
    from property join fund on pro_pif_id=f_id 
    where pro_type=3 and weekday(pro_purchase_time)=4 and pro_purchase_time between '2022-02-07' and '2022-02-28'
    group by pro_purchase_time
) as fri using(wk);