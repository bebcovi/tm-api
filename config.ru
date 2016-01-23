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

Toastmasters::App.opts[:api_key] = ENV.fetch("API_KEY")

run Toastmasters::App
