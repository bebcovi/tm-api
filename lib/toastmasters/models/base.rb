Sequel::Model.raise_on_save_failure = false

Sequel::Model.plugin :validation_helpers

module Toastmasters
  module Models
    Base = Sequel::Model
  end
end
