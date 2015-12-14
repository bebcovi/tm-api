require "toastmasters/models/base"

module Toastmasters
  module Models
    class Participation < Base
      many_to_one :meeting
      many_to_one :member
      many_to_one :guest

      def validate
        validates_presence [:meeting_id]
      end
    end
  end
end
