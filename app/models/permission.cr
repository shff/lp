class Permission < Granite::Base
  adapter pg
  field admin : Bool
  field starts_at : Time
  field deleted_at : Time
  timestamps

  belongs_to user : User
  belongs_to project : Project
end
