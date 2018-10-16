class Project < Jennifer::Model::Base
  mapping(
    id: Primary64,
    title: String,
    deleted_at: Time?,
  )

  with_timestamps

  has_many :permissions, Permission
  has_many :pages, Pages::Page
end
