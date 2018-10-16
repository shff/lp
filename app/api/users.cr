post "/user/signup" do |env|
  email = env.params.body["email"]
  password = env.params.body["password"]

  halt env, 409 if User.where { _email == email }.count > 0

  hash = Crypto::Bcrypt::Password.create(password).to_s
  User.create!(email: email, password: hash)
end

post "/user/login" do |env|
  email = env.params.body["email"]
  password = env.params.body["password"]

  halt env, 403 unless user = User.where { _email == email }.first
  halt env, 403 unless user.hash == password

  JWT.encode({id: user.id}, ENV["SECRET"], "HS256") if user
end

put "/user/password" do |env|
  email = env.params.body["email"]
  password = env.params.body["password"]
  new_password = env.params.body["new_password"]
  hash = Crypto::Bcrypt::Password.create(new_password).to_s

  halt env, 403 unless user = User.where { _email == email }.first
  halt env, 403 unless user.hash == password

  user.update!(password: hash)
end
