class Pages::Template < Jennifer::Model::Base
  mapping(
    id: Primary64,
    title: String,
    deleted_at: Time?,
  )

  with_timestamps

  belongs_to :project, Project
  has_many :pages, Page
end
