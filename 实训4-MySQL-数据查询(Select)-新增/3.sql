select distinct A.pro_c_id as pro_c_id
from property as A
where not exists(
    select *
    from(
        select pro_pif_id
        from property 
        where pro_type=1
        group by pro_pif_id
        having count(pro_c_id)>2
    ) as B 
    where not exists(
        select *
        from property as C
        where A.pro_c_id=C.pro_c_id and B.pro_pif_id=C.pro_pif_id and C.pro_type=1
    )
)
order by A.pro_c_id;