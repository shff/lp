get "/projects" do |env|
  View::Permission.of(current_user(env)).to_json
end
