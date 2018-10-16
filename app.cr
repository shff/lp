require "raze"
require "granite"
require "granite/adapter/pg"
require "jwt"
require "oauth2"
require "crypto/bcrypt"

Granite::Adapters << Granite::Adapter::Pg.new({name: "pg", url: ENV["DATABASE_URL"]})

class String
  def to_hash
    Crypto::Bcrypt::Password.create(self).to_s
  end
end

class HTTP::Server
  class Context
    def current_user
      token = request.headers.fetch("Authorization", nil)
      data, header = JWT.decode(token.lchop("Bearer "), ENV["SECRET"], "HS256") if token
      data["id"].to_s if data
    end
  end
end

class User < Granite::Base
  adapter pg
  field email : String
  field password : String
  field deleted_at : Time
  timestamps

  has_many permissions : Permission

  def hash
    Crypto::Bcrypt::Password.new(raw_hash: password || "")
  end
end

class Permission < Granite::Base
  adapter pg
  field admin : Bool
  field starts_at : Time
  field deleted_at : Time
  timestamps

  belongs_to user : User
  belongs_to project : Project
end

class Project < Granite::Base
  adapter pg
  field title : String
  field deleted_at : Time
  timestamps

  has_many permissions : Permission
  has_many pages : Page
end

class View::Permission < Granite::Base
  adapter pg
  field admin : Bool
  field user_email : String
  field project_title : String
  field project_domain : String

  belongs_to user : User
  belongs_to project : Project

  def self.of(user_id)
    View::Permission.all("WHERE user_id = ?", user_id)
  end
end

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

class Pages::Field < Granite::Base
  adapter pg
  field title : String
  field kind : String
  field deleted_at : Time
  timestamps

  has_many options : Option
  belongs_to page : Page
end

class Pages::Option < Granite::Base
  adapter pg
  field content : String
  field deleted_at : Time
  timestamps

  belongs_to field : Field
end

class Pages::Template < Granite::Base
  adapter pg
  field title : String
  field deleted_at : Time
  timestamps

  belongs_to project : Project
  has_many pages : Page
end

post "/user/signup" do |ctx|
  body = JSON.parse(ctx.request.body.not_nil!.gets_to_end)
  email = body["email"].to_s
  password = body["password"].to_s

  ctx.halt "error", 409 if User.first("WHERE email = ?", email)

  User.create!(email: email, password: password.to_hash)
  "ok"
end

post "/user/login" do |ctx|
  body = JSON.parse(ctx.request.body.not_nil!.gets_to_end)
  email = body["email"].to_s
  password = body["password"].to_s

  ctx.halt "error", 409 unless user = User.first("WHERE email = ?", email)
  ctx.halt "error", 403 unless user.hash == password

  JWT.encode({id: user.id}, ENV["SECRET"], "HS256") if user
end

put "/user/password" do |ctx|
  body = JSON.parse(ctx.request.body.not_nil!.gets_to_end)
  email = body["email"].to_s
  password = body["password"].to_s
  new_password = body["new_password"].to_s

  ctx.halt "error", 409 unless user = User.first("WHERE email = ?", email)
  ctx.halt "error", 403 unless user.hash == password

  # user.update!(password: new_password.to_hash)
end

get "/projects" do |env|
  View::Permission.of(env.current_user).to_json
end

Raze.run
