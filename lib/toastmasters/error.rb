module Toastmasters
  class Error < StandardError
    def initialize(*)
      @status ||= 400
      @meta   ||= {}
      super
    end

    alias title message

    attr_reader :id, :status, :meta
  end

  class Error
    class MissingParam < Error
      def initialize(key)
        @id = "param_missing"
        super("Missing param \"#{key}\"")
      end
    end

    class Unauthorized < Error
      def initialize(*)
        @id = "unauthorized"
        @status = 401
        super("The request requires authentication")
      end
    end

    class ResourceNotFound < Error
      def initialize(*)
        @id = "resource_not_found"
        @status = 404
        super("Resource not found")
      end
    end

    class PageNotFound < Error
      def initialize(path)
        @id = "page_not_found"
        @status = 404
        super("Route not found: #{path}")
      end
    end

    class ValidationFailed < Error
      def initialize(errors)
        @id = "validation_failed"
        @meta = {errors: errors}
        super("Resource validation has failed")
      end
    end

    class InvalidAttribute < Error
      def initialize(message)
        @id = "invalid_attribute"
        super(message)
      end
    end
  end
end
