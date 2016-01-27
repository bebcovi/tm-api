require "base64"

module Toastmasters
  class Authorization
    def self.basic(value)
      base64 = value.to_s[/^Basic (\w+)/, 1].to_s
      Base64.decode64(base64).split(":")
    end
  end
end
