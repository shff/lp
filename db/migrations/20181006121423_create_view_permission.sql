-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
create view view_permission as
select
  permission.id as id,
  "user".id as user_id,
  project.id as project_id,
  permission.admin as admin,
  "user".email as user_email,
  project.title as project_title,
  project.domain as project_domain
from permission
join "user" on permission.user_id = "user".id
join project on permission.project_id = project.id
where permission.starts_at < now()
and (permission.deleted_at is null or permission.deleted_at > now())
and project.deleted_at is null
and "user".deleted_at is null;

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back

drop view view_permission;
