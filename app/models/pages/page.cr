class Pages::Page < Granite::Base
  adapter pg
  field title : String
  field path : String
  field deleted_at : Time
  timestamps

  belongs_to template : Template
  belongs_to project : Project
  has_many fields : Field
end
