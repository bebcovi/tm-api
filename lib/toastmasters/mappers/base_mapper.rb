require "yaks"
require "yaks/behaviour/optional_includes"

module Toastmasters
  module Mappers
    class BaseMapper < Yaks::Mapper
      include Yaks::Behaviour::OptionalIncludes
    end
  end
end
