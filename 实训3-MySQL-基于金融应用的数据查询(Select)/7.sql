select c_name,c_phone,c_mail
from client
where c_id_card like "4201%" and c_id not in(
    select distinct pro_c_id
    from property
    where pro_type=1
)
order by c_id;