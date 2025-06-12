select c_name,c_id_card,sum(
        case 
            when pro_type=1 then ifnull(p_amount,0)*ifnull(pro_quantity,0)
            when pro_type=2 then ifnull(i_amount,0)*ifnull(pro_quantity,0)
            when pro_type=3 then ifnull(f_amount,0)*ifnull(pro_quantity,0)
            else 0
        end
    ) as total_amount
from client
left join property on pro_c_id=c_id
left join finances_product on pro_pif_id=p_id and pro_type=1
left join insurance on pro_pif_id=i_id and pro_type=2
left join fund on pro_pif_id=f_id and pro_type=3
group by c_id,c_name,c_id_card
order by total_amount desc;