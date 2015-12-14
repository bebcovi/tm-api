require "toastmasters/models/guest"
require "toastmasters/error"

module Toastmasters
  module Mediators
    class Guests
      def self.all(params = {})
        Models::Guest.order(:last_name)
      end

      def self.find(id)
        Models::Guest[id] or raise Toastmasters::Error::ResourceNotFound
      end

      def self.create(attributes)
        guest = Models::Guest.find(attributes) || Models::Guest.new(attributes)
        guest.save or raise Toastmasters::Error::ValidationFailed, guest.errors
      end

      def self.update(id, attributes)
        guest = Models::Guest[id] or raise Toastmasters::Error::ResourceNotFound
        guest.set(attributes)
        guest.save or raise Toastmasters::Error::ValidationFailed, guest.errors
      end

      def self.delete(id)
        Models::Guest[id].destroy
      end
    end
  end
end

