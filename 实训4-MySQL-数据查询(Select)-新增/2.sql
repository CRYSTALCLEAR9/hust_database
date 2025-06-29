select distinct pro_c_id
from(
  select pro_c_id,count(pro_pif_id) as p_cnt
  from property
  where pro_type=1
  group by pro_c_id
  having count(pro_pif_id)>=3
) as A
join(
  select pro_c_id,count(pro_pif_id) as f_cnt
  from property
  where pro_type=3
  group by pro_c_id
) as B
using(pro_c_id)
where p_cnt>f_cnt
order by pro_c_id;