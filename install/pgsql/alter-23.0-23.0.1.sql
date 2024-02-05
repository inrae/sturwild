

alter table sturwild.fish_handling drop CONSTRAINT fish_handling_pk;
alter table sturwild.fish_handling add constraint fish_handling_pk primary key (fish_id, handling_id);

alter table sturwild.declaration_handling drop CONSTRAINT declaration_handling_pk;
alter table sturwild.declaration_handling add constraint declaration_handling_pk primary key (declaration_id, handling_id);
