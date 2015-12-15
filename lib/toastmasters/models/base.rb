DB.extension :pg_json
Sequel.extension :pg_json_ops

Sequel::Model.raise_on_save_failure = false
Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :association_dependencies
Sequel::Model.plugin :tactical_eager_loading

module Toastmasters
  module Models
    Base = Sequel::Model
  end
end
