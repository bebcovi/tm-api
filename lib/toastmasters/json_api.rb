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

      attributes
    end
  end
end
