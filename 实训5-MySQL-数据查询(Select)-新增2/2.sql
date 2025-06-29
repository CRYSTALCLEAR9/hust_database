with valid_wages as(
    select w.w_org,w.w_amount,w.w_c_id,w.w_time
    from wage w
    inner join client c on w.w_c_id=c.c_id
    where w.w_type!=2
),employee_avg_wages as(
    select w_org,w_c_id,round(avg(w_amount),2) as emp_avg_wage
    from valid_wages
    group by w_org, w_c_id
),wage_with_rank as(
    select w_org,w_c_id,emp_avg_wage,row_number() over(partition by w_org order by emp_avg_wage) as rn,count(*) over(partition by w_org) as total_count
    from employee_avg_wages
),org_basic_stats as(
    select w_org,sum(w_amount) as total_amount,count(distinct w_c_id) as employee_count,count(distinct date_format(w_time,'%Y-%m')) as month_count,
        max(w_amount) as max_wage,min(w_amount) as min_wage
    from valid_wages
    group by w_org
),median_wages as(
    select w_org,
        case 
            when total_count%2=1 then
                max(case when rn=ceil(total_count/2.0) then emp_avg_wage end)
            else
                round(avg(case when rn in(total_count/2,total_count/2+1) then emp_avg_wage end),2)
        end as mid_wage
    from wage_with_rank
    group by w_org
)
select obs.w_org,obs.total_amount,round(obs.total_amount/(obs.employee_count*obs.month_count),2) as average_wage,obs.max_wage,obs.min_wage,mw.mid_wage
from org_basic_stats obs
join median_wages mw on obs.w_org=mw.w_org
order by obs.total_amount desc;