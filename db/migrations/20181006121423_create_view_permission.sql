-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
create view v_user_projects as
select
  permissions.id as id,
  users.id as user_id,
  projects.id as project_id,
  permissions.admin as admin,
  users.email as user_email,
  projects.title as project_title,
  projects.domain as project_domain
from permissions
join users on permissions.user_id = users.id
join projects on permissions.project_id = projects.id
where permissions.starts_at < now()
and (permissions.deleted_at is null or permissions.deleted_at > now())
and projects.deleted_at is null
and users.deleted_at is null;

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back

drop view v_user_projects;
