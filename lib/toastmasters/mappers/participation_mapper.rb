require "toastmasters/mappers/base_mapper"

module Toastmasters
  module Mappers
    class ParticipationMapper < BaseMapper
      attributes :id, :role, :role_data

      has_one :member, if: -> { object.member }
      has_one :guest,  if: -> { object.guest }
    end
  end
end
