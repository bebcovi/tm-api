require "toastmasters/models/participation"

module Toastmasters
  module Mediators
    module Participations
      def self.all(params = {})
        Models::Participation.where(meeting_id: params[:meeting_id])
      end

      def self.find(id)
        Models::Participation[id] or raise Toastmasters::Error::ResourceNotFound
      end

      def self.create(meeting_id, attributes)
        participation = Models::Participation.new(attributes.merge(meeting_id: meeting_id))
        participation.save or raise Toastmasters::Error::ValidationFailed, participation.errors
      end

      def self.update(id, attributes)
        participation = find(id)
        participation.set(attributes)
        participation.save or raise Toastmasters::Error::ValidationFailed, participation.errors
      end

      def self.delete(id)
        find(id).destroy
      end
    end
  end
end
