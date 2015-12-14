module Toastmasters
  class JsonApi
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def attributes(name)
      data = params[:data]
      attributes = data[:attributes]

      (data[:relationships] || {}).each do |rel_name, value|
        attributes[:"#{rel_name}_id"] = value[:data][:id]
      end

      symbolize_keys(attributes)
    end

    private

    def symbolize_keys(params)
      case params
      when Hash
        hash = {}
        params.each { |k, v| hash[k.to_sym] = symbolize_keys(v) }
        hash
      when Array
        params.map { |x| symbolize_keys(x) }
      else
        params
      end
    end
  end
end
