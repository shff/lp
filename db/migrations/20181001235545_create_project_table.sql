-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

create table project (
  id bigint not null primary key generated by default as identity,
  title varchar(50) not null unique,
  domain varchar(50) null unique,
  deleted_at timestamp without time zone null,
  created_at timestamp without time zone not null default now(),
  updated_at timestamp without time zone not null default now()
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back

drop table project;
