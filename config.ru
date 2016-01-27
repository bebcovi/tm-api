$LOAD_PATH << "#{__dir__}/lib"

require "./config/sequel"
require "./config/credentials"
require "rack/cors"

require "toastmasters"

unless ENV["RACK_ENV"] == "production"
  use Rack::Cors do
    allow do
      origins '*'
      resource '*', :headers => :any, :methods => :any
    end
  end
end

Toastmasters::App.opts.update(
  username: ENV.fetch("USERNAME"),
  password: ENV.fetch("PASSWORD"),
)

run Toastmasters::App
