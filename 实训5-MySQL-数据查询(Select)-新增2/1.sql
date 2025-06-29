select c.c_name,extract(year from w.w_time) as year,c.c_id_card,
    coalesce(sum(case when w.w_type=1 then w.w_amount else 0 end),0) as full_t_amount,
    coalesce(sum(case when w.w_type=2 then w.w_amount else 0 end),0) as part_t_amount
from client c
inner join wage w ON c.c_id=w.w_c_id
group by c.c_id,extract(year from w.w_time),c.c_name,c.c_id_card
order by (full_t_amount+part_t_amount) desc;