use finance1;
update property
set pro_id_card=(
    select c_id_card
    from client
    where pro_c_id=c_id
);