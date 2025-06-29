delimiter $$
create procedure sp_night_shift_arrange(in start_date date,in end_date date)
begin
declare wk,typ int;
declare now_day date default start_date;
declare done boolean default false;
declare nurse1,nurse2,doctor,zhuren char(30);
declare cur1 cursor for select e_name from employee WHERE e_type=3;
declare cur2 cursor for select e_type,e_name from employee WHERE e_type=2 or e_type =1;
declare continue handler for not found set done=true;
open cur1;
open cur2;
while now_day<=end_date do
    fetch cur1 into nurse1;
    if done then
        close cur1;
        open cur1;
        set done=false;
        fetch cur1 into nurse1;
    end if;
    fetch cur1 into nurse2;
    if done then 
        close cur1;
        open cur1;
        set done=false;
        fetch cur1 into nurse2;
    end if;
    set wk=weekday(now_day);
    if wk=0 and zhuren is not null then
        set doctor=zhuren;
        set zhuren=null;
    else 
        fetch cur2 into typ,doctor;
        if done then
            close cur2;
            open cur2;
            set done=false;
            fetch cur2 into typ,doctor;
        end if;
        if wk>=5 and typ=1 then
            set zhuren=doctor;
        fetch cur2 into typ,doctor;
            if done then
                close cur2;
                open cur2;
                set done=false;
                fetch cur2 into typ,doctor;
            end if;
        end if;
    end if;
    insert into night_shift_schedule values(now_day,doctor,nurse1,nurse2);
    set now_day=date_add(now_day,interval 1 day);
end while;
end$$
delimiter;