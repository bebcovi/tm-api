require "bundler/setup"

require "minitest/autorun"
require "minitest/pride"
require "minitest/hooks/test"

require "rack/test_app"

require "./config/sequel"
require "toastmasters"

require "base64"

Toastmasters::App.opts.update(
  username: "toastmasters",
  password: "secret",
)

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
      @app ||= Rack::TestApp.wrap(Toastmasters::App)
    end

    def auth
      {"HTTP_AUTHORIZATION" => "Basic #{Base64.encode64("toastmasters:secret")}"}
    end
  end
end
