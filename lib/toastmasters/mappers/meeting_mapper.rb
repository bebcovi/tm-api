require "toastmasters/mappers/base_mapper"

module Toastmasters
  module Mappers
    class MeetingMapper < BaseMapper
      attributes :id, :date, :note
    end
  end
end
