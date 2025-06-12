select c_name,c_id_card,c_phone
from client
where c_id in(
    select b_c_id
    from bank_card
    where b_type='信用卡'
    group by b_c_id
    having count(*)>=2
)
order by c_id;