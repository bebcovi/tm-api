require "toastmasters/mappers/base_mapper"

module Toastmasters
  module Mappers
    class GuestMapper < BaseMapper
      attributes :id, :first_name, :last_name, :email
    end
  end
end
