require "kemal"
require "jennifer"
require "jennifer/adapter/postgres"
require "jwt"

require "oauth2"
require "crypto/bcrypt"

Jennifer::Config.configure do |config|
  config.from_uri("postgres://root@localhost/roadie")
end

class HTTP::Server
  class Context
    def current_user
      token = request.headers.fetch("Authorization", nil)
      data, header = JWT.decode(token.gsub("Bearer ", ""), ENV["SECRET"], "HS256") if token
      data[:id] if token && data
    end
  end
end

before_all do |env|
  env.response.content_type = "application/json"
end

require "./app/models/**"
require "./app/api/**"

Kemal.run
