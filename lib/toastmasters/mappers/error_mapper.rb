require "toastmasters/mappers/base_mapper"

module Toastmasters
  module Mappers
    class ErrorMapper < BaseMapper
      attributes :id, :status, :title, :meta
    end
  end
end
