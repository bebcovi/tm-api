require "bundler/setup"

require "minitest/autorun"
require "minitest/pride"
require "minitest/hooks/test"

require "rack/test_app"

require "./config/sequel"
require "toastmasters"

require "base64"

include Toastmasters
include Toastmasters::Models

module TestHelpers
  def self.included(klass)
    klass.include Minitest::Hooks
    klass.include TestHelpers::Methods
  end

  module Methods
    def around
      DB.transaction(rollback: :always, auto_savepoint: true) { super }
    end

    def app
      @app ||= Rack::TestApp.wrap(Rack::Builder.parse_file("config.ru")[0])
    end

    def auth
      {"HTTP_AUTHORIZATION" => "Basic #{Base64.encode64(Toastmasters::App.opts.values_at(:username, :password).join(":"))}"}
    end
  end
end
