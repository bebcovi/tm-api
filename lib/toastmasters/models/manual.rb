require "toastmasters/models/base"

module Toastmasters
  module Models
    class Manual < Base
      one_to_many :speeches

      def validate
        validates_presence [:name]
      end
    end
  end
end
