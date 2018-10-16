class User < Jennifer::Model::Base
  mapping(
    id: Primary64,
    email: String,
    password: String,
    deleted_at: Time?,
    updated_at: Time?,
    created_at: Time,
  )

  with_timestamps

  has_many :permissions, Permission

  def hash
    Crypto::Bcrypt::Password.new(raw_hash: password || "")
  end
end
