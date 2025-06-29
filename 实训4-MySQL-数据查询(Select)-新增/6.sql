select *
from(
    select *,rank() over(partition by pac order by common desc,pbc) as crank
    from(
        select distinct A.pro_c_id as pac,C.pro_c_id as pbc,count(C.pro_c_id) as common
        from property as A 
        join(
            select distinct B.pro_c_id as pro_c_id,B.pro_pif_id as pro_pif_id
            from property as B 
            where B.pro_type=1
        ) as C on A.pro_c_id!=C.pro_c_id and A.pro_pif_id=C.pro_pif_id
        where A.pro_type=1
        group by A.pro_c_id,C.pro_c_id
    ) as tmp1
)as tmp2
where crank<3;