use finance1;
delete from client
where c_id not in(
    select b_c_id
    from bank_card
);