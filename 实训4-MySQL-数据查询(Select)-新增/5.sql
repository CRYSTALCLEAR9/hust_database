select A.pro_c_id as pro_c_id,B.pro_c_id as pro_c_id,count(*) as total_count
from property as A join property as B on A.pro_c_id!=B.pro_c_id
where A.pro_type=1 and B.pro_type=1 and A.pro_pif_id=B.pro_pif_id
group by A.pro_c_id,B.pro_c_id
having count(*)>=2
order by A.pro_c_id;