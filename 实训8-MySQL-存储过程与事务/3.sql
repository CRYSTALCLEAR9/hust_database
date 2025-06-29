use finance1;
delimiter $$
create procedure sp_transfer(in applicant_id int,in source_card_id char(30),in receiver_id int, in dest_card_id char(30),in	amount numeric(10,2),out return_code int)
task_1:
begin
    set autocommit=off;
    start transaction;
    update bank_card set b_balance=b_balance-amount where applicant_id=b_c_id and b_number=source_card_id and b_type='储蓄卡';
    update bank_card set b_balance=b_balance+amount where receiver_id=b_c_id and b_number=dest_card_id and b_type='储蓄卡';
    update bank_card set b_balance=b_balance-amount where b_c_id=receiver_id and b_number=dest_card_id and b_type='信用卡';
    if not exists(
        select *
        from bank_card
        where applicant_id=b_c_id and b_number=source_card_id and b_type='储蓄卡' and b_balance>=0)then
            set return_code=0;
            rollback;
            leave task_1;
    end if;
    if not exists(
        select *
        from bank_card
        where receiver_id=b_c_id and  b_number=dest_card_id)then
            set return_code=0;
            rollback;
        l   eave task_1;
    end if;
    set return_code=1;
    commit;
end$$
delimiter;