class View::Permission < Granite::Base
  adapter pg
  field admin : Bool
  field user_email : String
  field project_title : String
  field project_domain : String

  belongs_to user : User
  belongs_to project : Project

  def self.of(user_id)
    View::Permission.all("WHERE user_id = ?", user_id)
  end
end
