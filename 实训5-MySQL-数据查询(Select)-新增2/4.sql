select w.w_org,sum(w.w_amount) as total_salary
from client c
join wage w on c.c_id=w.w_c_id
where w.w_type=2
group by w.w_org
order by total_salary desc
limit 3;