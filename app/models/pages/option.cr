class Pages::Option < Granite::Base
  adapter pg
  field content : String
  field deleted_at : Time
  timestamps

  belongs_to field : Field
end
