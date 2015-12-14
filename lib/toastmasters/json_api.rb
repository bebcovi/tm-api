module Toastmasters
  class JsonApi
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def attributes(name)
      params[:data][:attributes]
    end
  end
end
