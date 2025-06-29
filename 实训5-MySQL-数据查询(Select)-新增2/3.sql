select c_name,c_id_card,sum(w_amount) as total_salary
from client c
join wage w on c_id=w_c_id
where w_type=2
group by c_id,c_name,c_id_card
order by total_salary desc
limit 3;