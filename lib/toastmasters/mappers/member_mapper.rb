require "toastmasters/mappers/base_mapper"

module Toastmasters
  module Mappers
    class MemberMapper < BaseMapper
      attributes :id, :first_name, :last_name, :email, :active
    end
  end
end
