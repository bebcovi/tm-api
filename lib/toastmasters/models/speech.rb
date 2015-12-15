require "toastmasters/models/base"

module Toastmasters
  module Models
    class Speech < Base
      many_to_one :manual

      def validate
        validates_presence [:title, :number]
        validates_unique [:number, :manual_id]
      end
    end
  end
end
