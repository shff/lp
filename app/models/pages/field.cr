class Pages::Field < Granite::Base
  adapter pg
  field title : String
  field kind : String
  field deleted_at : Time
  timestamps

  has_many options : Option
  belongs_to page : Page
end
