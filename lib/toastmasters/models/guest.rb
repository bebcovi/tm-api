require "toastmasters/models/base"

module Toastmasters
  module Models
    class Guest < Base
      def validate
        validates_presence [:first_name, :last_name]
        validates_unique :email, allow_nil: true
      end
    end
  end
end
