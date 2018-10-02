class User < Granite::Base
  adapter pg
  field email : String
  field password : String
  field deleted_at : Time
  timestamps

  has_many permissions : Permission

  def self.try(email, pass)
    user = User.first("WHERE email = ?", email)
    user if user && Crypto::Bcrypt::Password.new(raw_hash: user.password || "") == pass
  end
end
