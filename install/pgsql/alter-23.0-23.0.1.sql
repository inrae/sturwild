

alter table sturwild.fish_handling drop CONSTRAINT fish_handling_pk;
alter table sturwild.fish_handling add constraint fish_handling_pk primary key (fish_id, handling_id);
