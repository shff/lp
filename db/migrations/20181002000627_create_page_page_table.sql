-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

create table page_page (
  id bigint not null primary key generated by default as identity,
  project_id bigint not null references project(id),
  template_id bigint not null references page_template(id),
  title varchar(50) not null unique,
  path varchar(50) not null unique,
  deleted_at timestamp without time zone null,
  created_at timestamp without time zone not null default now(),
  updated_at timestamp without time zone not null default now()
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back

drop table page_page;
