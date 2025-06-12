select b_c_id,sum(b_balance) as credit_card_amount
from bank_card
where b_c_id in (
    select b_c_id
    from bank_card 
    where b_type="信用卡" and b_balance>5000
)and b_type="信用卡"
group by b_c_id
order by b_c_id;