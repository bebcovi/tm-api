$LOAD_PATH << "#{__dir__}/lib"

require "./config/sequel"
require "./config/credentials"

require "toastmasters"

Toastmasters::App.opts[:api_key] = ENV.fetch("API_KEY")

run Toastmasters::App
