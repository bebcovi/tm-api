require "toastmasters/models/meeting"

module Toastmasters
  module Mediators
    class Meetings
      def self.all(params = {})
        Models::Meeting.reverse_order(:date)
      end

      def self.find(id)
        Models::Meeting[id] or raise Toastmasters::Error::ResourceNotFound
      end

      def self.create(attributes)
        meeting = Models::Meeting.new(attributes)
        meeting.save or raise Toastmasters::Error::ValidationFailed, meeting.errors
      end

      def self.update(id, attributes)
        meeting = find(id)
        meeting.set(attributes)
        meeting.save or raise Toastmasters::Error::ValidationFailed, meeting.errors
      end

      def self.delete(id)
        find(id).destroy
      end
    end
  end
end
