class Pages::Field < Jennifer::Model::Base
  mapping(
    id: Primary64,
    title: String,
    kind: String,
    deleted_at: Time?,
  )

  with_timestamps

  has_many :options, Option
  belongs_to :page, Page
end
