class Project < Granite::Base
  adapter pg
  field title : String
  field deleted_at : Time
  timestamps

  has_many permissions : Permission
  has_many pages : Page
end
