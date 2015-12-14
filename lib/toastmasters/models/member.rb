require "toastmasters/models/base"

module Toastmasters
  module Models
    class Member < Base
      def validate
        validates_presence [:first_name, :last_name, :email]
        validates_unique :email
      end
    end
  end
end
