class Pages::Template < Granite::Base
  adapter pg
  field title : String
  field deleted_at : Time
  timestamps

  belongs_to project : Project
  has_many pages : Page
end
