require "dotenv"

Dotenv.load! unless ENV["RACK_ENV"] == "production"
