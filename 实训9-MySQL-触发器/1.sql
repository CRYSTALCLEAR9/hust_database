use finance1;
drop trigger if exists before_property_inserted;
delimiter $$
create trigger before_property_inserted before insert on property
for each row 
begin
    declare tp int default new.pro_type;
    declare id int default new.pro_pif_id;
    declare msg char(128) default null;
    if tp=1 then
        if id not in(
            select p_id
            from finances_product) then
                set msg=concat("finances product #",id," not found!");
        end if;
    elseif tp=2 then
        if id not in(
            select i_id
            from insurance) then
                set msg=concat("insurance #",id," not found!");
        end if;
    elseif tp=3 then
        if id not in(
            select f_id
            from fund)then
                set msg=concat("fund #",id," not found!");
        end if;
    else
        set msg=concat("type ",tp," is illegal!");
    end if;
    if msg is not null then
        signal sqlstate "45000" set message_text=msg;
    end if;
end$$
delimiter ;