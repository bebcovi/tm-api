require "sequel"
require "yaml"

db_config = YAML.load_file("config/database.yml")
db_config = db_config.fetch(ENV["RACK_ENV"] || "development")

DB = Sequel.connect(db_config)
DB.test_connection
