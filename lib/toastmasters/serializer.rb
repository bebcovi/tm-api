require "sequel"
require "yaks"

require "time"
require "json"

require "toastmasters/error"

Dir["#{__dir__}/mappers/*.rb"].each { |f| require(f) }

module Toastmasters
  class Serializer
    CLASSES = [Array, Hash, Sequel::Model, Sequel::Dataset, Toastmasters::Error]

    def self.call(object, request)
      new(request).serialize(object)
    end

    def initialize(request)
      @request = request
    end

    def serialize(object)
      case object
      when Hash, Array
        JSON.pretty_generate(object)
      when Sequel::Dataset
        yaks.call(object.all, env: @request.env)
      when Sequel::Model, Toastmasters::Error
        yaks.call(object, env: @request.env)
      end
    end

    private

    def yaks
      Yaks.new do
        default_format :json_api_with_errors
        mapper_namespace Toastmasters::Mappers
        map_to_primitive Date, Time, &:iso8601
      end
    end
  end
end

module Yaks
  class Format
    class JsonAPIWithErrors < JsonAPI
      register :json_api_with_errors, :json, "application/vnd.api+json"

      def call(resource, env = nil)
        return super if resource.type != "error"
        {errors: resource.seq.map(&:attributes)}
      end
    end
  end
end
