require "toastmasters/models/member"
require "toastmasters/error"

module Toastmasters
  module Mediators
    class Members
      def self.all(params = {})
        Models::Member.order(:last_name)
      end

      def self.find(id)
        Models::Member[id] or raise Toastmasters::Error::ResourceNotFound
      end

      def self.speeches(id)
        find(id).speeches
      end

      def self.create(attributes)
        member = Models::Member.new(attributes)
        member.save or raise Toastmasters::Error::ValidationFailed, member.errors
      end

      def self.update(id, attributes)
        member = find(id)
        member.set(attributes)
        member.save or raise Toastmasters::Error::ValidationFailed, member.errors
      end

      def self.delete(id)
        find(id).destroy
      end
    end
  end
end
