require "toastmasters/models/base"

module Toastmasters
  module Models
    class Member < Base
      one_to_many :participations
      add_association_dependencies participations: :destroy

      def validate
        validates_presence [:first_name, :last_name]
        validates_unique :email, allow_nil: true
      end
    end
  end
end
