require "toastmasters/models/participation"

module Toastmasters
  module Mediators
    module Participations
      def self.all(params = {})
        Models::Participation.where(meeting_id: params[:meeting_id])
      end

      def self.create(meeting_id, attributes)
        participation = Models::Participation.new(attributes.merge(meeting_id: meeting_id))
        participation.save or raise Toastmasters::Error::ValidationFailed, participation.errors
      end

      def self.update(id, attributes)
        participation = Models::Participation[id] or raise Toastmasters::Error::ResourceNotFound
        participation.set(attributes)
        participation.save or raise Toastmasters::Error::ValidationFailed, participation.errors
      end

      def self.delete(id)
        Models::Participation[id].destroy
      end
    end
  end
end
