select C.c_id as c_id1, D.c_id as c_id2
from client as C
join client as D on C.c_id<D.c_id
where not exists(
    select *
    from property as A
    where not exists(
        select *
        from property as B
        where  B.pro_c_id=D.c_id and B.pro_type=3 and A.pro_pif_id=B.pro_pif_id
    )and A.pro_c_id=C.c_id and A.pro_type=3 
)and not exists(
    select *
    from property as A
    where not exists(
        select *
        from property as B
        where  B.pro_c_id=C.c_id and B.pro_type=3 and A.pro_pif_id=B.pro_pif_id
    )and A.pro_c_id=D.c_id and A.pro_type=3 
)and exists(
    select 1
    from property 
    where C.c_id=pro_c_id and pro_type=3
);