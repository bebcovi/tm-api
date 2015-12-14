require "toastmasters/models/base"

module Toastmasters
  module Models
    class Meeting < Base
      def validate
        validates_presence [:date]
        validates_unique :date
      end
    end
  end
end
