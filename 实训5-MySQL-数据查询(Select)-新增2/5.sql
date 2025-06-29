insert into wage(w_c_id,w_amount,w_org,w_time,w_type,w_memo,w_tax)
with deduplicated as(
    select distinct c_id_card,w_amount,w_org,w_time,w_type,w_memo
    from new_wage
)
select c.c_id as w_c_id,sum(d.w_amount) as w_amount,d.w_org,
    case
        when d.w_type=1 then max(d.w_time)
        when d.w_type=2 then min(d.w_time)
    end as w_time,d.w_type,group_concat(d.w_memo order by d.w_time) as w_memo,'N' as w_tax
from deduplicated d
join client c on d.c_id_card=c.c_id_card
group byc.c_id,d.w_org,d.w_type,
    case
        when d.w_type=1 then d.w_time
        when d.w_type=2 then date_format(d.w_time,'%Y-%m')
    end
order by c.c_id;