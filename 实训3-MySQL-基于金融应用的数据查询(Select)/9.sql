select c_name,c_phone,c_mail
from client
where c_id in(
    select pro_c_id
    from property,fund
    where pro_type=3 and pro_pif_id=f_id and f_type='货币型'
)
order by c_id;