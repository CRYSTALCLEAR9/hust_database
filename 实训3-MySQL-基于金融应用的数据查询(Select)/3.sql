select c_name,c_mail,c_phone
from client
where c_id in(
    select x.pro_c_id
    from property x,property y
    where x.pro_c_id=y.pro_c_id and x.pro_type=2 and y.pro_type=3
)
order by c_id;