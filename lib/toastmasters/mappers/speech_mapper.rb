require "toastmasters/mappers/base_mapper"

module Toastmasters
  module Mappers
    class SpeechMapper < BaseMapper
      attributes :id, :title, :number

      has_one :manual
    end
  end
end
