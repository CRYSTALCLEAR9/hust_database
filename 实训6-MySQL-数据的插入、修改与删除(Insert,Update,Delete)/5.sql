use finance1;
update property
set pro_status='冻结'
where pro_c_id in(
    select c_id
    from client
    where c_phone='13686431238'
);