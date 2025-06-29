select D.pro_pif_id as pro_pif_id,count(*) as cc,dense_rank() over(order by count(E.pro_c_id)desc) as prank
from( 
    select B.pro_pif_id as pro_pif_id
    from property as B
    where exists(
        select *
        from(
            select pro_c_id,dense_rank() over(order by sum(pro_quantity)desc) as rk 
            from property
            where pro_type=1 and pro_pif_id=14
            group by pro_c_id
        ) as A
        where A.rk<=3 and A.pro_c_id=B.pro_c_id
    )and B.pro_type=1 and B.pro_pif_id!=14
) as D
join(
    select *
    from property
    where pro_type=1 and pro_pif_id!=14
) as E 
using(pro_pif_id)
group by D.pro_pif_id
order by D.pro_pif_id;