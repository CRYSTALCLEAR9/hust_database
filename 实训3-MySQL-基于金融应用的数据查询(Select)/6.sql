select pro_income,count(*) as presence
from property
group by pro_income
having count(*)=(
    select max(cnt)
    from(
        select count(*) as cnt
        from property
        group by pro_income
    )as sub
);