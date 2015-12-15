require "toastmasters/models/base"

module Toastmasters
  module Models
    class Participation < Base
      many_to_one :meeting
      many_to_one :member
      many_to_one :guest

      ROLES = [
        "Toastmaster",
        "General Evaluator",
        "Speaker",
        "Evaluator",
        "Table TopicsMaster",
        "Timer",
        "Grammarian",
        "Ah-Counter",
      ]

      def validate
        validates_presence [:meeting_id]
        validates_includes ROLES, :role, allow_nil: true
      end
    end
  end
end
