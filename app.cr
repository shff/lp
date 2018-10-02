require "kemal"
require "granite"
require "granite/adapter/pg"
require "jwt"
require "dotenv"

require "oauth2"
require "crypto/bcrypt"

Dotenv.load!
Granite::Adapters << Granite::Adapter::Pg.new({name: "pg", url: ENV["DATABASE_URL"]})

def current_user(env)
  token = env.request.headers["Authorization"].gsub("Bearer ", "")
  data, header = JWT.decode(token, ENV["SECRET"], "HS256")
  data["id"]
end

require "./app/models/**"
require "./app/api/**"

Kemal.run
