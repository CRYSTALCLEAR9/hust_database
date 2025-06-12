select c_id,c_name,count(b_c_id) as number_of_cards
from client
left join bank_card on b_c_id=c_id
where c_name like '黄%'
group by c_id,c_name
order by number_of_cards desc,c_id;