require "toastmasters/mappers/base_mapper"

module Toastmasters
  module Mappers
    class ManualMapper < BaseMapper
      attributes :id, :name
    end
  end
end
