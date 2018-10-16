class Pages::Page < Jennifer::Model::Base
  mapping(
    id: Primary64,
    title: String,
    path: String,
    deleted_at: Time?,
  )

  with_timestamps

  belongs_to :template, Template
  belongs_to :project, Project
  has_many :fields, Field
end
