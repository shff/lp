class Pages::Option < Jennifer::Model::Base
  mapping(
    id: Primary64,
    content: String,
    deleted_at: Time?,
  )

  with_timestamps

  belongs_to :field, Field
end
