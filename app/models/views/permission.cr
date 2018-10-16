class Views::VUserProjects < Jennifer::Model::Base
  mapping(
    id: Primary64,
    user_id: Int64,
    project_id: Int64,
    admin: Bool,
    user_email: String,
    project_title: String,
    project_domain: String,
  )

  with_timestamps

  belongs_to :user, User
  belongs_to :project, Project

  def to_json(json : JSON::Builder)
    json.object do
      json.field "project_id", @project_id
      json.field "admin", @admin
      json.field "project_title", @project_title
    end
  end
end
