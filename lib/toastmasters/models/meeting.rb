require "toastmasters/models/base"

module Toastmasters
  module Models
    class Meeting < Base
      one_to_many :participations
      add_association_dependencies participations: :destroy

      def validate
        validates_presence [:date]
        validates_unique :date
      end
    end
  end
end
