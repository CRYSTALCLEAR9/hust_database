use finance1;
create view v_insurance_detail as
select c_name,c_id_card,i_name,i_project,pro_status,pro_quantity,i_amount,i_year,pro_income,pro_purchase_time
from property,client,insurance
where pro_c_id=c_id and pro_pif_id=i_id and pro_type=2;