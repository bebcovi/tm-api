require "bundler/setup"

require "minitest/autorun"
require "minitest/pride"
require "minitest/hooks/test"

require "rack/test_app"

require "./config/sequel"
require "toastmasters"

Toastmasters::App.opts[:api_key] = "TEST_KEY"

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
      {'HTTP_X_API_KEY' => "TEST_KEY"}
    end
  end
end
