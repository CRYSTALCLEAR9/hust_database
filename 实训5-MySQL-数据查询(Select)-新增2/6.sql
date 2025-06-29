update wage w2
join(
    select w1.w_c_id as c_id,sum(w1.w_amount) as total
    from wage w1
    where year(w1.w_time)=2023 and w1.w_c_id=(
        select c.c_id
        from client c
        where c.c_id_card='420108199702144323')
    group by w1.w_c_id
)as annual on w2.w_c_id=annual.c_id
set w2.w_amount=
        case
            when annual.total>60000 then w2.w_amount-(((annual.total-60000)*0.2)*(w2.w_amount/annual.total))
            else w2.w_amount
        end,
    w2.w_tax=
        case
            when annual.total>60000 then 'Y'
            else 'N'
        end
where year(w2.w_time)=2023 
and w2.w_c_id=(
    select c.c_id
    from client c
    where c.c_id_card='420108199702144323');