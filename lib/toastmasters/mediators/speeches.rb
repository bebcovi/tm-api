require "toastmasters/models/speech"

module Toastmasters
  module Mediators
    class Speeches
      def self.all
        Models::Speech.order(:manual_id, :number)
      end
    end
  end
end
