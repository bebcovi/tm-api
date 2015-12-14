DB.extension :pg_json

Sequel::Model.raise_on_save_failure = false
Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :association_dependencies

module Toastmasters
  module Models
    Base = Sequel::Model
  end
end
