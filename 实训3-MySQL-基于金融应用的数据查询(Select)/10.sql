select c_name,c_id_card,total_income 
from(
    select pro_c_id,sum(pro_income) as total_income
    from property
    where pro_status='可用'
    group by pro_c_id
)as T,client
where c_id=pro_c_id
order by total_income desc
limit 3;