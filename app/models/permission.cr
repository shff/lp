class Permission < Jennifer::Model::Base
  mapping(
    id: Primary64,
    admin: Bool,
    starts_at: Time,
    deleted_at: Time?,
  )

  with_timestamps

  belongs_to :user, User
  belongs_to :project, Project
end
